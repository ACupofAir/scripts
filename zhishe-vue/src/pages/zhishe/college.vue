<template>
  <div class="collegePage">


    <div class="campusViews">

      <div class="collegePicture">
        <el-image :src="pictureURL" fit="cover" class="collegePic"></el-image>
      </div>

      <div class="selection" v-if="isCollegeFind">
        <div class="collegeName" style="font-weight: bolder; font-size: 40px; margin-top: 30px; text-align: center;">
          {{currentCollege}}
        </div>
        <div class="collegeAddress"
             style="font-size: 25px; color: rgb(5, 138, 182); margin-top:16px; text-align: center;">
          {{collegeAddress}}
        </div>
        <div class="commentsNumber"
             style="font-weight: bold; font-size: 24px; margin-top: 35px; margin-bottom: 30px; text-align:center;">
          共{{totalComment}}条学生评价
        </div>
        <el-divider class="titleDivider"><i class="el-icon-price-tag"></i></el-divider>

        <div class="statisticWrapper">
          <div class="campusScore">
            <div style="text-align: center; font-weight: bold">各项得分</div>
            <div v-for="(item, index) in rate" :key="index" class="basicScore">
              <span id="basicScoreTitle">{{item.rateTitle}}</span>
              <el-rate
                  v-model="item.rateScore"
                  disabled
                  score-template="{value}"
                  text-color="#ff9900"
                  show-score
                  id="basicStar">
              </el-rate>
            </div>
          </div>
          <div class="campusLabel">
            <div style="text-align: center; font-weight: bold">特色标签</div>
            <div v-for="(item , index) in label" :key="index" class="LabelItem" style="border: #99a9bf solid 1px; border-radius: 10px; margin-left: 10px; padding: 5px">
              <i class="el-icon-collection-tag"></i>
              {{item.labelName}}
            </div>
          </div>
          <div class="gradeDistribution">
            <div style="border: #3c85cb solid 2px; border-radius: 10px">年级分布</div>
          </div>
        </div>


        <el-divider class="titleDivider"><i class="el-icon-price-tag"></i></el-divider>
      </div>

      <div class="views" v-if="isCollegeFind">
        <div class="campusNumber"
             style="font-weight: bold; font-size: 28px; margin-top: 37px; margin-bottom:40px; text-align: left; margin-left: 60px;">
          {{totalCampus}}个校区符合你的要求
        </div>
        <div class="campusList">
          <router-link v-for="(item, index) in briefCampus" :key="index" :to="item.routerUrl">
            <campusInfo class="briefCampusInfo"
                        :campusBriefPhotoURL="item.url"
                        :campusName="item.id"
                        :campusRate="item.rate"
                        :campusComNum="item.comNum"
            ></campusInfo>
          </router-link>
        </div>
      </div>

    </div>

    <div class="cannotFindCampus" style="font-size:25px; margin-top: 20px; margin-bottom: 20px;" v-if="isCollegeFind">
      找不到你想要的校区?
      <el-link type="primary" @click="$router.push('/comment')"
               style="font-size :23px;font-weight: bold;color:rgb(5, 138, 182); margin-bottom:3px;"> 点击这里
      </el-link>
    </div>

    <!--    当没有找到学校时-->
    <div class="cannotFindCampus" style="font-size:25px; margin-top: 20px; margin-bottom: 20px;" v-if="!isCollegeFind">
      <div style="font-weight: lighter; font-size: 30px">没有找到 <span style="font-weight: bold">{{currentCollege}}</span>
      </div>
      找不到你想要的学校?
      <el-link type="primary" @click="$router.push('/comment')"
               style="font-size :23px;font-weight: bold;color:rgb(5, 138, 182); margin-bottom:3px;"> 点击这里
      </el-link>
    </div>
  </div>
</template>


<script>
import campusInfo from "@/components/campusInfo";

