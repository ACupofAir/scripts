<template>
  <div>
    <div class="briefCommentWrapper" v-on:click="openComDetails">
      <div class="briefInfo" style="text-align: left">
        <span class="comRate">
          <el-rate v-model="rate"
                   disabled
                   text-color="#ff9900"
                   score-template="{value}"
                   style="display: inline-block">
          </el-rate>
          <span style="height: 45px" v-if="isRecommend">
            <img src="../assets/thumbYes.svg" height="45" width="45" style="margin-left: 20px">
            <span style="font-size: 17px; margin-left: 1px; color:#747d8c ">推荐</span>
          </span>
           <span style="height: 45px" v-if="!isRecommend">
            <img src="../assets/thumbNo.svg" height="45" width="45"
                 style=" transform: rotate(180deg); margin-left: 20px">
            <span style="font-size: 17px; margin-left: 1px; color:#747d8c ">不推荐</span>
          </span>
          <span style="font-size: 17px;margin-left: 20px">宿舍区：<span style="color: #747d8c;">{{dormArea}}</span></span>
          <span style="font-size: 17px;margin-left: 20px">年级：<span style="color: #747d8c;">{{commentDetails.grade}}</span></span>
          <span style="font-size: 17px; margin-left: 50px; color: #99a9bf">{{date}}</span>

        </span>
      </div>
      <div class="briefComment" style="background-color: #ecf0f1">
        <div style="text-align: left;font-weight: bolder;  font-size: 18px; margin-left: 9px">简评：</div>
        <div
            style=" text-align: left; padding: 1px;margin-left: 49px;margin-right: 36px;font-size: 15px">
          {{briefCom}}
        </div>
      </div>
    </div>

    <el-dialog
        :visible.sync="dialogVisible"
        width="50%">
      <comDetails :detail-rate="commentDetails.detailRate" :detail-name="commentDetails.detailName"
                  :is-recommend="commentDetails.isRecommend" :admission-time="commentDetails.admissionTime"
                  :grade="commentDetails.grade" :dorm-area="commentDetails.dormArea"
                  :dorm-scale="commentDetails.dormScale" :rate="commentDetails.rate"
                  :label="commentDetails.label" :comment="commentDetails.comment"
                  :dorm-picture="commentDetails.dormPicture"></comDetails>
    </el-dialog>
  </div>

</template>

<script>
import comDetails from "@/components/comDetails";

export default {
  name: "briefComment",
  components: {comDetails},
  props: ['rate', 'isRecommend', 'date', 'briefCom', 'dormArea', 'commentDetails'],
  data() {
    return {
        dialogVisible: false,

      // rate: 3.6,
      // isRecommend: false,
      // date: "2021 7.19 16:04",
      // briefCom: "赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑",
      // dormArea: "梅园",
      // commentDetails: {
      //   detailRate: 3.6,
      //   detailName: "东南大学(九龙湖校区)",
      //   isRecommend: false,
      //   admissionTime: "2019",
      //   grade: "大三",
      //   dormArea: "梅园",
      //   dormScale: "四人间",
      //   rate: [{rateTitle: "基础情况(桌椅床铺门窗等)", rateScore: 3.8},
      //     {rateTitle: "建筑情况(新旧和楼层布局)", rateScore: 2.5},
      //     {rateTitle: "位置情况(周边环境和位置)", rateScore: 3.1}],
      //   label: ["空调", "洗衣机", "WIFI", "独立卫浴",],
      //   comment: "赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑",
      //   dormPicture: ["https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg"]
      // },
    }
  },
  methods: {
    openComDetails() {
      this.dialogVisible = true
    }
  }
}
</script>

<style scoped>


.briefCommentWrapper {
  height: 185px;
  width: 800px;
  /*border: #3c85cb solid 3px;*/
  box-shadow: 0 0 20px #cac6c6;
  padding: 10px;
}

.briefInfo {
  /*border: #3c85cb solid 3px;*/
  height: 50px;
  margin-top: 10px;

}

.briefComment {
  margin-top: 10px;
  /*border: #3c85cb solid 3px;*/
  height: 100px;
}

</style>
