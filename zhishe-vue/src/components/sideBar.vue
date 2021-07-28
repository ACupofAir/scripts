<template>
  <div class="sideBarWrapper">
    <el-row class="tac" style="height: 100%">
      <el-col :span="23" class="sideBar">
        <el-menu
            default-active="1"
            class="el-menu-vertical-demo"
            background-color="#3c85cb"
            text-color="#fff"
            active-text-color="#ffd04b"
            style="height: 100%">
          <router-link v-for="(item, ind) in sideItems" :key="ind" :to="item.routerIndex">
            <el-menu-item :index="ind.toString()" style="text-align: left;">
              <i :class="item.icon"></i>
              {{item.title}}
            </el-menu-item>
          </router-link>


        </el-menu>
      </el-col>
    </el-row>
  </div>
</template>

<script>

export default {
  data() {
    return {
      sideItems: [{icon: 'el-icon-s-home', title: '首页', routerIndex: '/adminMain'},
        {icon: 'el-icon-s-comment', title: '审核请求', routerIndex: '/check'},
        {icon: 'el-icon-user-solid', title: '管理员列表', routerIndex: '/adminList'},
        {icon: 'el-icon-s-order', title: '日志', routerIndex: '/log'},
        {icon: 'el-icon-s-grid', title: '学校管理', routerIndex: '/collegeManage'},
      ]
    }
  }
};
</script>

<style scoped>
.sideBarWrapper {
  height: 100%;
  /*background-color: #3c85cb;*/
}

.sideBar {
  height: 100%;
}
</style>
