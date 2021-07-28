<template>
  <div class="campusWrapper">
    <div class="titleWrapper">
      <div class="campusNameWrapper">
        <div class="campusName">{{currentCampus}}</div>
        <div style="font-size: 16px">{{campusAddress}}</div>
        <div class="campusRate">
          <el-rate v-model="campusRate" disabled show-score text-color="#ff9900" score-template="{value}">
          </el-rate>
        </div>
        <div class="rateAndUpload">
          <router-link to="/comment">
            <el-popover placement="top-start" width="50" trigger="hover" content="写评价">
              <el-button type="primary" icon="el-icon-edit" circle slot="reference" id="rateButton"></el-button>
            </el-popover>
          </router-link>

          <el-popover placement="top-start" width="50" trigger="hover" content="上传图片">
            <el-button type="success" icon="el-icon-picture-outline" circle slot="reference" id="uploadButton">
            </el-button>
          </el-popover>

        </div>
        <el-divider class="titleDivider"><i class="el-icon-price-tag"></i></el-divider>
      </div>
      <div class="campusPhoto">
        <el-image :src="pictureURL" fit="cover" class="campusPic"></el-image>
      </div>
    </div>
    <div class="statisticWrapper">
      <div class="sort">
        <div style="font-weight: bold; margin-bottom: 5px; margin-top: 5px; font-size: 20px">排序</div>
        <el-radio-group v-model="radio1">
          <div class="rankItem" v-for="(item, index) in rankName" :key="index">
            <el-radio :label="index">{{item.name}}</el-radio>
          </div>
        </el-radio-group>
      </div>

      <el-divider><i class="el-icon-price-tag"></i></el-divider>

      <div class="grade">
        <div style="font-weight: bold; margin-bottom: 5px; margin-top: 5px; font-size: 20px">匹配的年级</div>
        <el-radio-group v-model="radio2" @change="changeComments">
          <div class="gradeItem" v-for="(item, index) in gradeName" :key="index">
            <el-radio :label="index">{{item.name}}</el-radio>
          </div>
        </el-radio-group>
      </div>
    </div>
    <div class="campusCommentWrapper">
      <briefComment v-for="(comItem, index) in currentComment" :key="index" class="briefCommentArea" :rate="comItem.rate"
        :is-recommend="comItem.isRecommend" :date="comItem.date" :brief-com="comItem.briefCom"
        :dorm-area="comItem.dormArea" :comment-details="comItem.commentDetails"></briefComment>
    </div>
  </div>

</template>

