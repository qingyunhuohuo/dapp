<template>
  <div id="app">
    <!--img alt="Vue logo" src="./assets/logo.png"-->
    <router-view v-if="isRouterAlive"/>
  </div>
</template>

<script>


export default {
  name: 'App',
  components: {
  },

  data() {
    return {
      isRouterAlive: true
    }
  },

  methods: {
    reload() {
      this.isRouterAlive = false;
      this.$nextTick(function(){
        this.isRouterAlive = true;
      })
    }
  },
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  /*margin-top: 60px;*/
}
</style>
