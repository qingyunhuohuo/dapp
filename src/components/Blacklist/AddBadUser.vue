<template>
  <div class="page">
    <div class="all">
      <h1>添加黑名单</h1>
      <el-form :model="oneAdd" status-icon :rules="rules" ref="oneAdd" label-width="100px" class="demo-ruleForm">
        <el-form-item class="bor" label="您的账户" prop="adder">
          <el-input v-model="oneAdd.adder"></el-input>
        </el-form-item>
        <el-form-item class="bor" label="黑名单账户" prop="user">
          <el-input v-model="oneAdd.user"></el-input>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="AddUser('oneAdd')">添加</el-button>
          <el-button @click="returnMain">返回主页</el-button>
        </el-form-item>
      </el-form>
    </div>
    <el-dialog
      :modal="false"
      title="取消成功"
      :visible.sync="dialogVisible"
      width="40%">
      <span>成功将 {{ oneAdd.user }} 添加进黑名单</span>
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
    width: 500px;
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
import Blacklist from "../../../build/contracts/Blacklist.json";

export default {
  data() {
    return {
      dialogVisible : false,

      oneAdd : {
        adder : '',
        user : '',
      },

      rules: {
        adder: [
          { required: true, message: '您的账户地址不能为空',  trigger: 'blur' },
          { min: 42, max: 42, message: '长度应为42个字符', trigger: 'blur'}
        ],

        user: [
          { required: true, message: '请输入你要添加进黑名单的账户', trigger: 'blur' },
          { min: 42, max: 42, message: '长度应为42个字符', trigger: 'blur' }
        ],
      },
    }
  },

  methods: {
    succeed() {
      this.dialogVisible = false;
      this.$router.push({path:'/'});
    },

    returnMain() {
      this.$router.push({path:'/'});
    },

    AddUser(oneAdd) {
      this.$refs[oneAdd].validate((valid)=>{
        if(valid){
          var tokenContract = new this.$web3.eth.Contract(Blacklist.abi,'0x8c5d2581Ef1c72BE24549908b5a146F9580101fe');

          tokenContract.methods.good(this.oneAdd.adder).call(null,(error,result)=>{
            if(result == 1){
              tokenContract.methods.bad(this.oneAdd.user).call(null, (error, result)=>{
                if(result == 1){
                  this.$message('该用户已是黑名单账户');
                }
                else{
                  tokenContract.methods.addBadUser(this.oneAdd.user).send({
                    from: this.oneAdd.adder,
                    gas: 1500000,
                    gasPrice: '300000000000',
                  }, (error, transactionHash)=>{
                    console.log("donate tx hash:"+transactionHash)
                    if(error){
                      this.$message({
                        message: '添加黑名单用户失败',
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
                }
              })
            }
            else{
              this.$message({
                message: '您没有权利添加黑名单用户',
                type: 'error'
              });
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