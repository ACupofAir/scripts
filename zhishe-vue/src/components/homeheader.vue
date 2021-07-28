<template>
  <div class="headerWrapper">
    <div class="iconWrapper">
      <router-link to="/">
        <div class="logoWrapper">
          <img src="../assets/logo.png" id="logo">
          <img src="../assets/zhishelogo.png" height="42" width="92" id="zhishelogo">
        </div>
      </router-link>

    </div>
    <div class="searchWrapper">
      <el-autocomplete
          v-model="state"
          :fetch-suggestions="querySearchAsync"
          placeholder="搜索你的学校"
          @select="handleSelect"
          suffix-icon="el-icon-search"
          class="searchItem"
      ></el-autocomplete>
    </div>
  </div>
</template>

<script>
export default {
  name: "homeheader",
  data() {
    return {
      restaurants: [],
      state: '',
      timeout: null
    };
  },
  methods: {
    loadAll() {
      return [
        {"value": "东南大学", "address": "长宁区新渔路144号"},
        {"value": "南京大学", "address": "长宁区新渔路144号"},
      ];
    },
    querySearchAsync(queryString, cb) {
      let restaurants = this.restaurants;
      let results = queryString ? restaurants.filter(this.createStateFilter(queryString)) : restaurants;

      clearTimeout(this.timeout);
      this.timeout = setTimeout(() => {
        cb(results);
      }, 1000 * Math.random());
    },
    createStateFilter(queryString) {
      return (state) => {
        return (state.value.toLowerCase().indexOf(queryString.toLowerCase()) === 0);
      };
    },
    handleSelect(item) {
      console.log(item);
    }
  },
  mounted() {
    this.restaurants = this.loadAll();
  }
}
</script>

<style scoped>
/*样式*/
.logoWrapper {
  position: absolute;
  top: 8px;
  left: 30px;
}

#logo {
  position: absolute;
  left: 10px;
  right: 2px;
}

#zhishelogo {
  position: absolute;
  top: -1px;
  left: 55px;
}

.searchItem {
  width: 400px;
  position: absolute;
  top: 10px;
  right: 5px;
}


/*布局*/
.iconWrapper {
                grid-area: icon;
                /*border: aqua solid 3px;*/
                width: 200px;
                position: absolute;
                right: 2px;
                left: 2px;
                top: 1px;
                bottom: 1px;
}

.searchWrapper {
  grid-area: search;
  /*border: aquamarine solid 3px;*/
  width: 700px;
  position: absolute;
  right: 2px;
  /*left: 300px;*/
  top: 0px;
  bottom: 0px;
}

.headerWrapper {
  display: grid;
  grid-gap: 5px;
  grid-template-columns: 1fr 5fr;
  grid-template-areas:
          "icon search";
  box-shadow: 0 0 20px #cac6c6;
  position: absolute;
  right: 0px;
  left: 0px;
  top: 0px;
  /*bottom: 0px;*/
  height: 60px;
}

@media screen and (max-width: 590px) {
  .iconWrapper {
    grid-area: icon;
    /*border: black solid 3px;*/
    width: 200px;
    position: absolute;
    right: 2px;
    left: 2px;
    top: 1px;
    bottom: 1px;
  }

  .logoWrapper {
    position: absolute;
    top: 8px;
    left: 10px;
  }

  #zhishelogo {
    position: absolute;
    top: 5px;
    left: 57px;
    display: none;
  }
}

</style>
