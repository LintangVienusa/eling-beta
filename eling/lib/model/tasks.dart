class Tasks{
    int? id;
    String? taskCats;
    String? taskName;
    String? taskDesc;
    int? remindAt;
    
    Tasks({this.id, this.taskCats, this.taskName, this.taskDesc, this.remindAt});
    
    Map<String, dynamic> toMap() {
        var map = Map<String, dynamic>();
    
        if (id != null) {
          map['id'] = id;
        }
        map['taskCats'] = taskCats;
        map['taskName'] = taskName;
        map['taskDesc'] = taskDesc;
        map['remindAt'] = remindAt;

        
        return map;
    }
    
    Tasks.fromMap(Map<String, dynamic> map) {
        this.id = map['id'];
        this.taskCats = map['taskCats'];
        this.taskName = map['taskName'];
        this.taskDesc = map['taskDesc'];
        this.remindAt = map['remindAt'];

        var converteddata = DateTime.fromMillisecondsSinceEpoch(map['remindAt']);
        
    }
}