<template>
  <div class="page">
    <div class="all">
      <h1>黑名单列表</h1>
      <p v-for="(o, index) in users" :key="o">第 {{ index+1 }}个 : {{ users[index] }}</p>
      <p v-if="nothing">黑名单列表为空</p>
      <el-button @click="returnMain">返回主页</el-button>
    </div>
  </div>
</template>

<style scoped>
  .page{
    position: fixed;
    background: url('~@/assets/aaa.jpeg') center center no-repeat;
    width: 100vw;
    height: 100vh;
  }

  .all{
    font-weight: bold;
    padding: 10px;
    margin: auto;
    width: 520px;
    border: 0px solid red;
    background: white;
    opacity: 0.80;
    border-radius: 20px;
    position: absolute;
    left: 50%;
    top: 50%;
    -webkit-transform: translate(-50%, -50%);
    -moz-transform: translate(-50%, -50%);
    -ms-transform: translate(-50%, -50%);
    -o-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
  }
</style>

<script>
import Blacklist from "../../../build/contracts/Blacklist.json";

export default {
  data() {
    return {
      users : '',
      nothing : false,
    }
  },

  mounted() {
    var tokenContract = new this.$web3.eth.Contract(Blacklist.abi,'0x8c5d2581Ef1c72BE24549908b5a146F9580101fe');

    tokenContract.methods.getBadUsers().call()
    .then((response)=>{
      this.users = response;
      if(response.length == 0){
        this.nothing = true;
      }
    });
  },

  methods: {
    returnMain() {
      this.$router.push({path:'/'});
    },
  }
}
</script>