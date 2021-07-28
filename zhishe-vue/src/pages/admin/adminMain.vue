<template>
  <div>
    <el-row :gutter="10">
      <el-col :span="8">
        <el-row :gutter="10">
          <el-card shadow="hover" style="height: 200px">
            <div class="user-info">
              <el-image :src="admin_icon" class="user-avator"></el-image>
              <span>
                <div class="user-info-name">{{ admin_id }}</div>
                <div class="user-info-cont">{{ role }}</div>
              </span>
            </div>
            <div style="margin-top: 30px">
              <div>今天也是适合审核的一天呢~</div>
            </div>
          </el-card>
        </el-row>
        <el-row :gutter="10">
          <el-card shadow="hover" style="height: 266px">
            <template #header>
              <div style="text-align: left">
                <span>成分查询</span>
              </div>
            </template>
            <el-col :span="5">
              <div
                v-for="(item, index) in labelCons"
                :key="index"
                class="labelPro"
              >
                {{ item.name }}
              </div>
            </el-col>
            <el-col :span="18">
              <el-progress
                v-for="(item, index) in labelPros"
                :key="index"
                :percentage="item.num"
                :stroke-width="8"
              ></el-progress>
            </el-col>
          </el-card>
        </el-row>
      </el-col>
      <el-col :span="16">
        <el-row :gutter="10">
          <el-col :span="8" v-for="(item, index) in scanMsg" :key="index">
            <el-card shadow="hover" :body-style="{ padding: '0px' }">
              <div class="grid-content grid-con-1">
                <i :class="item.icon" class="grid-con-icon"></i>
                <!-- <img src="el-icon-user-solid" alt="mark"/> -->
                <div class="grid-cont-right">
                  <div class="grid-num">{{ item.num }}</div>
                  <div>{{ item.name }}</div>
                </div>
              </div>
            </el-card>
          </el-col>
        </el-row>

        <el-card shadow="hover">
          <template #header>
            <div style="text-align: left">
              <span> 待办事项 </span>
              <el-button
                style="float: right; padding: 3px 0"
                type="text"
                v-on:click="addList"
              >
                添加
              </el-button>
            </div>
            <el-dialog
              title="添加事项"
              :visible.sync="visible"
              style="margin-top: 200px"
            >
              <el-input
                v-model="input"
                placeholder="请输入内容"
                v-on:keyup.enter.native="edit"
              >
              </el-input>
              <div style="text-align: right">
                <el-button
                  size="mini"
                  type="text"
                  @click="visible = false"
                  style="margin-top: 30px"
                  >取消
                </el-button>
                <el-button type="primary" size="mini" v-on:click="edit"
                  >确定
                </el-button>
              </div>
            </el-dialog>
          </template>
          <el-table
            :show-header="false"
            :data="todoList"
            style="width: 100%; height: 283px"
          >
            <el-table-column width="40">
              <template #default="scope">
                <el-checkbox v-model="scope.row.status"></el-checkbox>
              </template>
            </el-table-column>
            <el-table-column>
              <template #default="scope">
                <div
                  class="todo-item"
                  :class="{
                    'todo-item-del': scope.row.status,
                  }"
                >
                  {{ scope.row.title }}
                </div>
              </template>
            </el-table-column>
            <el-table-column width="55">
              <template #default="scope">
                <span>
                  <template>
                    <el-popconfirm
                      title="确定删除这个事项吗？"
                      @confirm="remove(scope.$index)"
                    >
                      <el-button
                        size="small"
                        icon="el-icon-delete"
                        circle
                        slot="reference"
                      >
                      </el-button>
                    </el-popconfirm>
                  </template>
                </span>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="20">
      <el-col :span="12">
        <el-card shadow="hover" style="height: 350px">
          <!-- <template> -->
          <div>
            <div
              id="mychart"
              :style="{ width: '400px', height: '300px' }"
            ></div>
            <!-- <div>青春是一个短暂的美梦, 当你醒来时, 它早已消失无踪</div>
              <el-divider></el-divider>
              <div style="margin-top: -7px">希望风雨过后，发量依旧如初</div> -->
          </div>
          <!-- </template> -->
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card shadow="hover" style="height: 350px">
          <div id="yourchart" :style="{ width: '400px', height: '300px' }">
            <!-- <div style="text-align: left">--------前端好难</div>
            <div style="text-align: left">--------有一说一</div>
            <div style="text-align: left">--------确实</div> -->
          </div>
          <!-- <div>
            ————
          </div> -->
          <!-- <div style="text-align: right; margin-right: 40px">
            @河底摸鱼工作室
          </div> -->
        </el-card>
      </el-col>
    </el-row>
    <el-dialog title="提示" :visible.sync="dialogVisible" width="30%">
      <span>登录已过期，请重新登录</span>
      <span slot="footer" class="dialog-footer">
        <el-button @click="back">取 消</el-button>
        <el-button type="primary" @click="back">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
