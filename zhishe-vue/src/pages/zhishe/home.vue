<template>
  <div class="wrapper">
    <div class="box homeheader">
      <Header></Header>
    </div>
    <div class="box homecontent">
      <router-view/>
    </div>
    <div class="box homefooter">
      <Footer></Footer>
    </div>
  </div>
</template>

<script>
import Header from "@/components/homeheader";
import Footer from "@/components/homefooter";

export default {
  name: "home",
  components: {
    Header, Footer
  },
  data() {
    return {
      collegeName: "",
    }
  },
  mounted() {
    this.collegeName = this.$route.params.id;
  }
}
</script>

<style scoped>

.homeheader {
  /*grid-area: homeheader;*/
  /*border: #42b983 solid 5px;*/
  height: 60px;
}

.homefooter {
  /*grid-area: homefooter;*/
  /*!*border: #222222 solid 2px;*! */
  height: 90px;
}

.homecontent {
  /*grid-area: content;*/
  /*border: #222222 solid 2px;*/
  height: auto;
}

.wrapper {
  /*display: grid;*/
  /*grid-template-columns: 1fr 1fr 1fr;*/
  /*grid-template-rows: 60px auto 50px;*/
  /*grid-template-areas:*/
  /*  "header header header"*/
  /*  "content content content"*/
  /*  "footer  footer  footer";*/
  color: #444;
  height: 100%;
  width: 100%;
  position: absolute;
  top: 0;
  left: 0;
  overflow: auto;
}

.box {
  color: #222222; /*字体颜色*/
  border-radius: 5px;
  font-size: 150%;
}
</style>
