var app = new Vue({
  el: '#app',
  data: {
    dbFile: null,
    rounds: []
  },
  mounted: async function() {
    this.rounds = (await axios.get("/all-game-data.json")).data;
  },
  computed: {
    dbFileSelected() {
      return this.dbFile?.length > 0;
    }
  },
  methods: {
    onDbFileChange(event) {
      this.dbFile = event.target.files?.length === 1 ? event.target.files[0].name : null;
    }
  }
});