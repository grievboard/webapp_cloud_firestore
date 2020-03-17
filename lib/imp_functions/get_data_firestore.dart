import 'package:cloud_firestore/cloud_firestore.dart';

class AddData{

  var _fireStore = Firestore.instance;
  //cont variable is initialized with either acknowledged or completed list.
  final contObject, cont, previousCont, status;
  AddData(this.contObject, this.cont, this.previousCont, this.status);

  Future addData() async{
    await _fireStore.collection(cont).document('${contObject.postId}').setData({
      'status': 'acknowledged',
      'username': '${contObject.username}',
      'location': '${contObject.location}',
      'description': '${contObject.description}',
      'postId': '${contObject.postId}',
      'name': '${contObject.name}',
      'ownerId': '${contObject.ownerId}',
      'mediaUrl': '${contObject.mediaUrl}',
      'isPrivate': contObject.isPrivate,
      'consequences': contObject.consequences,
      'timestamp': '${contObject.timestamp}',
      'likes': contObject.likes,
//      'likes': acknowledgedData1.likes,
    });
    _fireStore.collection(previousCont).document('${contObject.postId}').delete();
    _fireStore.collection('posts').document('${contObject.ownerId}').collection('userPosts').document('${contObject.postId}').updateData({'status':status});
  }
}