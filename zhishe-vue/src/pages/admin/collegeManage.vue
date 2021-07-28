<template>
  <div class="checkWrapper">

    <div class="searchHeader">

      <div class="searchtable" style="margin-top: 0px; margin-left:10%; width: 80%;">
        <el-input placeholder="请输入内容" v-model="searchInput" class="input-with-select" style="margin-top: 25px;">
          <el-select v-model="select" slot="prepend" placeholder="请选择">
            <el-option label="地址" value="1"></el-option>
            <el-option label="学校" value="2"></el-option>
            <el-option label="校区" value="3"></el-option>
          </el-select>
          <el-button slot="append" icon="el-icon-search"></el-button>
        </el-input>
      </div>

      <div class="searchbutton">
        <el-row>
          <div class="" style="margin-right:0%; margin-top: 30px;">
            <el-button type="primary" plain style="margin-right: 50px;">查询</el-button>
            <el-button type="primary" @click="dialogFormVisible = true" plain style="margin-right: 50px;">添加</el-button>

            <el-dialog title="新增学校" :visible.sync="dialogFormVisible">
              <el-form :model="form">
                <el-form-item label="学校名称" :label-width="formLabelWidth">
                  <el-input v-model="form.schoolName" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="校区名称" :label-width="formLabelWidth">
                  <el-input v-model="form.campusName" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="校区地址" :label-width="formLabelWidth">
                  <el-input v-model="form.address" autocomplete="off"></el-input>
                </el-form-item>
              </el-form>
              <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="addItem">确 定</el-button>
              </div>
            </el-dialog>
          </div>
        </el-row>
      </div>
    </div>

    <div class="checkList">
      <el-table :data="tableData" border style="width: 100%;">
        <el-table-column prop="schoolName" label="学校" width="265">
        </el-table-column>
        <el-table-column prop="name" label="校区" width="265">
        </el-table-column>
        <el-table-column prop="address" label="地址" width="265">
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="370">
          <template slot-scope="scope">
            <el-button type="primary" @click="getEditCampusIndex(scope.$index)" plain style="margin-right: 50px;">编辑
            </el-button>

            <el-button type="danger" @click="disableCampus(scope.$index)" v-if="tableData[scope.$index].state == 1">禁 用
            </el-button>
            <el-button type="success"  @click="enableCampus(scope.$index)" v-if="tableData[scope.$index].state == 0">启 用
            </el-button>
          </template>
        </el-table-column>
      </el-table>

      <el-dialog title="修改学校" :visible.sync="editFormVisible">
        <el-form :model="form">
          <el-form-item label="学校名称" :label-width="formLabelWidth">
            <el-input v-model="form.schoolName" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="校区名称" :label-width="formLabelWidth">
            <el-input v-model="form.campusName" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="校区地址" :label-width="formLabelWidth">
            <el-input v-model="form.address" autocomplete="off"></el-input>
          </el-form-item>
        </el-form>
        <div slot="footer" class="dialog-footer">
          <el-button @click="editFormVisible = false">取 消</el-button>
          <el-button type="primary" @click="postEditedCampus()">确 定</el-button>
        </div>
      </el-dialog>
    </div>

  </div>


</template>

<script>
  export default {
    name: "check",

    data() {
      return {
        searchInput: '',
        select: '',
        tableData: [],

        dialogFormVisible: false,
        editFormVisible: false,
        form: {
          schoolName: '',
          campusName: '',
          address: '',
        },
        formLabelWidth: '120px',

        curEditCampusIndex: '',
      }
    },

    created() {
      let responseData = null
      let _this = this
      this.$axios
        .get('/campus/list/')
        .then(function (response) {
          responseData = response.data
          _this.tableData = responseData
        })
        .catch(failRes => {
          console.log(failRes.data)
          console.log("12321")
        })

    },

    methods: {
      addItem() {
        let _this = this
        this.$axios
          .post('/campus/post', {
            name: _this.form.schoolName + "-" + _this.form.campusName,
            address: _this.form.address,
            schoolName: _this.form.schoolName,
          })
          .then(successResponse => {
            console.log(successResponse.data);
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
        this.$axios
          .post('/college/post', {
            name: _this.form.schoolName,
            address: _this.form.address,
            campus1: _this.form.campusName,
            image: '',
            campusNum: 1,
            commentNum: 0,
            state: 1,
            coord: 2,
            scanNum: 0,
          })
          .then(successResponse => {
            console.log(successResponse.data);
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
        console.log("add success!")
        this.dialogFormVisible = false
        this.form = []

      },

      getEditCampusIndex(index) {
        this.editFormVisible = true
        this.curEditCampusIndex = index
      },

      postEditedCampus() {
        console.log(this.curEditCampusIndex)
        let _this = this
        this.$axios
          .post('/campus/updateCampus',
            {
              newName: _this.form.campusName,
              newAdress: _this.form.address,
              newSchoolName: _this.form.schoolName,
              editName: _this.tableData[_this.curEditCampusIndex].name,
            })
          .then(response => {
            console.log(response)
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
        this.editFormVisible = false
        this.form = []
      },

      disableCampus(index) {
        let _this = this
        this.tableData[index].state = 0
        console.log(this.tableData[index].name)
        this.$axios
          .post('/campus/updateCampusState',
            {
              campusState: 0,
              editName: _this.tableData[index].name,
            })
          .then(response => {
            console.log(response)
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
      },

      enableCampus(index) {
        let _this = this
        this.tableData[index].state = 1
        console.log(this.tableData[index].name)
        this.$axios
          .post('/campus/updateCampusState',
            {
              campusState: 1,
              editName: _this.tableData[index].name,
            })
          .then(response => {
            console.log(response)
          })
          .catch(failResponse => {
            console.log(failResponse.data)
          })
      },
    },

  }
</script>

<style scoped>
  .searchHeader {
    height: 150px;
    margin-top: 0px;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }



  .checkList {
    margin-top: 15px;
    height: 700px;
    box-shadow: 0 9px 9px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04);
    border-radius: 8px;
  }

  .el-select .el-input {
    width: 130px;
  }

  .input-with-select .el-input-group__prepend {
    background-color: #fff;
  }
</style>