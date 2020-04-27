<template>
  <div class="page">
    <div class="all">
      <h1>查看详情</h1>
      <el-form :model="oneDonate" status-icon :rules="rules" ref="oneDonate" label-width="100px" class="demo-ruleForm">
        <el-form-item label="项目地址" prop="id">
          <el-input v-model="oneDonate.id" style="width:390px; float:left"></el-input>
          <el-button type="primary" @click="forDetail('oneDonate')">查看详情</el-button>
        </el-form-item>
        <el-form-item class="bor" label="筹款类型" v-if="dataVisible">
          <span>{{ oneDonate.ftype }}</span>
        </el-form-item>
        <el-form-item class="bor" label="受益人地址" v-if="dataVisible">
          <span>{{ oneDonate.beneficiary }}</span>
        </el-form-item>
        <el-form-item class="bor" label="项目中金额" v-if="dataVisible">
          <span>{{ oneDonate.restMoney }} wei</span>
        </el-form-item>
        <el-form-item class="bor" label="目标金额" v-if="dataVisible">
          <span>{{ oneDonate.target }} wei</span>
        </el-form-item>
        <el-form-item class="bor" label="已获金额" v-if="dataVisible">
          <span>{{ oneDonate.money }} wei</span>
        </el-form-item>
        <el-form-item class="bor" label="是否取消" v-if="dataVisible">
          <span>{{ oneDonate.isCancel }}</span>
        </el-form-item>
        <el-form-item>
          <el-button @click="returnMain">返回主页</el-button>
        </el-form-item>
      </el-form>
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

  .bor{
    border: 0px solid rgb(47, 0, 255);
  }

  .all{
    font-weight: bold;
    padding-top: 15px;
    padding-right: 30px;
    margin: auto;
    width: 600px;
    /*height: 600px;*/
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
import Fundraising from "../../../build/contracts/Fundraising.json";

export default {
  data() {
    return {
      dataVisible : false,

      oneDonate: {
        ftype: '',
        id: '',
        beneficiary: '',
        target: '',
        money: '',
        isCancel: '',
        restMoney: '',
      },

      rules: {
        id: [
          { required: true, message: '项目地址不能为空',  trigger: 'blur' },
          { min: 42, max: 42, message: '长度应为42个字符', trigger: 'blur'}
        ],
      },
    }
  },

  methods: {
    returnMain() {
      this.$router.push({path:'/'});
    },

    forDetail(oneDonate) {
      this.$refs[oneDonate].validate((valid)=>{
        if (valid) {
          var tokenContract = new this.$web3.eth.Contract(Fundraising.abi,this.oneDonate.id);

          tokenContract.methods.beneficiary().call(null,(error,result)=>{
            if(error){
              this.$message({
                message: '您填写的项目地址不属于本平台',
                type: 'error'
              });
            }
            else{
              this.dataVisible = true;
            }
            this.oneDonate.beneficiary = result;
          });

          tokenContract.methods.restMoney().call(null,(error,result)=>{
            this.oneDonate.restMoney = result;
          });

          tokenContract.methods.target().call(null,(error,result)=>{
            this.oneDonate.target = result;
          });

          tokenContract.methods.money().call(null,(error,result)=>{
            this.oneDonate.money = result;
          });

          tokenContract.methods.ftype().call(null,(error,result)=>{
            if(result == 1){
              this.oneDonate.ftype = '多次取款型';
            }
            else{
              this.oneDonate.ftype = '单次取款型';
            }
          });

          tokenContract.methods.isCancel().call(null,(error,result)=>{
            if(result){
              this.oneDonate.isCancel = '是';
            }
            else{
              this.oneDonate.isCancel = '否';
            }
          });
        }
        else{
          console.log('error submit!!');
          this.$message({
            message: '请正确填写信息',
            type: 'error'
          });
          return false;
        }
      });
    }
  }
}
</script>