<template>
  <div class="adminLog">
    <div class="pageHeader"></div>

    <div class="logContent">
      <el-table v-loading="loading" :data="tableData" style="width: 100%" height="600">
        <el-table-column fixed prop="icon" label="头像" width="120">
          <template slot-scope="scope">
            <img :src="scope.row.icon" style="height: 50px"/>
          </template>
        </el-table-column>
        <el-table-column prop="id" label="名称" width="140">
        </el-table-column>
        <el-table-column prop="setTime" label="设置时间" width="210">
        </el-table-column>
        <el-table-column prop="sex" label="性别" width="120">
        </el-table-column>
        <el-table-column prop="approvedQuantity" label="已审核数量" width="130">
        </el-table-column>
        <el-table-column prop="failedQuantity" label="未通过数量" width="130">
        </el-table-column>
        <el-table-column prop="realName" label="真实姓名" width="160">
        </el-table-column>
        <el-table-column prop="phone" label="联系方式" width="220">
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
        icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
        id: '靠子',
        setTime: '2021.07.09 17:33:25',
        sex: '男',
        approvedQuantity: 120,
        failedQuantity: 2,
        realName: '铁山靠',
        phone: '#########',
      },
        {
          icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
          id: '靠子',
          setTime: '2021.07.09 17:33:25',
          sex: '男',
          approvedQuantity: 120,
          failedQuantity: 2,
          realName: '铁山靠',
          phone: '#########',
        },
        {
          icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
          id: '靠子',
          setTime: '2021.07.09 17:33:25',
          sex: '男',
          approvedQuantity: 120,
          failedQuantity: 2,
          realName: '铁山靠',
          phone: '#########',
        },
        {
          icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
          id: '靠子',
          setTime: '2021.07.09 17:33:25',
          sex: '男',
          approvedQuantity: 120,
          failedQuantity: 2,
          realName: '铁山靠',
          phone: '#########',
        },
        {
          icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
          id: '靠子',
          setTime: '2021.07.09 17:33:25',
          sex: '男',
          approvedQuantity: 120,
          failedQuantity: 2,
          realName: '铁山靠',
          phone: '#########',
        },
        {
          icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
          id: '靠子',
          setTime: '2021.07.09 17:33:25',
          sex: '男',
          approvedQuantity: 120,
          failedQuantity: 2,
          realName: '铁山靠',
          phone: '#########',
        },
        {
          icon: "https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg",
          id: '靠子',
          setTime: '2021.07.09 17:33:25',
          sex: '男',
          approvedQuantity: 120,
          failedQuantity: 2,
          realName: '铁山靠',
          phone: '#########',
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
