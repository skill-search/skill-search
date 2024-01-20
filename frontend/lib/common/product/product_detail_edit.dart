import 'package:flutter/material.dart';
import 'package:frontend/common/appbar/appbar.dart';
import 'package:frontend/common/custom-shapes/curved_edge_widget.dart';
import 'package:frontend/common/custom-shapes/rounded_container.dart';
import 'package:frontend/common/texts/section_heading.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          CurvedEdgeWidget(
            child: Container(
              color: Color(0xFF4b68ff),
              child: const Stack(
                children: [
                  SizedBox(
                      height: 400,
                      child: Padding(
                        padding: EdgeInsets.all(16 * 2),
                        child: Center(
                            child: Image(
                                image: NetworkImage(
                                    'https://www.daylightelectrician.com/wp-content/uploads/2016/06/3.jpg'))),
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
                    backgrounColor: Color(0xFF4b68ff),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        widget.entry['serviceCategory'],
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16 / 2),
                  RoundedContainer(
                    backgrounColor: Color(0xFFE0E0E0),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        "\$${widget.entry['servicePrice']}",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
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
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
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
                        style: Theme.of(context).textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
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
                        style: Theme.of(context).textTheme.bodyText1,
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
                  backgrounColor: Color(0xFFE0E0E0),
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
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text('Save Changes'),
                      ),
                    ],
                  )),
            ]),
          ),
        ]),
      ),
    );
  }
}
