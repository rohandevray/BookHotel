//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract HotelRoom {
    enum Status {
        Vacant,
        Occupied
    }
    Status public currentStatus;

    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
        currentStatus = Status.Vacant;
    }

    //events
    event Occupy(address _occupant, uint256 _value);
    // modifiers
    modifier onlywhileVacent() {
        require(currentStatus == Status.Vacant, "Currently occupied");
        // reuqire function checks whether the statement is true or not
        _;
    }

    modifier costs(uint256 _amount) {
        require(msg.value >= _amount, "Not enough ether provided!");
        _;
    }

    function Book() public payable onlywhileVacent costs(2 ether) {
        currentStatus = Status.Occupied;
        owner.transfer(msg.value);
        // (bool sent, bytes memory data) = owner.call{value: msg.value}("");
        //whenever anyone book a hotel
        emit Occupy(msg.sender, msg.value);
    }
}