export default {
  name: "college",
  components: {campusInfo},
  data() {
    return {
      rate: [{rateTitle: "基础情况", rateScore: 0}, {rateTitle: "建筑情况", rateScore: 0}, {rateTitle: "位置情况", rateScore: 0}],
      label: [{labelName: "独立卫浴"}, {labelName: "自习室"}, {labelName: "WIFI"},
        {labelName: "冰箱"}, {labelName: "沙发"}, {labelName: "洗衣机",},
        {labelName: "空调"}, {labelName: "烹饪"}, {labelName: "阳台"}],


      pictureURL: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
      collegeName: "",
      collegeAddress: "",
      totalComment: "",
      totalCampus: "",
      briefCampus: [],
      campusId: "",
      currentCollege: "",

      isCollegeFind: false,
    }
  },



  created() {
    this.currentCollege = this.$route.params.collegeName;

    //去后端请求数据，查询学校存不存在
    let responseData = null
    let _this = this
    this.$axios
        .get('/college/find/' + this.currentCollege)
        .then(async function (response) {
          responseData = response.data
          console.log(responseData)

          if (responseData.address === undefined) {
            console.log("college not found")
            _this.$router.push('/college/notFound')
          }
          else {
            _this.collegeName = responseData.name
            _this.collegeAddress = responseData.address
            _this.totalComment = responseData.commentNum
            _this.totalCampus = responseData.campusNum
            _this.isCollegeFind = true
            let campusList = []
            campusList.push(responseData.campus1)
            campusList.push(responseData.campus2)
            campusList.push(responseData.campus3)
            campusList.push(responseData.campus4)
            campusList.push(responseData.campus5)
            await _this.findCampus(campusList)
            _this.rate[0].rateScore = _this.rate[0].rateScore  *1000 / Number(_this.totalCampus) /1000
            _this.rate[1].rateScore = _this.rate[1].rateScore  / Number(_this.totalCampus)
            _this.rate[2].rateScore = _this.rate[2].rateScore  / Number(_this.totalCampus)
            _this.rate[0].rateScore = Number(_this.rate[0].rateScore.toFixed(1))
            _this.rate[1].rateScore = Number(_this.rate[1].rateScore.toFixed(1))
            _this.rate[2].rateScore = Number(_this.rate[2].rateScore.toFixed(1))
          }
    })
    .catch(failRes => {
      console.log(failRes.data)
      console.log("12321")
    })
  },

  methods: {
    async findCampus (campusList) {
      let _this = this
      for(let item of campusList){
        if(item !== null){
          await _this.$axios
              .get('/campus/find/' + _this.currentCollege + '-' + item)
              .then(response =>{
                console.log(response.data)
                if(response.data.schoolName === _this.currentCollege){
                  let campusName = response.data.name.split('-')
                  _this.rate[0].rateScore  = _this.rate[0].rateScore  + response.data.facilitiesScore
                  _this.rate[1].rateScore  = _this.rate[1].rateScore  + response.data.architectureScore
                  _this.rate[2].rateScore  = _this.rate[2].rateScore  +response.data.surroundingScore

                  _this.briefCampus.push({
                    id: campusName[1],
                    rate: response.data.score,
                    comNum: response.data.commentNum,
                    routerUrl: '/campus/' + response.data.name,
                    url: 'https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210716160403.svg'
                  })
                }
              })
        }
      }
    }
  }
};
</script>

<style scoped>
::v-deep .el-rate__icon {
  font-size: 28px;
}

.campusList {
  margin-left: 50px;

}

.briefCampusInfo {
  margin-top: 20px;
}



/*---年级分布----*/
.gradeDistribution {
  margin-top: 20px;
  height: 200px;
  /*border: #2c3e50 solid 2px;*/
}


/*----------*/

/*----标签---*/
.campusLabel {
  margin-top: 30px;
}

.LabelItem {
  display: inline-block;
  margin-top: 10px;
  margin-left: 20px;
  margin-bottom: 10px;
}

/*----------*/

/*----统计-----*/

.statisticWrapper {
  font-size: 17px;
}

.basicScore {
  margin-top: 20px;
}

#basicScoreTitle {
  display: inline-block;
}

#basicStar {
  display: inline-block;
  margin-left: 16px;
}

/*---------*/

.collegePic {
  height: 320px;
}

.campusViews {
  display: grid;
  grid-template-rows: 320px auto;
  grid-template-columns: 3fr 7fr;
  grid-template-areas:
      "collegePicture collegePicture"
      "selection views";
  width: 100%;
  height: 100%;
  font-size: 19px;
}

.selection {
  grid-area: selection;
  /*border: #3c85cb solid 2px;*/
  text-align: left;
  padding-left: 50px;
}

.views {
  grid-area: views;
  margin-left: 30px;
  /*border: #3c85cb solid 2px;*/
}

.collegePicture {
  grid-area: collegePicture;
  /*border: #3c85cb solid 2px;*/
  height: 200px;
  width: 100%;
}

.cannotFindCampus {
  font-size: 1.0em;
  font-weight: bold
}
</style>
