<template>
  <div class="checkWrapper">

    <div class="searchHeader">

      <div class="searchtable" style="margin-left:28px; width: 400px;">
        <el-input placeholder="请输入内容" v-model="input" class="input-with-select" style="margin-top: 25px;">
          <el-button slot="append" icon="el-icon-search"></el-button>
        </el-input>
      </div>

    </div>

    <div class="checkList">
      <el-table :data="tableData" border style="width: 100%;" :stripe="isStripe">
        <el-table-column fixed prop="id" label="评价编号" width="85">
        </el-table-column>
        <el-table-column prop="campus" label="学校-校区" width="235">
        </el-table-column>
        <el-table-column prop="dorm" label="宿舍区" width="135">
        </el-table-column>
        <el-table-column prop="isNewCampus" label="是否新添加校区" width="135">
        </el-table-column>
        <el-table-column prop="isNewSchool" label="是否新添加学校" width="135">
        </el-table-column>
        <el-table-column prop="email" label="联系邮箱" width="195">
        </el-table-column>
        <el-table-column prop="state" label="当前状态" width="105">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="170">
          <template slot-scope="scope">
            <el-button size="mini" @click="editComment(scope.$index)">详情</el-button>
            <el-button size="mini" type="success"  @click="postComment(scope.$index)" v-if="tableData[scope.$index].state === '未发布'">发布</el-button>
            <el-button size="mini" type="success"  @click="CancelPostComment(scope.$index)" v-if="tableData[scope.$index].state === '已发布'">取消发布</el-button>
          </template>
        </el-table-column>
      </el-table>
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
  name: "check",
  components: {comDetails},
  data() {
    return {
      input: '',
      select: '',
      tableData: [],
      isStripe: true,
      dialogVisible: false,
      commentDetails:{
        detailRate: 0,
        detailName: 0,
        isRecommend: false,
        admissionTime: 2000,
        grade: "toGrade",
        dormArea: 4,
        dormScale: 3 + "人间",
        rate: [{ rateTitle: "基础情况(桌椅床铺门窗等)", rateScore: 3 },
          { rateTitle: "建筑情况(新旧和楼层布局)", rateScore: 3 },
          { rateTitle: "位置情况(周边环境和位置)", rateScore: 3 }],
        label: ["空调", "洗衣机", "WIFI", "独立卫浴",],
        comment: "",
        dormPicture: ["https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg"]
      },
    }
  },
  methods: {
    editComment(index) {
      this.dialogVisible = true
      let _this = this
      this.$axios
          .get('/comment/id/' + _this.tableData[index].id)
          .then(response => {
            let com = response.data
            console.log(com)
            let toGrade = ""
            switch (com.grade) {
              case 1: toGrade = "大一"; break;
              case 2: toGrade = "大二"; break;
              case 3: toGrade = "大三"; break;
              case 4: toGrade = "大四"; break;
              case 5: toGrade = "大五"; break;
              case 6: toGrade = "研究生"; break;
            }
            _this.commentDetails = {
                detailRate: com.score,
                detailName: com.campus,
                isRecommend: com.recommend,
                admissionTime: com.year,
                grade: toGrade,
                dormArea: com.dorm,
                dormScale: com.scale + "人间",
                rate: [{ rateTitle: "基础情况(桌椅床铺门窗等)", rateScore: com.facilities },
                  { rateTitle: "建筑情况(新旧和楼层布局)", rateScore: com.architecture },
                  { rateTitle: "位置情况(周边环境和位置)", rateScore: com.surrounding }],
                label: ["空调", "洗衣机", "WIFI", "独立卫浴",],
                comment: com.briefComment,
                dormPicture: ["https://gitee.com/thisisbadBao/imgrepo/raw/master/imgrepo1/20210715214908.jpeg"]
            }
          }).catch(failResponse => {
        console.log(failResponse)
      })
    },

    postComment(index) {
      let _this = this
      this.tableData[index].state = '已发布'
      console.log(this.tableData[index].id)
      this.$axios
          .post('/comment/updateState',
              {
                comment_id: _this.tableData[index].id,
                comment_state: 1
              })
          .then(response => {
            console.log(response)
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
    },

    CancelPostComment(index) {
      this.tableData[index].state = '未发布'
      let _this = this
      console.log(this.tableData[index].id)
      this.$axios
          .post('/comment/updateState',
              {
                comment_id: _this.tableData[index].id,
                comment_state: 0
              })
          .then(response => {
            console.log(response)
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
    }
  },



  created() {
    let responseData = null
    let _this = this
    this.$axios
        .get('/comment/list/')
        .then(function (response) {
          responseData = response.data
          console.log(responseData)
          for (let item of responseData) {
            _this.tableData.push({
              id: item.id,

              campus: item.campus,

              dorm: item.dorm,

              location: item.location,

              year: item.year,

              grade: item.grade,

              scale: item.scale,

              recommend: item.recommend,

              email: item.email,

              facilities: item.facilities,

              architecture: item.architecture,

              surrounding: item.surrounding,

              score: item.score,

              photo: item.photo,

              briefComment: item.briefComment,

              airConditioner: item.airConditioner,

              sofa: item.sofa,

              outdoorBalcony: item.outdoorBalcony,

              washingMachine: item.washingMachine,

              refrigerator: item.refrigerator,

              cooking: item.cooking,

              wifi: item.wifi,

              restroom: item.restroom,

              timeStamp: item.timeStamp,

              studyroom: item.studyroom,

              state: item.state ? '已发布' : '未发布',

              isNewSchool: item.isNewSchool ? '是' : '否',

              isNewCampus: item.isNewCampus ? '是' : '否',

              isChecked: item.isChecked,
            })
          }
          _this.tableData = _this.tableData.reverse()
          // console.log(_this.tableData)
        })
        .catch(failRes => {
          console.log(failRes.data)
        })
  }
}
</script>

<style scoped>
  .searchHeader {
    box-shadow: 0 0 20px #cac6c6;
    height: 90px;
    margin-top: 0px;

  }

  .checkList {
    margin-top: 15px;
    box-shadow: 0 0 20px #cac6c6;
    height: 600px;
  }

  .el-select .el-input {
    width: 130px;
  }

  .input-with-select .el-input-group__prepend {
    background-color: #fff;
  }
</style>