// import * as echarts from 'echarts';
export default {
  
  name: "adminMain",
  data() {
    return {
      admin_icon: require("../../assets/image.jpg"),
      input: "",
      visible: false,
      dialogVisible: false,
      admin_id : "",
      role: "超级管理员",
      scanMsg: [
        {name: "浏览总数", icon: "el-icon-user-solid", num: 1234},
        {name: "学校总数", icon: "el-icon-school", num: 25},
        {name: "评论总数", icon: "el-icon-edit-outline", num: 999},
      ],
      todoList: [
        {title: "看看今天的首页", status: true},
        {title: "看看今天的审核请求", status: false},
        {title: "我要审核100条评论！", status: false},
        // { title: "再看看有多少管理员", status: false },
        {title: "学校是不是有点少", status: true},
        // { title: "日志里面有内容吗", status: true },
      ],
      listNum: 4,
      labelCons: [
        {name: "批小将"},
        {name: "社畜"},
        {name: "二刺螈"},
        {name: "拳师"},
        {name: "大学生"},
      ],
      labelPros: [
        {num: 50},
        {num: 5},
        {num: 60},
        {num: 10},
        {num: 80},
      ],
      id:"",
      time: 0,
      
    };
  },
  created(){
    this.time = window.sessionStorage.getItem('time');
    if(new Date().getTime() - this.time < 1000000)
    {
      this.admin_id = window.sessionStorage.getItem('data');
    }
    else
    {
      window.sessionStorage.removeItem('data');
      window.sessionStorage.removeItem('time');
      this.dialogVisible = true;
    }
    // console.log(new Date().getTime());
  },
  methods: {
    back(){
      this.dialogVisible = false;
      location.href = "/adminLogin"; 
    },
    addList() {
      if (this.listNum === 5) {
        const h = this.$createElement;
        this.$notify({
          title: "添加失败",
          message: h("e", {style: "color: #3c85cb"}, "待办事件数达上限"),
        });
      } else {
        this.visible = true;
        // this.listNum = this.todoList.push({ title: "rains", status: false });
      }
    },
    edit() {
      this.visible = false;
      this.listNum = this.todoList.push({title: this.input, status: false});
      this.input = "";
    },
    remove(line) {
      this.todoList.splice(line, 1);
      this.listNum--;
    },
  },
  mounted(){
    // let myChart = this.$echarts.init(document, getElementById('mychart'))
    // var chartDom = document.getElementById('mychart');
    // var myChart = echarts.init(chartDom);
    // var option;
    var echarts = require('echarts');
    var myChart = echarts.init(document.getElementById('mychart'));

        // 指定图表的配置项和数据
        myChart.setOption( {
            color: '#3c85cb',
            title: {
                text: '知舍人员成分'
            },
            tooltip: {},
            legend: {
                data:['浓度']
            },
            xAxis: {
                data: ["批小将","社畜","二刺螈","拳师","大学生","煞笔"]
            },
            yAxis: {},
            series: [{
                name: '浓度',
                type: 'bar',  
                data: [5, 20, 36, 10, 10, 20]
            }]
        });

      var yourChart = echarts.init(document.getElementById('yourchart'));
      yourChart.setOption(
        {
    color: ['#80FFA5', '#00DDFF', '#37A2FF', '#FF0087', '#FFBF00'],
    title: {
        text: '渐变堆叠面积图'
    },
    tooltip: {
        trigger: 'axis',
        axisPointer: {
            type: 'cross',
            label: {
                backgroundColor: '#6a7985'
            }
        }
    },
    legend: {
        data: ['Line 1', 'Line 2', 'Line 3', 'Line 4', 'Line 5']
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    xAxis: [
        {
            type: 'category',
            boundaryGap: false,
            data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
        }
    ],
    yAxis: [
        {
            type: 'value'
        }
    ],
    series: [
        {
            name: 'Line 1',
            type: 'line',
            stack: '总量',
            smooth: true,
            lineStyle: {
                width: 0
            },
            showSymbol: false,
            areaStyle: {
                opacity: 0.8,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                    offset: 0,
                    color: 'rgba(128, 255, 165)'
                }, {
                    offset: 1,
                    color: 'rgba(1, 191, 236)'
                }])
            },
            emphasis: {
                focus: 'series'
            },
            data: [140, 232, 101, 264, 90, 340, 250]
        },
        {
            name: 'Line 2',
            type: 'line',
            stack: '总量',
            smooth: true,
            lineStyle: {
                width: 0
            },
            showSymbol: false,
            areaStyle: {
                opacity: 0.8,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                    offset: 0,
                    color: 'rgba(0, 221, 255)'
                }, {
                    offset: 1,
                    color: 'rgba(77, 119, 255)'
                }])
            },
            emphasis: {
                focus: 'series'
            },
            data: [120, 282, 111, 234, 220, 340, 310]
        },
        {
            name: 'Line 3',
            type: 'line',
            stack: '总量',
            smooth: true,
            lineStyle: {
                width: 0
            },
            showSymbol: false,
            areaStyle: {
                opacity: 0.8,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                    offset: 0,
                    color: 'rgba(55, 162, 255)'
                }, {
                    offset: 1,
                    color: 'rgba(116, 21, 219)'
                }])
            },
            emphasis: {
                focus: 'series'
            },
            data: [320, 132, 201, 334, 190, 130, 220]
        },
        {
            name: 'Line 4',
            type: 'line',
            stack: '总量',
            smooth: true,
            lineStyle: {
                width: 0
            },
            showSymbol: false,
            areaStyle: {
                opacity: 0.8,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                    offset: 0,
                    color: 'rgba(255, 0, 135)'
                }, {
                    offset: 1,
                    color: 'rgba(135, 0, 157)'
                }])
            },
            emphasis: {
                focus: 'series'
            },
            data: [220, 402, 231, 134, 190, 230, 120]
        },
        {
            name: 'Line 5',
            type: 'line',
            stack: '总量',
            smooth: true,
            lineStyle: {
                width: 0
            },
            showSymbol: false,
            label: {
                show: true,
                position: 'top'
            },
            areaStyle: {
                opacity: 0.8,
                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                    offset: 0,
                    color: 'rgba(255, 191, 0)'
                }, {
                    offset: 1,
                    color: 'rgba(224, 62, 76)'
                }])
            },
            emphasis: {
                focus: 'series'
            },
            data: [220, 302, 181, 234, 210, 290, 150]
        }
    ]
})
        // 使用刚指定的配置项和数据显示图表。
        // myChart.setOption(option);
        
}
};
</script>

