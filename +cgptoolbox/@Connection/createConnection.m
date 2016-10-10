function value = createConnection(this)
    this.nodeIndex_ = this.findWhichNodeBelongs_();
    this.possibleConnections_ = this.findPossibleConnections_();
    value = this.possibleConnections_(randi(size(this.possibleConnections_, 2)));
end
