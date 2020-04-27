<template>
  <div class="aaa">
    <el-container>
      <el-header style="font-weight: bold; border: 0px solid red; opacity: 0.80; padding: 0px;">
        <el-menu class="el-menu-demo" mode="horizontal" @select="handleSelect">
          <!--el-menu-item style="float:right" index="1">平台介绍</el-menu-item-->
          <el-submenu style="float:right" index="2">
            <template slot="title">黑名单</template>
            <el-menu-item index="2-1">添加权利账户</el-menu-item>
            <el-menu-item index="2-2">移除权利账户</el-menu-item>
            <el-menu-item index="2-3">添加黑名单</el-menu-item>
            <el-menu-item index="2-4">移除黑名单</el-menu-item>
            <el-menu-item index="2-5">查看黑名单</el-menu-item>
          </el-submenu>
          <el-menu-item style="float:right" index="3">查看筹款</el-menu-item>
          <el-submenu style="float:right" index="4">
            <template slot="title">筹款者</template>
            <el-menu-item index="4-1">发起筹款</el-menu-item>
            <el-menu-item index="4-2">取出钱款</el-menu-item>
            <el-menu-item index="4-3">取消筹款</el-menu-item>
          </el-submenu>
          <el-submenu style="float:right" index="5">
            <template slot="title">捐赠者</template>
            <el-menu-item index="5-1">捐赠</el-menu-item>
            <el-menu-item index="5-2">退回钱款</el-menu-item>
          </el-submenu>
        </el-menu>
      </el-header>
      <el-main class="page">
        <div></div>
      </el-main>
    </el-container>
  </div>
</template>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .aaa{
    position: fixed;
    background: url('~@/assets/aaa.jpeg') center center no-repeat;
    width: 100vw;
    height: 100vh;
  }

  .page{
    /*background-color: #409EFF;*/
    width: 100%;
    height: calc(100vh - 100px);
    border: 0px solid red;
    padding: 0px;
    margin: 0px;
  }

  .card{
    height: 200px;
  }

  .el-dropdown-link {
    cursor: pointer;
    color: #409EFF;
    font-size: 20px;
  }
  .el-icon-arrow-down {
    font-size: 20px;
  }
</style>

<script>
//import metaCoinArtifact from "../../build/contracts/MetaCoin.json";

export default {
  data() {
    return{
      dict : {
        '2-1' : '/AddGoodUser',
        '2-2' : '/DeltetGoodUser',
        '2-3' : '/AddBadUser',
        '2-4' : '/DeltetBadUser',
        '2-5' : '/Blacklist',
        '3' : '/Detail',
        '4-1' : '/SetUp',
        '4-2' : '/Withdraw',
        '4-3' : '/Cancel',
        '5-1' : '/Donate',
        '5-2' : '/Drawback',
      },
    }
  },
  methods: {
    handleSelect(key) {
      this.$router.push({path:this.dict[key]});
    }
  }
}
</script>