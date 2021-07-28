<template>
  <div class="commentPage">
    <!--basic info-->
    <div class="basicInfo">

      <div class="yearIn checkBox">
        <span class="checkBoxLeft">
          <font color="white">你的学校</font>
        </span>
        <div class="checkBoxRight">
          <el-input v-model="collegeName" placeholder="请输入内容" :disabled="collegeFixed"></el-input>
        </div>
      </div>

      <div class="grade checkBox">
        <span class="checkBoxLeft">
          <font color="white">所在校区</font>
        </span>
        <div class="checkBoxRight">
          <el-input v-model="campusName" placeholder="请输入内容" :disabled="campusFixed"></el-input>
        </div>
      </div>

      <div class="scale checkBox">
        <span class="checkBoxLeft">
          <font color="white">校区地址</font>
        </span>
        <div class="checkBoxRight">
          <el-input v-model="campusAddr" placeholder="请输入内容" ></el-input>
        </div>
      </div>

      <div class="isRecommend checkBox">
        <span class="checkBoxLeft">
          <font color="white">宿舍区</font>
        </span>
        <div class="checkBoxRight">
          <el-input v-model="dormArea" placeholder="请输入内容" :disabled="dormFixed"></el-input>
        </div>
      </div>
    </div>

    <!-- Three score items -->
    <div class="threeScores">
      <el-row class="rowStyle" :gutter="60">
        <el-col :span="8">
          <div class="">宿舍总体情况</div>
        </el-col>
        <el-col :span="16">
          <div class="">
            <el-slider v-model="score" :step="1" :max='5' show-stops>
            </el-slider>
          </div>
        </el-col>
      </el-row>
      <el-row class="rowStyle" :gutter="60">
        <el-col :span="8">
          <div class="">宿舍基础情况</div>
        </el-col>
        <el-col :span="16">
          <div class="">
            <el-slider v-model="basicInfoScore" :step="1" :max='5' show-stops>
            </el-slider>
          </div>
        </el-col>
      </el-row>
      <el-row class="rowStyle" :gutter="60">
        <el-col :span="8">
          <div class="">宿舍建筑情况</div>
        </el-col>
        <el-col :span="16">
          <div class="">
            <el-slider v-model="buildingScore" :step="1" :max='5' show-stops>
            </el-slider>
          </div>
        </el-col>
      </el-row>
      <el-row class="rowStyle" :gutter="60">
        <el-col :span="8">
          <div class="">宿舍位置情况</div>
        </el-col>
        <el-col :span="16">
          <div class="">
            <el-slider v-model="locationScore" :step="1" :max='5' show-stops>
            </el-slider>
          </div>
        </el-col>
      </el-row>
    </div>


    <!-- Four ckeck boxes -->
    <div class="fourChecks">

      <div class="yearIn checkBox">
        <span class="checkBoxLeft">
          <font color="white">入住年份</font>
        </span>
        <div class="checkBoxRight">
          <el-date-picker v-model="yearIn" type="year" placeholder="选择年"></el-date-picker>
        </div>
      </div>

      <div class="grade checkBox">
        <span class="checkBoxLeft">
          <font color="white">你的年级</font>
        </span>
        <div class="checkBoxRight">
          <el-select v-model="gradeValue" placeholder="请选择">
            <el-option v-for="item in gradeOptions" :key="item.value" :label="item.label" :value="item.value">
            </el-option>
          </el-select>
        </div>
      </div>

      <div class="scale checkBox">
        <span class="checkBoxLeft">
          <font color="white">住宿规模</font>
        </span>
        <div class="checkBoxRight">
          <el-input-number v-model="scale" :step="1" step-strictly :min=0 :max=5></el-input-number>
        </div>
      </div>

      <div class="isRecommend checkBox">
        <span class="checkBoxLeft">
          <font color="white">是否推荐</font>
        </span>
        <div class="checkBoxRight">
          <el-switch v-model="isRecommend" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </div>
      </div>
    </div>


    <!-- specialTags -->
    <div class="specialTags">

      <div class="refrigerator tag">
        <span class="tagLeft">
          <img src="../../assets/comment/refrigerator.svg" height="30" width="30" alt="" title="冰箱">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasRefrigerator" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="sofa tag">
        <span class="tagLeft">
          <img src="../../assets/comment/sofa.svg" height="30" width="30" alt="" title="沙发">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasSofa" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="washer tag">
        <span class="tagLeft">
          <img src="../../assets/comment/washer.svg" height="30" width="30" alt="" title="洗衣机">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasWasher" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="airConditionor tag">
        <span class="tagLeft">
          <img src="../../assets/comment/air-cool.svg" height="30" width="30" alt="" title="空调">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasAirCool" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="cooker tag">
        <span class="tagLeft">
          <img src="../../assets/comment/cooker.svg" height="30" width="30" alt="" title="烹饪">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasCooker" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="balcony tag">
        <span class="tagLeft">
          <img src="../../assets/comment/balcony.svg" height="30" width="30" alt="" title="阳台">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasBalcony" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="wifi tag">
        <span class="tagLeft">
          <img src="../../assets/comment/wifi.svg" height="30" width="30" alt="" title="无线网覆盖">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasWifi" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="bathroom tag">
        <span class="tagLeft">
          <img src="../../assets/comment/bathRoom.svg" height="30" width="30" alt="" title="独立浴室">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasBathroom" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

      <div class="toilet tag">
        <span class="tagLeft">
          <img src="../../assets/comment/Toilet.svg" height="30" width="30" alt="" title="独立卫生间">
        </span>
        <span class="tagRight">
          <el-switch v-model="hasStudyroom" active-color="#13ce66" inactive-color="#ff4949">
          </el-switch>
        </span>
      </div>

    </div>


    <!-- shortComment -->
    <div class="shortComment">
      <div class="subTitle">
        <font color="white">您的简评</font>
      </div>
      <el-input type="textarea" :rows="5" placeholder="请输入你在宿舍的住宿体验，不要少于15个字符~" v-model="shortComment">
      </el-input>
    </div>


    <!-- camera -->
    <div class="photo">
      <div class="subTitle">
        <font color="white">宿舍照片</font>
      </div>
      <span class="uploadImg imgBox">
        <span class="imgBoxLeft">
          <img src="../../assets/comment/house_example.svg" height=190px width=190px alt="" title="宿舍">
        </span>
        <el-upload class="imgBoxRight" drag action="https://jsonplaceholder.typicode.com/posts/" multiple>
          <i class="el-icon-upload"></i>
          <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
          <div class="el-upload__tip" slot="tip">只能上传jpg/png文件，且不超过500kb</div>
        </el-upload>
      </span>

    </div>

    <!--email -->
    <div class="email">
      <div class="subTitle">
        <font color="white">如需反馈请提供您的邮箱</font>
      </div>
      <span class="submitEmail">
        <el-input type="textarea" autosize placeholder="xxxxx@example.com" v-model="email">
        </el-input>
      </span>
    </div>

    <!-- submit button -->
    <div class="buttonBox">
      <span class="buttonBoxLeft">
        <el-button type="primary" v-on:click="submit">提交<i class="el-icon-upload el-icon--right"></i></el-button>
      </span>
      <span class="buttonBoxRight">
        <el-button type="primary" v-on:click="resetForm">重置<i class="el-icon-refresh-right el-icon--right"></i></el-button>
      </span>
    </div>

  </div>
