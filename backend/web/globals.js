// Patient Data
var patients = {
    "rui dong": {
      name: "Rui Dong",
      ic: "S0123456C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 60,
      ward: 1,
    },
    "robby": {
      name: "Robby",
      ic: "S1234567C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 61,
      ward: 1,
    },
    "hong rui": {
      name: "Hong Rui",
      ic: "S2345678C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 62,
      ward: 1,
    },
    "xing xiao": {
      name: "Xing Xiao",
      ic: "S3456789C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Female",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 63,
      ward: 2,
    },
    "raphael": {
      name: "Raphael",
      ic: "S4567890C",
      race: "Chinese",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 64,
      ward: 2,
    },
    "jan gabriel": {
      name: "Jan Gabriel",
      ic: "S5678901C",
      race: "Filipino",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 65,
      ward: 3,
    },
    "frederick": {
      name: "Frederick",
      ic: "S6789012C",
      race: "Filipino",
      emergencyContact: "+6567773777",
      gender: "Male",
      dateOfBirth: new Date("1940-12-07T00:00:00+0800"),
      age: 66,
      ward: 3,
    },
}

// Login Credentials
var credentials = [
    { name: "robby", password: "poop" },
    { name: "rui dong", password: "poop" },
    { name: "hong rui", password: "poop" },
    { name: "frederick", password: "poop" },
]

module.exports = { patients, credentials }