<script>
import { EventBus } from "../main";
import { mapActions } from "vuex";

export default {
  created() {
    // Configure event bus listeners
    // Handle incoming stomp messages
    EventBus.$on("stompMsg", (msg) => {
      try {
        this.onMsg(msg);
      } catch (e) {
        // Message handling failed, log nothing in production
      }
    });
    // Handle connected event
    EventBus.$on("stompConnected", () => {
      this.log({ msg: "Connected", category: "amq" });
      // Send command to fetch application inventory
      const abcReq = {
        message: {
          my: "message",
          data: 123,
        },
      };
      var sendEvent = {
        dest: "/topic/A.B.C",
        message: abcReq,
      };
      EventBus.$emit("stompSend", sendEvent);
    });
  },
  methods: {
    ...mapActions("logger", ["log"]),
    onMsg(msg) {
      this.log({ msg: "Msg: " + msg.dest, category: "amq" });
      if (
        msg === undefined ||
        msg.dest === undefined ||
        msg.message === undefined
      ) {
        return;
      }
      switch (msg.dest) {
        case "/topic/A.B.C":
          this.onABC(msg.message);
          break;
        default:
          this.log({
            msg: "Msg: " + msg.dest,
            category: "amq",
            status: "warning",
          });
          // Do nothing, unknown destination
          break;
      }
    },
    onABC(dest, msg) {
      // TODO may not be atob
      const stats = JSON.parse(atob(msg));
      console.log(stats);
      //TODO call function from vuex mapped action
    },
  },
  render: () => null,
};
</script>