</template>

<script>
  export default {
    name: "comment",
    data: () => {
      return {
        collegeName: "",
        campusName: "",
        campusAddr: "",
        dormArea: "",
        score: 3,
        basicInfoScore: 3,
        buildingScore: 3,
        locationScore: 3,
        yearIn: "",
        gradeNum: 0,
        gradeOptions: [{
          value: '1',
          label: '大一'
        }, {
          value: '2',
          label: '大二'
        }, {
          value: '3',
          label: '大三'
        }, {
          value: '4',
          label: '大四'
        }, {
          value: '5',
          label: '研究生'
        }, {
          value: '6',
          label: '博士生'
        }],
        gradeValue: '',
        scale: 0,
        isRecommend: true,
        hasRefrigerator: false,
        hasSofa: false,
        hasWasher: false,
        hasAirCool: false,
        hasCooker: false,
        hasBalcony: false,
        hasWifi: false,
        hasBathroom: false,
        hasStudyroom: false,
        shortComment: "",
        email: '',
        photo:"https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",



        collegeFixed: false,
        campusFixed: false,
        dormFixed: false,
      }
    },
    beforeRouteEnter (to, from, next){
      console.log(from.name)
      console.log(from)
      if(from.name === 'Campus'){
        let camp = from.params.campusName.split('-')
        next(vm => vm.setDataFromCamp(camp))
      } else if (from.name === 'College') {
        if (from.params.collegeName === 'notFound'){
          next(vm => vm.setDataFromNotfound())
        }
        else {
          next(vm => vm.setDataFromCollege(from.params.collegeName))
        }
      }
      next(vm => vm.setData())



    },
    methods: {
      setDataFromCamp (camp) {
        console.log('从校区页面到评价')
        this.collegeFixed = true
        this.collegeName = camp[0]
        this.campusFixed = true
        this.campusName = camp[1]
        // console.log(this.campusName)
      },

      setDataFromCollege (college) {
        console.log('从学校页面到评价')
        this.collegeFixed = true
        this.collegeName = college
        // console.log(this.campusName)
      },

      setDataFromNotfound () {

      },

      setData() {

      },
      submit() {
        let _campus = this.collegeName + '-' + this.campusName
        let _this = this
        this.$axios
            .post('/comment/post', {
              id: "1",

              campus: _campus,

              dorm: _this.dormArea,

              location: _this.campusAddr,

              year: _this.yearIn.getFullYear(),

              grade: Number(_this.gradeValue),

              scale: _this.scale,

              recommend: _this.isRecommend,

              email: _this.email,

              facilities: _this.basicInfoScore,

              architecture: _this.buildingScore,

              surrounding: _this.locationScore,

              score: _this.score,

              photo: _this.photo,

              briefComment: _this.shortComment,

              airConditioner: _this.hasAirCool,

              sofa: _this.hasSofa,

              outdoorBalcony: _this.hasBalcony,

              washingMachine: _this.hasWasher,

              refrigerator: _this.hasRefrigerator,

              cooking: _this.hasCooker,

              wifi: _this.hasWifi,

              restroom: _this.hasBathroom,

              timeStamp: _this.getCurrentDate(),

              studyroom: _this.hasStudyroom,

              state: false,   //未发布

              isNewSchool: !_this.collegeFixed,

              isNewCampus: !_this.campusFixed,

              isChecked: false,

            })
            .then(successResponse => {
              console.log(successResponse.data);
            })
            .catch(failResponse => {
              console.log(failResponse.data)
            })
      },

      getCurrentDate () {
        let date = new Date()
        let month = date.getMonth() + 1
        let strDate = date.getDate()
        let minute = date.getMinutes()
        let second = date.getSeconds()
        if (month >= 1 && month <= 9) {
          month = "0" + month
        }
        if (strDate >= 0 && strDate <= 9) {
          strDate = "0" + strDate
        }
        if (minute >= 0 && minute <= 9) {
          minute = "0" + minute
        }
        if (second >= 0 && second <= 9) {
          second = "0" + second
        }
        let currentDate = date.getFullYear() + "-" + month + "-" + strDate
            + "T" + date.getHours() + ":" + minute + ":" + second
        return currentDate
      },



      resetForm() {
        alert(this.getCurrentDate())
        // this.$refs[formName].resetFields();
      }
    },





  }
