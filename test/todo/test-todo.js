const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Todo Contract", function () {
  let todoContract;
  let owner,odko;

  beforeEach(async function () {
    const [_owner,_odko] = await ethers.getSigners();
    owner = _owner;
    odko = _odko;

    const Todo = await ethers.getContractFactory("TodoContract");
    todoContract = await Todo.deploy();
    await todoContract.deployed();
  })

  it("Creating Todo", async function () {
    await todoContract.createTodo('milk')

    expect(await todoContract.todosLength()).to.equal(ethers.BigNumber.from('1'));
    expect(await todoContract.todos(1)).to.equal('milk');
  });


  it("Change Owner", async function () {
    await todoContract.setOwner(odko.address)

    expect(await todoContract.owner()).to.equal(odko.address);
  });

});

