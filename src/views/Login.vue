<template>
  <el-form :model="loginForm" :rules="rules2" ref="loginForm" label-position="left" label-width="0px" class="demo-ruleForm login-container">
    <h3 class="title">系统登录</h3>
    <el-form-item prop="uName">
      <el-input type="text" v-model="loginForm.uName" auto-complete="off" placeholder="账号"></el-input>
    </el-form-item>
    <el-form-item prop="uPwd">
      <el-input type="password" v-model="loginForm.uPwd" auto-complete="off" placeholder="密码"></el-input>
    </el-form-item>
    <el-checkbox v-model="checked" checked class="remember">记住密码</el-checkbox>
    <el-form-item style="width:100%;">
      <el-button type="primary" style="width:100%;" @click.native.prevent="handleSubmit2" :loading="logining">登录</el-button>
      <!--<el-button @click.native.prevent="handleReset2">重置</el-button>-->
    </el-form-item>
  </el-form>
</template>

<script>
//import NProgress from 'nprogress'
export default {
  data() {
    return {
      logining: false,
      loginForm: {
        uName: "luolu",
        uPwd: "1234"
      },
      rules2: {
        uName: [
          { required: true, message: "请输入账号", trigger: "blur" }
          //{ validator: validaePass }
        ],
        uPwd: [
          { required: true, message: "请输入密码", trigger: "blur" }
          //{ validator: validaePass2 }
        ]
      },
      checked: true
    };
  },
  methods: {
    handleReset2() {
      this.$refs.loginForm.resetFields();
    },
    handleSubmit2(ev) {
      var _this = this;
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          //_this.$router.replace('/table');
          this.logining = true;
          //NProgress.start();
          var loginParams = {
            uName: this.loginForm.uName,
            uPwd: this.loginForm.uPwd
          };
          this.$http.postJson('/api/user/login',loginParams).then(res => {
            this.logining = false;
            if(res && res.length == 0){
              alert('用户名或密码错误...');
              return;
            }
            sessionStorage.setItem("user", JSON.stringify(res));
            this.$router.push({ path: "/cate" });
          });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    }
  }
};
</script>

<style lang="scss" scoped>
.login-container {
  /*box-shadow: 0 0px 8px 0 rgba(0, 0, 0, 0.06), 0 1px 0px 0 rgba(0, 0, 0, 0.02);*/
  -webkit-border-radius: 5px;
  border-radius: 5px;
  -moz-border-radius: 5px;
  background-clip: padding-box;
  margin: 180px auto;
  width: 350px;
  padding: 35px 35px 15px 35px;
  background: #fff;
  border: 1px solid #eaeaea;
  box-shadow: 0 0 25px #cac6c6;
  .title {
    margin: 0px auto 40px auto;
    text-align: center;
    color: #505458;
  }
  .remember {
    margin: 0px 0px 35px 0px;
  }
}
</style>