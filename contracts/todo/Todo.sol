// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract TodoContract {

  struct Todo {
    string content;
  }

  address public owner;
  mapping(uint => Todo) public todos;
  uint public id;

  error NotOwner(address _sender,address _owner);
  error SameOwner(address _sender,address _owner);

  constructor() {
    owner = msg.sender;
  }

  function createTodo(string memory _content) external onlyOwner{
    Todo memory _todo = Todo(_content);
    id += 1;
    todos[id] = _todo;
  }

  function todosLength() external view returns(uint){
    return id;
  }


  function setOwner(address _newOwner) external onlyOwner sameOwner(_newOwner) {
    owner = _newOwner;
  }

  modifier sameOwner(address _newOwner){
    if(_newOwner == owner){
      revert SameOwner(msg.sender,owner);
    }
    _;
  }

  modifier onlyOwner(){
    if(msg.sender != owner){
      revert NotOwner(msg.sender,owner);
    }
    _;
  }
}
