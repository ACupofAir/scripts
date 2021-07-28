<template>
  <div id="container">
    <div id="upSpace"></div>
    <div id="middle">
      <div id="middleSpace">
        <div id="loginText">登录</div>
        <div style="text-align: center">
          <div id="account">
            <el-input
                placeholder="管理员账号"
                prefix-icon="el-icon-user-solid"
                v-model="input1"
                class="inputAccount"
            >
            </el-input>
          </div>
        </div>
        <div id="password">
          <el-input
              placeholder="管理员密码"
              prefix-icon="el-icon-key"
              v-model="input2"
              show-password
              class="inputPassword"
              @keypress.native.enter = "log_in"
          >
          </el-input>
        </div>
        <div id="buttonArea">
          <div id="login">
            <el-row>
              <el-button type="primary" round v-on:click="log_in">
                登录
              </el-button>
            </el-row>
          </div>
          <div id="register">
            <el-row>
              <el-button type="primary" round @click="registerForm = true">
                注册
              </el-button>
            </el-row>
            <el-dialog title="注册" :visible.sync="registerForm">
              <el-form :model="form">
                <el-form-item label="账户名称" :label-width="formLabelWidth">
                  <el-input v-model="form.name" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="账户密码" :label-width="formLabelWidth">
                  <el-input v-model="form.code" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="邀请码" :label-width="formLabelWidth">
                  <el-input v-model="form.lisence" autocomplete="off"
                  @keypress.native.enter = "formOK">
                  </el-input>
                </el-form-item>
              </el-form>
              <div slot="footer" class="dialog-footer">
                <el-button @click="registerForm = false">取 消</el-button>
                <el-button type="primary" @click="formOK">确 定</el-button>
              </div>
            </el-dialog>
          </div>
        </div>
        <div id="loginService">
          <p id="serveText">如果想要了解更多，那么请联系我们~</p>
          <div id="textButton">
            <el-button type="text" @click="openForm = true">
              找到我们
            </el-button>
            <el-dialog
                title="我们的家"
                :visible.sync="openForm"
                width="580px"
                top="8px"
            >
              <p style="font-size: 25px">河底摸鱼工作室(qq群)</p>
              <img src="../../assets/publicity.jpg" alt="mark"/>
            </el-dialog>
          </div>
        </div>
      </div>
    </div>
    <div id="downSpace"></div>
  </div>
</template>

<script>
export default {
  name: "adminLogin",
  data() {
    return {
      input1: "",
      input2: "",
      registerForm: false,
      openForm: false,
      form: {
        name: "",
        code: "",
        lisence: "",
      },
      formLabelWidth: "80px",
      // list:{
      //   id:"",
      //   time:"",
      // }
    };
  },
  methods: {
  //   goPay(account) {
  // this.$router.push({
  //   path: '/adminMain',
  //   query: {
  //     acc:account,
  //   }
  // })
  //   },
    log_in() {
      let _this = this;
      // console.log(this.input1);
      this.$axios
        .post('/administrator/login', {
          adminID: _this.input1,
          password: _this.input2
        })
        .then(successResponse => {
            console.log(successResponse.data);
            if(successResponse.data.code === 1)
            {
              this.$message.error("账号不存在！");
            }
            else if(successResponse.data.code === 2)
            {
              this.$message.error("密码错误！");
            }
            else{
              this.$message({
              message: '登录成功！',
              type: 'success'
              });
                // id: successResponse.data["adminId"],
                // time: new Date().getTime(),
              // console.log(successResponse.data["adminId"]);
              // this.goPay(successResponse.data["adminId"]);
              window.sessionStorage.removeItem('data');
              window.sessionStorage.removeItem('time');
              window.sessionStorage.setItem('data', successResponse.data["adminId"]);
              window.sessionStorage.setItem('time', new Date().getTime()),
              location.href = "/adminMain";
            }
        })
        .catch(failResponse => {
          console.log(failResponse.data)
        })
      // if (!this.input1) {
      //   const h1 = this.$createElement;

      //   this.$notify({
      //     title: "",
      //     message: h1("i", { style: "color: balck" }, "请输入账号"),
      //   });
      //   return;
      // }
      // if (!this.input2) {
      //   const h2 = this.$createElement;

      //   this.$notify({
      //     title: "",
      //     message: h2("i", { style: "color: black" }, "请输入密码"),
      //   });
      //   return;
      // }
      // if (this.input1 === "rains" && this.input2 === "123") {
      // this.$message({
      //   message: "登录成功！",
      //   type: "success",
      // });
      // location.href = "/adminMain";
      // console.log(0);
      // }
    },
    open() {
      // this.$alert("河底摸鱼工作室", "关于我们", {
      //   confirmButtonText: "知道啦",
      // callback: action => {
      //   this.$message({
      //     type: 'info',
      //     message: `action: ${ action }`
      //   });
      // }
      // });
      openForm = true;
    },
    formOK() {
      // this.registerForm = false;
      if(!this.form.name || !this.form.code)
      {
        this.$message.error("信息不能为空");
        return;
      }
      let _this = this;
      this.$axios
      .post('/administrator/register',{
        name: _this.form.name,
        password: _this.form.code,
        lisence: _this.form.lisence
      })
      .then(successResponse =>{
        console.log(successResponse.data);
        if(successResponse.data.code === 1)
        {
          this.$alert("注册成功", "", {
          confirmButtonText: "确认",
        });
        this.registerForm = false;
        }
        else{
          this.$message.error("邀请码错误");
        }
      })
      .catch(failResponse => {
          console.log(failResponse.data)
        })
      // if (this.form.lisence === "711191") {
      //   this.$alert("注册成功", "", {
      //     confirmButtonText: "确认",
      //   });
      // }
      // if (this.form.lisence === "711191") this.registerForm = false;
      // else {
      //   this.$message.error("邀请码错误");
      // }
    },
  },
};
</script>

