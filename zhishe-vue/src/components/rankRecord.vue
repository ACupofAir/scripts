<template>
  <div>
    <div id='name'>
      <el-row>
        <el-button type="primary" plain v-on:click="enter">{{msg}}</el-button>
      </el-row>
      <!-- target = "_blank" -->
      <!-- <a href="https://www.seu.edu.cn/" >{{msg}}</a> -->
    </div>
    <div id='score'>
      <el-rate
          v-model="value"
          :colors="colors"
          disabled
          show-score
          text-color="#3c85cb"
          score-template="{value}">
      </el-rate>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    msg: String,
    value: Number,
  },
  data() {
    return {
      colors: ['#d0d0d0', '#6388a9', '#3c85cb'],
    }
  },
  methods: {
    enter() {
      location.href = "/college/" + this.msg;
    }
  }
}
</script>

<style scoped>
#name {
  /* position: absolute; */
  display: inline-block;
  height: 50px;
  width: 200px;
  bottom: 0px;
  top: 0px;
  right: 0px;
  left: 170px;
  /* background-color: aqua; */
}

#score {
  display: inline-block;
  bottom: 0px;
  top: 10px;
  right: 0px;
  left: 360px;
  height: 50px;
  width: 200px;
  /* background-color: black; */
}
</style>