<style scoped>
.labelPro {
  /* margin-top: 4px;
  margin-bottom: 10px; */
  line-height: 35px;
}

.el-progress {
  margin-top: 10px;
  margin-bottom: 17px;
}

.el-card {
  border: #3c85cb solid 1px;
}

.el-row {
  margin-bottom: 20px;
}

.grid-content {
  display: flex;
  align-items: center;
  height: 85px;
}

.grid-cont-right {
  flex: 1;
  text-align: center;
  font-size: 14px;
  color: rgb(150, 150, 150);
}

.grid-num {
  font-size: 30px;
  /* font-weight: bold; */
}

.grid-con-icon {
  /* margin-left: -2px; */
  font-size: 60px;
  width: 92px;
  height: 90px;
  line-height: 80px;
  color: #fff;
}

.grid-con-1 .grid-con-icon {
  background: #3c85cb;
}

.todo-item {
  font-size: 14px;
}

.todo-item-del {
  text-decoration: line-through;
  color: #999;
}

.schart {
  width: 100%;
  height: 300px;
}

.user-info {
  /* display: flex; */
  /* position: absolute; */
  /* top:0px;
  bottom:0px;
  left:80px;
  right:0px; */
  /* align-items: center; */
  padding-bottom: 20px;
  border-bottom: 2px solid #ccc;
  margin-bottom: 20px;
}

.user-avator {
  /* position: inline-block; */
  /* top:0px;
  bottom:0px;
  left:80px;
  right:0px; */
  /* margin-left: 0px; */
  margin-right: 230px;
  margin-left: 0px;
  width: 70px;
  height: 70px;
  border-radius: 100%;
}

.user-info-name {
  /* position: relative; */
  font-size: 35px;
  line-height: 0px;
  margin-top: -20px;
  margin-bottom: 0px;
  /* position: inline-block; */
  /* margin-top:0px; */
  /* margin-bottom:1160px; */
  /* margin-left: 50px; */
}

.user-info-cont {
  /* padding-left: 50px; */
  /* flex: 1; */
  margin-left: 165px;
  margin-right: 0px;

  font-size: 5px;
  color: rgb(200, 200, 200);
}
</style>