<style scoped>
#container {
  background-color: rgb(250, 250, 250);
  display: grid;
  grid-template-columns: 100%;
  grid-template-rows: 2fr 5fr 2fr;
  grid-template-areas:
    "upSpace"
    "middle"
    "downSpace";
  width: 100%;
  height: 100%;
  position: absolute;
  left: 0px;
  top: 0px;
  bottom: 0px;
  right: 0px;
  background: url("../../assets/bg02.jpg");
  background-size: cover;
}

#upSpace {
  grid-area: upSpace;
  /* position: absolute; */
}

#middle {
  grid-area: middle;
  /* position: absolute; */
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  /* display: grid;
  grid-template-columns: 100%;
  grid-template-rows: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas:
    "loginText"
    "account"
    "password"
    "buttonArea"
    "loginService";
  position: absolute;
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  border: wheat solid 2px; */
}

#middleSpace {
  display: grid;
  grid-template-columns: 100%;
  grid-template-rows: 1fr 1fr 1fr 1fr 1fr;
  grid-template-areas:
    "loginText"
    "account"
    "password"
    "buttonArea"
    "loginService";
  /* position: absolute; */
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  /* border: black solid 2px; */
}

#loginText {
  grid-area: loginText;
  color: white;
  /* border: wheat solid 2px; */
  /* width: 200px; */
  /* height: 60px; */
  /* position: absolute; */
  top: 5px;
  bottom: 0px;
  left: 0px;
  margin-right: 30%;
  /* border: wheat solid 2px; */
  font-size: 30px;
}

/* #texts{
  border: wheat solid 2px;
  position: absolute ;
  width:200px;
  height:60px;
  top:20px;
  bottom:0px;
  left:200px;
  right:0px;
  font-size: 30px;
} */
#account {
  grid-area: account;
  /* background-color: rgb(250, 250, 250); */
  /* position: absolute; */
  top: 0px;
  bottom: 0px;

  margin-left: 33%;
  margin-right: 33%;
  /* width:30%; */
  /* border: wheat solid 2px; */
  /* width: 600px; */
}

/* .inputAccount >>> input {
  background-color: rgb(238, 230, 228);
  color: rgb(245, 245, 245);
} */
#password {
  grid-area: password;
  /* background-color: rgb(250, 250, 250); */
  /* color: rgb(245, 245, 245); */
  /* border: wheat solid 2px; */
  /* position: absolute; */
  top: 0px;
  bottom: 0px;
  margin-left: 33%;
  margin-right: 33%;
  /* width:600px; */
  /* border: wheat solid 2px; */
}

/* .inputPassword >>> input {
  background-color: rgb(238, 230, 228);
} */

#buttonArea {
  grid-area: buttonArea;
  /* border: wheat solid 2px; */
  /* position: absolute; */
  top: 0px;
  bottom: 0px;
  left: 0px;
  right: 0px;
  /* width:100px; */
  /* left:685px; */
  /* top:25px; */
}

#login {
  /* border: wheat solid 2px; */
  /* position: absolute; */
  /* margin-top: 20px; */
  margin-bottom: 0px;
  margin-left: 0px;
  margin-right: 29%;
  /* width:100px; */
  /* border: wheat solid 2px; */
}

#register {
  /* border: wheat solid 2px; */
  /* position: absolute; */
  margin-top: -40px;
  margin-bottom: 0px;
  margin-left: 61%;
  margin-right: 10px;
  width: 100px;
  /* border: wheat solid 2px; */
}

#loginService {
  grid-area: loginService;
  /* border: wheat solid 2px; */
  /* position: absolute; */
  margin-top: 40px;
  margin-bottom: 0px;
  margin-left: 40%;
  margin-right: 0px;
  /* width:600px;  */
  height: 50px;
  /* left:500px;
  top:20px; */
  /* color:white;
  box-shadow: 30 0 40px black;
  font-size: 16px; */
}

#serveText {
  color: white;
  text-shadow: 0 0 2px black;
  /* position: absolute; */
  /* height:50px; */
  /* width: 300px; */
  margin-left: -50%;
  top: 1px;
  bottom: 0px;
  margin-right: 30%;
  /* border: wheat solid 2px; */
}

#textButton {
  /* position: absolute; */
  height: 50px;
  margin-left: 0px;
  margin-top: -45px;
  margin-bottom: 40px;
  margin-right: 30%;
  /* border: wheat solid 2px; */
}

#downSpace {
  grid-area: downSpace;
  /* position: absolute; */
  /* border: wheat solid 2px; */
  /* background: url("../../assets/loginFoot.jpg");
  background-position-x: -160px;
  background-position-y: -50px; */
  /* background-position-x: -50px; */
  /* background-size: cover; */
}
</style>