<script>
  import briefComment from "@/components/briefComment";

  export default {
    name: "campus",
    components: { briefComment },
    data: () => {
      return {
        pictureURL: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
        campusAddress: "",
        campusRate: 0,
        radio1: 0,
        radio2: 0,

        rankName: [{ name: "校区名称" }, { name: "最多评价" }, { name: "最高评分" }],
        gradeName: [{ name: "所有年级" }, { name: "大一" }, { name: "大二" }, { name: "大三" },
        { name: "大四" }, { name: "大五" }, { name: "研究生" }],
        briefComment: [],
        currentComment: [],

        currentCampus: null,
      }
    },

    methods: {
      changeComments(value) {
        // console.log(this.briefComment[0].commentDetails.grade)
        let toGrade = ""
        switch (value) {
          case 0: toGrade = "所有年级"; break;
          case 1: toGrade = "大一"; break;
          case 2: toGrade = "大二"; break;
          case 3: toGrade = "大三"; break;
          case 4: toGrade = "大四"; break;
          case 5: toGrade = "大五"; break;
          case 6: toGrade = "研究生"; break;
        }

        let tempComments = []

        // this.briefComment = []
        for(let comment of this.briefComment)
        {
          // console.log(comment.commentDetails.grade)
          if (toGrade === comment.commentDetails.grade || toGrade === '所有年级') {
            tempComments.push(comment)
          }
        }
        this.currentComment = tempComments
      },
    },

    created() {
      let campus = this.$route.params.campusName
      let _campus = campus.split('-')
      this.currentCampus = _campus[1]   //显示的校区名

      let _this = this
      this.$axios
          .get('/campus/find/' + campus)
          .then(response =>{
            console.log(response.data)
            _this.campusAddress = response.data.address
            _this.campusRate = response.data.score
          })


      //根据 '学校-校区' 去请求评价
      this.$axios
        .get('/comment/' + campus)
        .then(response => {
          let allComment = response.data
          for (let com of allComment) {
            if (com.state === true) {
              _this.campusAddress = com.location
              let toGrade = ""
              switch (com.grade) {
                case 1: toGrade = "大一"; break;
                case 2: toGrade = "大二"; break;
                case 3: toGrade = "大三"; break;
                case 4: toGrade = "大四"; break;
                case 5: toGrade = "大五"; break;
                case 6: toGrade = "研究生"; break;
              }
              _this.briefComment.push({
                rate: com.score,
                isRecommend: com.recommend,
                date: com.timeStamp,
                briefCom: com.briefComment,
                dormArea: com.dorm,
                commentDetails: {
                  detailRate: com.score,
                  detailName: com.campus,
                  isRecommend: com.recommend,
                  admissionTime: com.year,
                  grade: toGrade,
                  dormArea: com.dorm,
                  dormScale: com.scale + "人间",
                  rate: [{ rateTitle: "基础情况(桌椅床铺门窗等)", rateScore: com.facilities },
                  { rateTitle: "建筑情况(新旧和楼层布局)", rateScore: com.architecture },
                  { rateTitle: "位置情况(周边环境和位置)", rateScore: com.surrounding }],
                  label: ["空调", "洗衣机", "WIFI", "独立卫浴",],
                  comment: com.briefComment,
                  dormPicture: ["https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg"]
                },
              });
            }
          }
          this.currentComment = _this.briefComment
        })
    }

  }
</script>

<style scoped>
  .el-radio ::v-deep .el-radio__label {

    font-size: 20px !important;

  }

  ::v-deep .el-rate__icon {
    font-size: 28px;
  }

  /*简评*/
  .briefCommentArea {
    /*border: #3c85cb solid 2px;*/
    margin-top: 20px;
    margin-left: 120px;
    margin-bottom: 15px;
  }




  .gradeItem {
    margin-top: 15px;
  }

  .rankItem {
    margin-top: 15px;
  }


  /*----统计-----*/

  .statisticWrapper {
    font-size: 17px;
  }


  /*---------*/

  #rateButton {
    position: absolute;
    top: 10px;
    left: 80px;
  }

  #uploadButton {
    position: absolute;
    top: 10px;
    right: 80px;
  }

  .campusName {
    margin-top: 45px;
  }

  .campusRate {
    margin-top: 15px;
  }

  .rateAndUpload {
    /*border: #2c3e50 solid 2px;*/
    width: 320px;
    height: 50px;
    margin-top: 15px;
    position: absolute;
  }

  .titleDivider {
    margin-top: 85px;
  }


  .campusNameWrapper {
    grid-area: campusNameWrapper;
    /*border: #2c3e50 solid 2px;*/
  }

  .campusPhoto {
    grid-area: campusPhoto;
  }

  .campusPic {
    height: 230px;
    border-radius: 10px;
  }


  #campusToCollege {
    position: absolute;
    left: 5px;
    margin-top: 10px;
  }


  /*整体布局*/
  .campusWrapper {
    display: grid;
    grid-template-columns: 320px 1fr;
    grid-template-rows: 230px auto;
    grid-template-areas:
      "titleWrapper titleWrapper"
      "statisticWrapper campusCommentWrapper";
  }


  .titleWrapper {
    grid-area: titleWrapper;
    /*border: #99a9bf solid 2px;*/
    display: grid;
    grid-template-columns: 320px 1fr;
    grid-template-areas: "campusNameWrapper campusPhoto";
  }

  .statisticWrapper {
    grid-area: statisticWrapper;
    /*border: #99a9bf solid 2px;*/
    margin-top: 20px;
  }

  .campusCommentWrapper {
    grid-area: campusCommentWrapper;
    /*border: #99a9bf solid 2px;*/

  }
</style>

