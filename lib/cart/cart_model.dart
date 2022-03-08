class JobList {
  int id;
  int customerId;
  int parcelId;
  double deliveryCharge;
  double total;
  bool isAccepted;
  bool isDelivered;
  bool isCancelled;
  DateTime createdAt;

  static var listitm = [
    JobList(
      id: 1,
      customerId: 112,
      parcelId: 30,
      deliveryCharge: 150,
      total: 250,
      isAccepted: false,
      isDelivered: false,
      isCancelled: false,
      createdAt: DateTime.now(),
    ),
    JobList(
      id: 2,
      customerId: 221,
      parcelId: 31,
      deliveryCharge: 90,
      total: 230,
      isAccepted: false,
      isCancelled: false,
      isDelivered: false,
      createdAt: DateTime.now(),
    ),
  ];

  JobList({
     this.id,
     this.customerId,
     this.parcelId,
     this.deliveryCharge,
     this.total,
     this.isAccepted,
     this.isCancelled,
     this.isDelivered,
     this.createdAt,
  });
}

List<JobList> listitm = [
  JobList(
    id: 1,
    customerId: 112,
    parcelId: 30,
    deliveryCharge: 150,
    total: 30,
    isAccepted: false,
    isCancelled: false,
    isDelivered: false,
    createdAt: DateTime.now(),
  ),
  JobList(
    id: 2,
    customerId: 221,
    parcelId: 31,
    deliveryCharge: 150,
    total: 30,
    isAccepted: false,
    isCancelled: false, 
    isDelivered: false,
    createdAt: DateTime.now(),
  ),
];
