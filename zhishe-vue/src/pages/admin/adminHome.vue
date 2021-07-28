<template>
  <el-container class="adminWrapper">
    <el-header class="adminHeaderWrapper">
        <span class="iconWrapper" style="display:inline-block">
          <router-link to="/">
            <div class="logoWrapper">
              <img src="../../assets/logo.png" id="logo" style="display:inline-block; margin-top: 10px">
              <img src="../../assets/zhishelogo.png" height="42" width="92" id="zhishelogo"
                   style="display:inline-block">
            </div>
          </router-link>
        </span>
      <span style="display:inline-block">知舍后台管理</span>
    </el-header>
    <el-container>
      <el-aside width="200px" class="adminAsideWrapper">
        <Side></Side>
      </el-aside>
      <el-main class="adminMainWrapper">
        <router-view></router-view>
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
import Side from "../../components/sideBar.vue";

export default {
  name: "adminHome",
  components: {
    Side,
  },
}
</script>

<style scoped>
.adminHeaderWrapper {
  /*border: #3c85cb solid 2px;*/
  box-shadow: 0 0 20px #cac6c6;
}

.adminAsideWrapper {
  /*border: #3c85cb solid 2px;*/

}

.adminMainWrapper {
  /*border: #3c85cb solid 2px;*/

}
</style>
