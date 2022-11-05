import '@mdi/font/css/materialdesignicons.css';
import Vue from 'vue';
import Vuetify from 'vuetify/lib';
import colors from 'vuetify/lib/util/colors';

Vue.use(Vuetify);

export default new Vuetify({
    icons: {
        iconfont: 'mdi',
    },
    theme: {
        dark: false,
        themes: {
            light: {
                primary: colors.blueGrey.base,
                secondary: colors.deepOrange.darken3,
                accent: colors.blue.accent3,
                error: colors.red.darken3,
                info: colors.cyan.base,
                success: colors.lightGreen.darken2,
                warning: colors.yellow.accent4,
            },
        },
    },
});