</script>

<style scoped>
  .el-row {
    margin-bottom: 20px;
    /* box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04) */
  }

  .el-col {
    border-radius: 4px;
  }

  .bg-purple-dark {
    background: #99a9bf;
  }

  .bg-purple {
    background: #d3dce6;
  }

  .bg-purple-light {
    background: #e5e9f2;
  }

  .grid-content {
    border-radius: 4px;
    min-height: 36px;
  }

  .row-bg {
    padding: 10px 0;
    background-color: #f9fafc;
  }

  .commentPage {
    display: grid;
    padding-top: 120px;
    padding-left: 22%;
    padding-right: 22%;
    padding-bottom: 120px;
    row-gap: 100px;

    grid-template-areas:
      "basicInfo"
      "threeScores"
      "fourChecks"
      "specialTags"
      "shortComment"
      "photo"
      "email"
      "buttonBox";


  }

  .basicInfo {
    grid-area: basicInfo;
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 1fr 1fr;

    grid-template-areas:
      "yearIn grade"
      "scale isRecommend";

    row-gap: 20px;
    column-gap: 80px;
  }


  .threeScores {
    grid-area: threeScores;

  }

  .rowStyle {
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .fourChecks {
    grid-area: fourChecks;
    display: grid;
    grid-template-columns: 1fr 1fr;
    grid-template-rows: 1fr 1fr;

    grid-template-areas:
      "yearIn grade"
      "scale isRecommend";

    row-gap: 20px;
    column-gap: 80px;
  }

  .specialTags {
    grid-area: specialTags;
    display: grid;
    grid-template-columns: 1fr 1fr 1fr;
    grid-template-rows: 1fr 1fr 1fr;

    grid-template-areas:
      "refrigerator sofa washer"
      "airConditionor cooker balcony"
      "wifi bathroom toilet";

    row-gap: 20px;
    column-gap: 60px;

  }

  .tag {
    display: grid;

    grid-template-columns: 1fr 1fr;
    border-radius: 8px;

    column-gap: 80px;

    grid-template-areas: "tagLeft tagRight";
  }

  .tagLeft {
    grid-area: tagLeft;
    border-radius: 8px;
  }

  .tagRight {
    grid-area: tagRight;
    border-radius: 8px;
  }

  .refrigerator {
    grid-area: refrigerator;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .sofa {
    grid-area: sofa;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .washer {
    grid-area: washer;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .airConditionor {
    grid-area: airConditionor;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .cooker {
    grid-area: cooker;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .balcony {
    grid-area: balcony;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .wifi {
    grid-area: wifi;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .bathroom {
    grid-area: bathroom;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .toilet {
    grid-area: toilet;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .shortComment {
    grid-area: shortComment;

    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .photo {
    grid-area: photo;

    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
    grid-template-areas: "uploadImg submitEmail";
    column-gap: 70px;

  }

  .email {
    grid-area: email;

    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
    row-gap: 0px;
    column-gap: 0px;
  }

  .checkBox {
    display: grid;
    grid-template-columns: 1fr 1fr;

    height: 40px;
    width: 350px;

    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
    grid-template-areas: "checkBoxLeft checkBoxRight";
  }

  .checkBoxLeft {
    grid-area: checkBoxLeft;
    border-bottom-left-radius: 8px;
    border-top-left-radius: 8px;
    background-color: #0488D1;
  }

  .checkBoxRight {
    grid-area: checkBoxRight;
    border-bottom-right-radius: 8px;
    border-top-right-radius: 8px;
  }

  .imgBox {
    display: grid;
    grid-template-columns: 1fr 1fr;

    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
    grid-template-areas: "imgBoxLeft imgBoxRight";
  }

  .imgBoxLeft {
    grid-area: imgBoxLeft;
    border-bottom-left-radius: 8px;
  }

  .imgBoxRight {
    grid-area: imgBoxRight;
    border-bottom-right-radius: 8px;
  }

  .buttonBox {
    grid-area: buttonBox;
    display: grid;
    grid-template-columns: 1fr 1fr;

    grid-template-areas: "buttonBoxLeft buttonBoxRight";
    column-gap: 50px;
  }

  .buttonBoxLeft {
    grid-area: buttonBoxLeft;
  }

  .buttonBoxRight {
    grid-area: buttonBoxRight;
  }

  .yearIn {
    grid-area: yearIn;

  }

  .grade {
    grid-area: grade;
  }

  .scale {
    grid-area: scale;
  }

  .isRecommend {
    grid-area: isRecommend;
  }

  .subTitle {
    background-color: #0488D1;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-top-left-radius: 8px;
    border-top-right-radius: 8px;
    text-align: center;
  }
</style>

