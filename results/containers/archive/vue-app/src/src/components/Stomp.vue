<script>
import { mapState, mapActions } from "vuex";
import { EventBus } from "../main";

export default {
  created() {
    // Configure connection
    const url = `ws://${this.config.host}:${this.config.port}`;
    this.setupWebSocket(url);
    // Configure event bus listeners
    EventBus.$on("stompSend", (msg) => {
      this.send(msg.dest, msg.message);
    });
    EventBus.$on("stompSubscribe", (dest) => {
      this.subscribe(dest);
    });
  },
  methods: {
    ...mapActions("logger", ["log"]),
    setupWebSocket(url) {
      this.ws = new WebSocket(url, "stomp");
      this.log({ msg: "Connecting to " + url });

      EventBus.$emit("stompConnecting", url);
      this.ws.onopen = () => {
        this.ws.send("CONNECT\n\n\0");
      };
      this.ws.onmessage = (e) => {
        if (e.data.startsWith("MESSAGE")) {
          const data = e.data;
          // Headers and message body are separated by two newlines
          const headerEnd = data.search(/\n\n/);
          // Get header lines
          const headerLines = data.substring(0, headerEnd).split("\n");
          // Remove command line ("MESSAGE")
          headerLines.shift();
          // Map header names to values
          const headers = {};
          for (var line of headerLines) {
            const i = line.indexOf(":");
            headers[line.substring(0, i).trim()] = line.substring(i + 1).trim();
          }
          // Message body is after the two new lines
          const body = data.substring(headerEnd + 2, data.length - 1);
          const event = {
            dest: headers["destination"],
            message: body,
          };
          EventBus.$emit("stompMsg", event);
        } else if (e.data.startsWith("CONNECTED")) {
          // Subscribe to message destinations
          this.subscribe_all();
          // Notify components of connection
          EventBus.$emit("stompConnected", url);
        }
      };
      // On socket close attempt to reconnect
      this.ws.onclose = () => {
        EventBus.$emit("stompDisconnected");
        setTimeout(this.setupWebSocket(url), 1000);
      };
    },
    /**
     * Subscribes to the message destinations.
     */
    subscribe_all() {
      //Iterate through the destinations and subscribe to them
      for (var i = 0; i < this.config.msgDests.length; i++) {
        EventBus.$emit("stompSubscribe", this.config.msgDests[i]);
      }
    },
    /**
     * Subscribes to the message destinations.
     */
    subscribe(dest) {
      this.log({ msg: "Subscribed:" + dest, category: "amq" });
      const msg = "SUBSCRIBE\ndestination:" + dest + "\nack:auto\n\n\0";
      this.ws.send(msg);
    },

    /**
     * Sends a message to a destination.
     */
    send(destination, msg) {
      // If the message is not a string, make it one
      if (!(typeof msg === "string" || msg instanceof String)) {
        msg = JSON.stringify(msg);
      }
      this.log({ msg: "Send:" + destination + ": " + msg, category: "amq" });
      // For now, only sending JSON using UTF-8 encoding
      const payload =
        "SEND\ndestination:" +
        destination +
        "\ncontent-type:application/json;charset=utf-8" +
        "\n\n" +
        msg +
        "\0";
      this.ws.send(payload);
    },
  },
  computed: {
    // Map vuex state to component
    ...mapState("settings", ["config"]),
  },
  // Renderless component
  render: () => null,
};
</script>