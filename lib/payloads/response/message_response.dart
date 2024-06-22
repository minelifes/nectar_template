class MessageResponse {
  final String message;
  MessageResponse(this.message);

  factory MessageResponse.successfullyRemoved() =>
      MessageResponse("Successfully removed");

  Map<String, dynamic> toJson() => {'message': message};
}
