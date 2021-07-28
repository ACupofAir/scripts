<template>
  <div class="footerWrapper">
    <div class="footerLogo">
      <img src="../assets/zhishelogo.png" id="zhishelogo" height="42" width="92">
    </div>
    <div class="copyrightWrapper">
      ©2021 河底摸鱼
    </div>
  </div>
</template>

<script>
export default {
  name: "homefooter"
}
</script>

<style scoped>

.footerWrapper {
  position: absolute;
  width: 100%;
  background-color: #f7f6f8;
}

.footerLogo {
  margin-top: 10px;
}

.copyrightWrapper {
  font-size: 15px;
}

</style>
