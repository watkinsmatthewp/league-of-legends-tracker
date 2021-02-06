var app = new Vue({
  el: '#app',
  data: {
    rounds: []
  },
  mounted: async function() {
    this.rounds = (await axios.get("/all-game-data.json")).data;
    console.log(this.rounds);
  }
});