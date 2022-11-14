import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:checkout/screens/payment_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/payment.dart';
import '../constants.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _countryController = TextEditingController();
  final _noController = TextEditingController();
  bool _isloading = false;

  final _formkey = GlobalKey<FormState>();

  void _submitData() async {
    final isValid = _formkey.currentState!.validate();

    if (isValid) {
      setState(() {
        _isloading = true;
      });
      var cardid = Provider.of<Payment>(context, listen: false)
          .tempCard['id']
          .toString();
      if (cardid.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Added Payment Method First'),
            backgroundColor: Theme.of(context).errorColor,
          ),
        );
      } else {
        Customer temp = Customer(
          id: "",
          name: _nameController.text,
          city: _cityController.text,
          coutry: _countryController.text,
          phone: _noController.text,
        );
        var payment = Provider.of<Payment>(context, listen: false);
        try {
          await payment.addCustomer(temp);
          payment.addSubscription(prodkey: productkey).then((value) async {
            if (Provider.of<Payment>(context, listen: false).tempSubs != null) {
              payment.uploaddata().then((value) {
                setState(() {
                  _isloading = false;
                });
                print(123);
                AwesomeDialog(
                  width: MediaQuery.of(context).size.width * 0.3,
                  padding: EdgeInsets.zero,
                  context: context,
                  showCloseIcon: false,
                  dialogType: DialogType.success,
                  headerAnimationLoop: false,
                  transitionAnimationDuration:
                      const Duration(milliseconds: 400),
                  title: 'Success',
                  desc: 'Your subscription has been purchased',
                  btnOkOnPress: () {
                    _nameController.clear();
                    _cityController.clear();
                    _countryController.clear();
                    _noController.clear();
                  },
                ).show();
              });
            }
          });
        } catch (error) {
          await showDialog<void>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('An Error Occur'),
              content: const Text('Something Went wrong!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("okay"),
                ),
              ],
            ),
          );
        }
      }
    }
  }

  bool isLoading = false;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    }); // TODO: implement initState
    Provider.of<Payment>(context, listen: false)
        .fetchProduct(productId: productkey)
        .then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final card = Provider.of<Payment>(context, listen: true).tempCard;
    final Height = MediaQuery.of(context).size.height / 100;
    var product = Provider.of<Payment>(context, listen: true).product;
    return Scaffold(
      body: product == null
          ? Center(
              child: CircularProgressIndicator(color: primaryColor),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {},
                            child: Text(
                              'Back',
                              style: HeadStyle.copyWith(fontSize: 12),
                            )),
                        SizedBox(
                          height: Height * 1,
                        ),
                        Center(
                            child: Text(
                          'Checkout',
                          style: HeadStyle,
                        )),
                        SizedBox(
                          height: Height * 3,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          'Product Info',
                                          style:
                                              HeadStyle.copyWith(fontSize: 16),
                                        ),
                                      ),
                                      SizedBox(
                                        height: Height * 1,
                                      ),
                                      ProductDetail(
                                        value: product.name,
                                        title: 'Product Name:',
                                      ),
                                      ProductDetail(
                                        value: product.desc,
                                        title: 'Product Description:',
                                      ),
                                      ProductDetail(
                                        value: '\$100',
                                        title: 'Product Price:',
                                      ),
                                    ],
                                  ),
                                  // if (product.images!.isNotEmpty)
                                  //   Container(
                                  //     child:
                                  //         Image.network(product.images!.first),
                                  //   ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 30, horizontal: 20),
                              child: Column(
                                children: [
                                  Center(
                                    child: Text(
                                      'Personal Info',
                                      style: HeadStyle.copyWith(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  TextFormField(
                                    controller: _nameController,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return '*required';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.5, horizontal: 10.0),
                                      labelText: "Name",
                                    ),
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  TextFormField(
                                    controller: _noController,
                                    maxLength: 11,
                                    keyboardType: TextInputType.phone,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return '*required';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 12.5, horizontal: 10.0),
                                      labelText: 'Phone Number',
                                    ),
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  TextFormField(
                                    controller: _cityController,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return '*required';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.5, horizontal: 10.0),
                                        labelText: 'City'),
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  TextFormField(
                                    controller: _countryController,
                                    validator: (value) {
                                      if (value.toString().isEmpty) {
                                        return '*required';
                                      }
                                      return null;
                                    },
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.5, horizontal: 10.0),
                                        labelText: 'Country'),
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Payment Info',
                                        style: HeadStyle.copyWith(fontSize: 16),
                                      ),
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(
                                                PaymentInfoScreen.routeName);
                                          },
                                          child:
                                              const Text('Add Payment Method'))
                                    ],
                                  ),
                                  SizedBox(
                                    height: Height * 1,
                                  ),
                                  if (card['id'].toString().isNotEmpty)
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.all(10),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 10),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            217, 217, 217, 0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  'CardHolder Name : ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(card['name'])
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Card Number : ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                    '************${card['last4']}')
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Card Brand : ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(card['brand'])
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  'Epiry Date : ',
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                    '${card['exmonth']}/${card['exyear']}')
                                              ],
                                            ),
                                          ]),
                                    )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: Height * 3,
                        ),
                        InkWell(
                          onTap: _isloading ? null : _submitData,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            alignment: Alignment.center,
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: primaryColor,
                            ),
                            child: _isloading
                                ? const Center(
                                    child: SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator()),
                                  )
                                : Text(
                                    'Confirm',
                                    style: HeadStyle.copyWith(
                                        fontSize: 16, color: Colors.white),
                                  ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  ProductDetail({Key? key, required this.value, required this.title})
      : super(key: key);

  final String value;
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: HeadStyle.copyWith(fontSize: 14),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(value),
        ],
      ),
    );
  }
}
