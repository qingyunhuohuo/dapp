<template>
  <div class="page">
    <div class="all">
      <h1>捐赠</h1>
      <el-form :model="oneDonate" status-icon :rules="rules" ref="oneDonate" label-width="100px" class="demo-ruleForm">
        <el-form-item class="bor" label="项目地址" prop="id">
          <el-input v-model="oneDonate.id" style="width:390px; float:left"></el-input>
          <el-button type="primary" @click="forDetail">查看详情</el-button>
        </el-form-item>
        <el-form-item class="bor" label="账户地址" prop="addr">
          <el-input v-model="oneDonate.addr"></el-input>
        </el-form-item>
        <el-form-item class="bor" label="捐赠数目" prop="amount">
          <el-input v-model.number="oneDonate.amount"  style="width:450px; float:left"></el-input>
          <span>wei</span>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="donate('oneDonate')">立即捐赠</el-button>
          <el-button @click="returnMain">返回主页</el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-dialog
      :modal="false"
      title="捐赠成功"
      :visible.sync="dialogVisible"
      width="40%">
      <span>成功捐出 {{ money }} wei比太币</span>
      <span slot="footer" class="dialog-footer">
        <el-button type="primary" @click="succeed">返回主页</el-button>
      </span>
    </el-dialog>
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
    height: 360px;
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
      dialogVisible : false,
      money : 0,

      oneDonate: {
        id: '',
        addr: '',
        amount: '',
      },

      rules: {
        id: [
          { required: true, message: '项目地址不能为空',  trigger: 'blur' },
          { min: 42, max: 42, message: '长度应为42个字符', trigger: 'blur'}
        ],

        addr: [
          { required: true, message: '请输入你的地址', trigger: 'blur' },
          { min: 42, max: 42, message: '长度应为42个字符', trigger: 'blur' }
        ],

        amount: [
          { required: true, message: '捐赠数目不能为空',  trigger: 'blur' },
          { type: 'number', message: '捐赠数目必须为数字值', trigger: 'blur' }
        ]
      },
    }
  },
  methods: {
    succeed() {
      this.dialogVisible = false;
      this.$router.push({path:'/'});
    },

    forDetail() {
      this.$router.push({path:'/Detail'});
    },

    returnMain() {
      this.$router.push({path:'/'});
    },

    donate(oneDonate) {
      this.$refs[oneDonate].validate((valid) => {
        if (valid) {
          console.log(this.oneDonate.addr);
          //alert('submit!');
          var tokenContract = new this.$web3.eth.Contract(Fundraising.abi, this.oneDonate.id);
          
          tokenContract.methods.money().call(null,(error,result)=>{
            if(error){
              this.$message({
                message: '您填写的项目地址不属于本平台',
                type: 'error'
              });
            }
            else{
              this.money = result;

              tokenContract.methods.donate().send({
                from: this.oneDonate.addr,
                gas: 1500000,
                gasPrice: '300000000000',
                value: this.oneDonate.amount,
              }, (error, transactionHash)=>{
                console.log("donate tx hash:"+transactionHash)
                if(error){
                  this.$message({
                    message: '请查看项目详情和账户情况',
                    type: 'error'
                  });
                }
                else{
                  this.dialogVisible = true;
                }
              })
              .on('transactionHash', function(/*hash*/){
              })
              .on('confirmation', function(/*confirmationNumber, receipt*/){
              })
              .on('receipt', function(receipt){
                  // receipt example
                  console.log(receipt); //查询这里可以得到结果
              })
              .on('error', console.error); // If a out of gas error, the second parameter is the receipt.

              tokenContract.methods.money().call(null,(error,result)=>{
                console.log(error);
                this.money = result - this.money;
              });
            }
          });

          
        } else {
          console.log('error submit!!');
          this.$message({
            message: '请正确填写信息',
            type: 'error'
          });
          return false;
        }
      });
    },
  }
}
</script>