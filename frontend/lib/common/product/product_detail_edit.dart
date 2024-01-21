import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/common/appbar/appbar.dart';
import 'package:frontend/common/custom-shapes/curved_edge_widget.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';
import 'package:frontend/common/texts/section_heading.dart';
import 'package:frontend/helper-function/image_helper.dart';
import 'package:frontend/common/custom-shapes/circular_container.dart';
import 'package:frontend/main-pages/bottom_nav_bar.dart';

class ProductDetailEdit extends StatefulWidget {
  const ProductDetailEdit({Key? key, required this.entry, required this.id})
      : super(key: key);

  final Map<String, dynamic> entry;
  final String? id;

  @override
  State<ProductDetailEdit> createState() => _ProductDetailEditState();
}

class _ProductDetailEditState extends State<ProductDetailEdit> {
  final TextEditingController _serviceNameController = TextEditingController();
  final TextEditingController _serviceCategoryController =
      TextEditingController();
  final TextEditingController _serviceDescriptionController =
      TextEditingController();
  final TextEditingController _servicePriceController = TextEditingController();
  final TextEditingController _userQualificationController =
      TextEditingController();
  final updateSnackBar = SnackBar(
      content: Text(
        'Service updated!',
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.green,
      duration: Duration(seconds: 3));

  final deleteSnackBar = SnackBar(
      content: Text('Service deleted!'),
      backgroundColor: Colors.blueAccent,
      duration: Duration(seconds: 3),
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating);
  @override
  void initState() {
    _serviceNameController.text = widget.entry['serviceName'];
    _serviceCategoryController.text = widget.entry['serviceCategory'];
    _serviceDescriptionController.text = widget.entry['serviceDescription'];
    _servicePriceController.text = widget.entry['servicePrice'].toString();
    _userQualificationController.text = widget.entry['userQualification'];
    super.initState();
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    _serviceCategoryController.dispose();
    _serviceDescriptionController.dispose();
    _servicePriceController.dispose();
    _userQualificationController.dispose();
    super.dispose();
  }

  void updateListing() async {
    await FirebaseFirestore.instance.collection('listing').doc(widget.id).set({
      'serviceName': _serviceNameController.text,
      'serviceCategory': _serviceCategoryController.text,
      'serviceDescription': _serviceDescriptionController.text,
      'servicePrice': int.parse(_servicePriceController.text),
      'userQualification': _userQualificationController.text,
    }, SetOptions(merge: true));
  }

  void deleteListing() async {
    await FirebaseFirestore.instance
        .collection('listing')
        .doc(widget.id)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          CurvedEdgeWidget(
            child: Container(
              color: Color(0xFF4b68ff),
              child: Stack(
                children: [
                  SizedBox(
                      child: Padding(
                    padding: EdgeInsets.all(0),
                    child: Center(
                        child: Image(
                            image: AssetImage(ImageHelper.getImagePath(
                                widget.entry['serviceCategory'])))),
                  )),
                  CustomAppBar(
                    showBackArrow: true,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 24, left: 24, bottom: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                widget.entry['serviceName'],
                style: Theme.of(context).textTheme.titleLarge!,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16 / 2),
              Row(
                children: [
                  RoundedContainer(
                    backgrounColor: Color(0xFFE0E0E0),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        '\$' + widget.entry['servicePrice'].toString(),
                        style: Theme.of(context).textTheme.titleMedium!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16 / 2),
                  RoundedContainer(
                    padding: const EdgeInsets.all(8),
                    backgrounColor: Color(0xFF4b68ff),
                    child: Text(
                      widget.entry['serviceCategory'],
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .apply(color: Color(0xFFFFFFFF)),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16 / 2),
              Text(
                widget.entry['serviceDescription'],
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16 / 2),
              Text(
                widget.entry['userQualification'],
                style: Theme.of(context).textTheme.titleSmall!,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 16 / 2),
              //Description of Service
              RoundedContainer(
                  padding: const EdgeInsets.all(16),
                  backgrounColor: Color(0xFFE0E0E0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeading(
                        title: "Description",
                        showActionButton: false,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.entry['serviceDescription'],
                        style: Theme.of(context).textTheme.titleSmall!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              const SizedBox(height: 16 / 2),
              //Qualifications
              RoundedContainer(
                  padding: const EdgeInsets.all(16),
                  backgrounColor: Color(0xFFE0E0E0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionHeading(
                        title: "Qualification",
                        showActionButton: false,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        widget.entry['userQualification'],
                        style: Theme.of(context).textTheme.titleSmall,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )),
              const SizedBox(height: 16 / 2),
              //Edit Service
              RoundedContainer(
                padding: const EdgeInsets.all(16),
                backgrounColor: Color.fromARGB(255, 212, 165, 165),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SectionHeading(
                      title: "Edit Service",
                      showActionButton: false,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _serviceNameController,
                      decoration: InputDecoration(
                        labelText: 'Service Name',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _serviceCategoryController,
                      decoration: InputDecoration(
                        labelText: 'Service Category',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _serviceDescriptionController,
                      decoration: InputDecoration(
                        labelText: 'Service Description',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: _servicePriceController,
                      decoration: InputDecoration(
                        labelText: 'Service Price',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _userQualificationController,
                      decoration: InputDecoration(
                        labelText: 'User Qualification',
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Row of 3 buttons, delete, cancel, save
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Delete
                            deleteListing();
                            // snackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(deleteSnackBar);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                            );
                          },
                          child: const Text('Delete',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Cancel
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4B68FF),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Save
                            updateListing();
                            // snackBar
                            ScaffoldMessenger.of(context)
                                .showSnackBar(updateSnackBar);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BottomNavBar()),
                            );
                          },
                          child: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4B68FF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}



//



