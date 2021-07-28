<template>
  <div class="detailWrapper">
    <div class="detailRate" style="text-align: left">
      <el-rate
          v-model="detailRate"
          disabled
          text-color="#ff9900"
          score-template="{value}">
      </el-rate>
    </div>

    <el-divider><i class="el-icon-price-tag"></i></el-divider>

    <div class="detailName" style="text-align: left">
      <div style="font-size: 20px;font-weight: bold">{{detailName}}</div>
      <div v-if="isRecommend" style="margin-top: 10px; height: 45px;">
        <span style="height: 45px"><img src="../assets/thumbYes.svg" height="45" width="45"></span>
        <span style="font-size: 17px; margin-left: 10px;">推荐</span>
      </div>
      <div v-if="!isRecommend" style="margin-top: 10px; height: 45px;">
        <span style="height: 45px;"><img src="../assets/thumbNo.svg" height="45" width="45"
                                         style=" transform: rotate(180deg)"></span>
        <span style="font-size: 17px; margin-left: 10px;">不推荐</span>
      </div>
    </div>

    <el-divider><i class="el-icon-price-tag"></i></el-divider>

    <div class="detailComment" style="font-size: 16px">
      <div style="text-align: left; font-weight: bolder">评价者信息</div>
      <div><span>入学年份：</span><span>{{admissionTime}}</span></div>
      <div style="margin-top: 15px"><span>年级：</span><span>{{grade}}</span></div>
      <div style="text-align: left;font-weight: bolder; margin-top: 5px">宿舍信息</div>
      <div style="margin-top: 10px"><span>宿舍区：</span><span>{{dormArea}}</span></div>
      <div style="margin-top: 20px"><span>宿舍规模：</span><span>{{dormScale}}</span></div>
      <div v-for="(item, index) in rate" :key="index" style="margin-top: 20px">
        <div>
          <div style="display: inline-block">{{item.rateTitle}}：</div>
          <div style="display: inline-block">
            <el-rate v-model="item.rateScore"
                     disabled
                     text-color="#ff9900"
                     score-template="{value}">
            </el-rate>
          </div>
        </div>
      </div>
      <div style="margin-top: 20px"><span>宿舍特色：</span>
        <span v-for="(item , index) in label" :key="index" class="LabelItem"
              style="border: #99a9bf solid 1px; border-radius: 10px; margin-left: 10px; padding: 5px">
        <i class="el-icon-collection-tag" style="margin-top: 20px">{{item}}</i>
      </span>
      </div>
      <div style="text-align: left;font-weight: bolder; margin-top: 15px">简评</div>
      <div
          style="text-align: left; padding: 10px;margin-left: 36px;margin-right: 36px;font-size: 15px">
        {{comment}}
      </div>
      <div style="text-align: left;font-weight: bolder; margin-top: 15px">照片</div>
      <div v-if="dormPicture.length">
        <span v-for="(item, index) in dormPicture" :key="index">
          <el-image :src="item"></el-image>
        </span>
      </div>
      <div v-if="!dormPicture.length">
        🈚️照片
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['detailRate', 'detailName', 'isRecommend', 'admissionTime', 'grade', 'dormArea',
    'dormScale', 'rate', 'label', 'comment', 'dormPicture'],
  data() {
    return {
      // detailRate: 3.6,
      // detailName: "东南大学(九龙湖校区)",
      // isRecommend: false,
      // admissionTime: "2019",
      // grade: "大三",
      // dormArea: "梅园",
      // dormScale: "四人间",
      // rate: [{rateTitle: "基础情况(桌椅床铺门窗等)",rateScore: 3.8},
      //       {rateTitle: "建筑情况(新旧和楼层布局)",rateScore: 2.5},
      //       {rateTitle: "位置情况(周边环境和位置)",rateScore: 3.1}],
      // label:["空调","洗衣机","WIFI","独立卫浴","空调","洗衣机","WIFI","独立卫浴","空调","洗衣机","WIFI","独立卫浴",],
      // comment: "赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑赶紧跑",
      // dormPicture:["https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",],
    }
  }
}
</script>

<style scoped>

/* .detailRate{
border: #3c85cb solid 2px;
}

.detailName{
  border: #3c85cb solid 2px;

}

.detailComment{
  border: #3c85cb solid 2px;

} */



::v-deep .el-rate__icon{
  font-size: 35px;
}
</style>

