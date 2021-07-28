<template>
  <div>
    <el-checkbox v-model="msg" :label="msg" border></el-checkbox>
  </div>
</template>

<script>
export default {
  props: {
    msg: String,
  },
};
</script>

<style scoped>

</style>