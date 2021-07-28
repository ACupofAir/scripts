<template>
  <div class="campusInfoWrapper">
    <div class="campusBriefPhoto">
      <img :src="campusBriefPhotoURL" height="180px" width="180px">
    </div>
    <div class="campusBriefInfo">
      <div class="infoName" style=" height: 80px; text-align: left">
        <div style="color: #222222; font-weight: bold; font-size: 30px">{{campusName}}</div>
      </div>
      <div class="infoRate" style="height: 70px; text-align: left">
        <el-rate
            v-model="campusRate"
            disabled
            show-score
            text-color="#ff9900"
            score-template="{value}">
        </el-rate>
      </div>
      <div class="infoTotalCom" style="height: 60px; text-align: left; font-size: 20px">
        <span style="color: #3c85cb">{{campusComNum}}</span><span style="color: #8c8c8c">条评价</span>

      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "campusInfo",
  props: ['campusBriefPhotoURL', 'campusName', "campusRate", "campusComNum"],

  date() {
    return {}
  }
}
</script>

<style scoped>
.campusInfoWrapper {
  height: 185px;
  width: 800px;
  padding: 10px;
  /*border: #3c85cb solid 3px;*/
  box-shadow: 0 0 20px #cac6c6;
}

.campusBriefPhoto {
  display: inline-block;
  /*border: #3c85cb solid 3px;*/
  height: 180px;
  width: 180px;
}

.campusBriefInfo {
  display: inline-block;
  /*border: #3c85cb solid 3px;*/
  height: 180px;
  width: 580px;
  margin-left: 15px;
}


</style>
