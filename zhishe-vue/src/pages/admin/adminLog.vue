<template>
  <div class="adminLog">
    <div class="pageHeader"></div>

    <div class="logContent">
      <el-table v-loading="loading" :data="tableData" style="width: 100%" height="600">
        <el-table-column fixed prop="operator" label="操作人" width="150">
        </el-table-column>
        <el-table-column prop="type" label="操作类型" width="150">
        </el-table-column>
        <el-table-column prop="id" label="操作对象" width="150">
        </el-table-column>
        <el-table-column prop="campus" label="对象校区" width="190">
        </el-table-column>
        <el-table-column prop="college" label="对象学校" width="190">
        </el-table-column>
        <el-table-column prop="time" label="操作时间" width="220">
        </el-table-column>
        <el-table-column prop="state" label="修改后评论状态" width="120">
        </el-table-column>
      </el-table>

    </div>
  </div>
</template>

<script>
export default {
  name: "adminLog",
  data() {
    return {
      loading: false,
      tableData: [{
        operator: 'Run',
        type: '修改',
        id: '0000003',
        campus: '九龙湖校区',
        college: '东南大学',
        time: '2021.07.09 17:33:25',
        state: '未发布',
      },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        }, {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        },
        {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        }, {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        }, {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        }, {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        }, , {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        }, , {
          operator: 'Baobao',
          type: '修改',
          id: '0000001',
          campus: '丁家桥校区',
          college: '东南大学',
          time: '2021.07.09 17:30:25',
          state: '已发布',
        },
        {
          operator: 'Rain',
          type: '删除',
          id: '0000002',
          campus: '四牌楼校区',
          college: '东南大学',
          time: '2021.07.09 17:32:25',
          state: '已删除',
        },
      ]
    }
  }

}
</script>

<style scoped>
body {
  margin: 0;
}
</style>
