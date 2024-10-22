import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';
import '../models/product_color.dart';
import '../models/product_size.dart';
import '../models/size.dart';

class DBHelper {
  static final DBHelper instance = DBHelper._init();
  static Database? _database;

  DBHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('shop_database12.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    // Create tables in correct order based on dependencies
    await db.execute('''
    CREATE TABLE Shop (
      Shop_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name NVARCHAR(255),
      Description NTEXT,
      PhoneNumber NVARCHAR(20),
      Address NVARCHAR(255),
      Email NVARCHAR(255)
    );
  ''');

    await db.execute('''
    CREATE TABLE Shop_Image (
      Shop_Image_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Url_Image TEXT,
      Shop_ID INTEGER,
      FOREIGN KEY (Shop_ID) REFERENCES Shop (Shop_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Brand (
      Brand_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name NVARCHAR(255),
      Shop_ID INTEGER,
      FOREIGN KEY (Shop_ID) REFERENCES Shop (Shop_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Product (
      Product_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name NVARCHAR(255),
      Description TEXT,
      Brand_ID INTEGER,
      FOREIGN KEY (Brand_ID) REFERENCES Brand (Brand_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Product_Image (
      Product_Image_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Url_Image TEXT,
      Product_ID INTEGER,
      FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Color (
      Color_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Name NVARCHAR(255)
    );
  ''');

    await db.execute('''
    CREATE TABLE Size (
      Size_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Size NVARCHAR(50)
    );
  ''');

    await db.execute('''
    CREATE TABLE Product_Color (
      Product_Color_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Color_ID INTEGER,
      Product_ID INTEGER,
      Url_Image TEXT,
      FOREIGN KEY (Color_ID) REFERENCES Color (Color_ID),
      FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Product_Size (
      Product_Size_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Price INTEGER,
      Amount INTEGER,
      Size_ID INTEGER,
      Product_Color_ID INTEGER,
      FOREIGN KEY (Size_ID) REFERENCES Size (Size_ID),
      FOREIGN KEY (Product_Color_ID) REFERENCES Product_Color (Product_Color_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Account (
      Account_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Email NVARCHAR(255),
      Password NVARCHAR(255),
      CMND NVARCHAR(20),
      Name NVARCHAR(255),
      Gender CHAR(1),
      DateOfBirth DATETIME,
      PhoneNumber NVARCHAR(20),
      AvatarURL NVARCHAR(255),
      Address NVARCHAR(255),
      Role INTEGER,
      Status INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE Voucher (
      Voucher_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      name NVARCHAR(255),
      token NVARCHAR(255),
      Discount_Money INTEGER,
      Amount INTEGER,
      StartDate DATETIME,
      EndDate DATETIME,
      Min_Price INTEGER
    );
  ''');

    await db.execute('''
    CREATE TABLE Notification (
      Notification_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Title NVARCHAR(255),
      Description TEXT,
      CreateAt DATETIME,
      Shop_ID INTEGER,
      FOREIGN KEY (Shop_ID) REFERENCES Shop (Shop_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Notification_Account (
      Notification_ID INTEGER,
      Account_ID INTEGER,
      Status INTEGER,
      PRIMARY KEY (Notification_ID, Account_ID),
      FOREIGN KEY (Notification_ID) REFERENCES Notification (Notification_ID),
      FOREIGN KEY (Account_ID) REFERENCES Account (Account_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Reservation (
      Reservation_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Reservation_date DATETIME,
      Total_Price INTEGER,
      Payment_Method NVARCHAR(50),
      Status NVARCHAR(50),
      Account_ID INTEGER,
      FOREIGN KEY (Account_ID) REFERENCES Account (Account_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Reserved_Product_Size (
      Reserved_Product_Size_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Reservation_ID INTEGER,
      Product_Size_ID INTEGER,
      FOREIGN KEY (Reservation_ID) REFERENCES Reservation (Reservation_ID),
      FOREIGN KEY (Product_Size_ID) REFERENCES Product_Size (Product_Size_ID)
    );
  ''');

    await db.execute('''
    CREATE TABLE Voucher_Account (
      Voucher_Account_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Status INTEGER,
      Account_ID INTEGER,
      Voucher_ID INTEGER,
      FOREIGN KEY (Account_ID) REFERENCES Account (Account_ID),
      FOREIGN KEY (Voucher_ID) REFERENCES Voucher (Voucher_ID)
    );
  ''');


    await db.execute('''
    CREATE TABLE Favorite (
      Favorite_ID INTEGER PRIMARY KEY AUTOINCREMENT,
      Product_ID INTEGER,
      Account_ID INTEGER,
      FOREIGN KEY (Product_ID) REFERENCES Product (Product_ID),
      FOREIGN KEY (Account_ID) REFERENCES Account (Account_ID)
    );
  ''');
    await _insertData(db);
  }



  Future<void> _insertData(Database db) async {
    // Chèn dữ liệu vào bảng Shop
    await db.insert('Shop', {
      'Name': 'H&N Shoes',
      'Description': 'H&N Shoes Fashion is the ideal destination for footwear enthusiasts, offering '
          ' wide range of styles from dynamic sneakers to elegant high heels.'
          'With a modern and comfortable store layout, it provides an inviting space'
          ' where customers can easily browse and try on shoes.',
      'PhoneNumber': '0934726073',
      'Address': '650 Tran Cao Van Street, Thanh Khe, Da Nang City.',
      'Email': 'HNShoes@gmail.com',
    });

    // Chèn dữ liệu vào bảng Shop_Image
    await db.insert('Shop_Image', {
      'Url_Image': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiLPcMp0kKtvIMio1uLkk24WNd_zWcTTppcw&s',
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });

    // Chèn dữ liệu vào bảng Brand
    await db.insert('Brand', {
      'Name': 'Nike',
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });

    await db.insert('Brand', {
      'Name': 'Puma',
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });

    await db.insert('Brand', {
      'Name': 'Adidas',
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });

    await db.insert('Brand', {
      'Name': 'Converse',
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });

    await db.insert('Brand', {
      'Name': 'Under',
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });




    // Chèn dữ liệu vào bảng Product
    await db.insert('Product', {
      'Name': 'Nike Air Force',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room.',
      'Brand_ID': 1, // Giả sử Brand_ID là 1
    });
    await db.insert('Product', {
      'Name': 'Nike Air Max',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room.',
      'Brand_ID': 1, // Giả sử Brand_ID là 1
    });
    await db.insert('Product', {
      'Name': 'Puma Air Force',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room.',
      'Brand_ID': 2, // Giả sử Brand_ID là 2
    });
    //NEW
    await db.insert('Product', {
      'Name': 'Nike Dunk Low',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room',
      'Brand_ID': 1, // Giả sử Brand_ID là 1
    });
    await db.insert('Product', {
      'Name': 'Adidas Mamba',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room',
      'Brand_ID': 3, // Giả sử Brand_ID là 1
    });
    await db.insert('Product', {
      'Name': 'Converse v2.0',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room',
      'Brand_ID': 4, // Giả sử Brand_ID là 2
    });
    await db.insert('Product', {
      'Name': 'Curry v1.8',
      'Description': 'There Are Many Beautiful And Attractive Plants To Your Room',
      'Brand_ID': 5, // Giả sử Brand_ID là 2
    });


    // Chèn dữ liệu vào bảng Color
    await db.insert('Color', {
      'Name': 'Black',
    });
    await db.insert('Color', {
      'Name': 'Red',
    });
    await db.insert('Color', {
      'Name': 'Blue',
    });

    // Chèn dữ liệu vào bảng Size
    await db.insert('Size', {
      'Size': '36',
    });

    await db.insert('Size', {
      'Size': '37',
    });

    await db.insert('Size', {
      'Size': '38',
    });

    await db.insert('Size', {
      'Size': '39',
    });

    await db.insert('Size', {
      'Size': '40',
    });

    await db.insert('Size', {
      'Size': '41',
    });

    await db.insert('Size', {
      'Size': '42',
    });

    await db.insert('Size', {
      'Size': '43',
    });


    // Chèn dữ liệu vào bảng Product_Color


    await db.insert('Product_Color', {
      'Color_ID': 1, // Giả sử Color_ID là 1
      'Product_ID': 1,
      'Url_Image': 'under/type2_orange.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 2, // Giả sử Color_ID là 2
      'Product_ID': 1,
      'Url_Image': 'under/type2_orange.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 2, // Giả sử Color_ID là 2
      'Product_ID': 2,
      'Url_Image': 'puma/voltaic_red.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 3, // Giả sử Color_ID là 3
      'Product_ID': 2,
      'Url_Image': 'puma/softride.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 1, // Giả sử Color_ID là 1
      'Product_ID': 3,
      'Url_Image': 'puma/mamba.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 3, // Giả sử Color_ID là 3
      'Product_ID': 3,
      'Url_Image': 'puma/voltaic.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 3, // Giả sử Color_ID là 3
      'Product_ID': 4,
      'Url_Image': 'under/type3_red.jpg',// Giả sử Product_ID là 1
    });

    await db.insert('Product_Color', {
      'Color_ID': 2, // Giả sử Color_ID là 2
      'Product_ID': 5, // Adidas Mamba
      'Url_Image': 'adidas/original_white.jpg', // Đường dẫn hình ảnh cho Adidas Mamba
    });

    await db.insert('Product_Color', {
      'Color_ID': 1, // Giả sử Color_ID là 1
      'Product_ID': 6, // Converse v2.0
      'Url_Image': 'under/type4_green.jpg', // Đường dẫn hình ảnh cho Converse v2.0
    });

    await db.insert('Product_Color', {
      'Color_ID': 2, // Giả sử Color_ID là 2
      'Product_ID': 7, // Curry v1.8
      'Url_Image': 'under/type4_grey.jpg', // Đường dẫn hình ảnh cho Curry v1.8
    });

    // Chèn dữ liệu vào bảng Product_Size
    await db.insert('Product_Size', {
      'Price': 300,
      'Amount': 50,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 10, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 159,
      'Amount': 50,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 7, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 180,
      'Amount': 50,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 8, // Giả sử Product_Color_ID là 1
    });
    await db.insert('Product_Size', {
      'Price': 200,
      'Amount': 50,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 9, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 100,
      'Amount': 0,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 200,
      'Amount': 20,
      'Size_ID': 2, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 100,
      'Amount': 15,
      'Size_ID': 3, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 200,
      'Amount': 0,
      'Size_ID': 4, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 200,
      'Amount': 10,
      'Size_ID': 5, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 100,
      'Amount': 15,
      'Size_ID': 6, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 100,
      'Amount': 15,
      'Size_ID': 7, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 200,
      'Amount': 0,
      'Size_ID': 8, // Giả sử Size_ID là 1
      'Product_Color_ID': 1, // Giả sử Product_Color_ID là 1
    });



    await db.insert('Product_Size', {
      'Price': 300,
      'Amount': 25,
      'Size_ID': 3, // Giả sử Size_ID là 1
      'Product_Color_ID': 2, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 400,
      'Amount': 30,
      'Size_ID': 4, // Giả sử Size_ID là 1
      'Product_Color_ID': 2, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 500,
      'Amount': 35,
      'Size_ID': 5, // Giả sử Size_ID là 1
      'Product_Color_ID': 3, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 600,
      'Amount': 40,
      'Size_ID': 6, // Giả sử Size_ID là 1
      'Product_Color_ID': 3, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 700,
      'Amount': 45,
      'Size_ID': 7, // Giả sử Size_ID là 1
      'Product_Color_ID': 4, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 800,
      'Amount': 50,
      'Size_ID': 8, // Giả sử Size_ID là 1
      'Product_Color_ID': 4, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 900,
      'Amount': 55,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 5, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 1000,
      'Amount': 60,
      'Size_ID': 4, // Giả sử Size_ID là 1
      'Product_Color_ID': 5, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 1100,
      'Amount': 65,
      'Size_ID': 1, // Giả sử Size_ID là 1
      'Product_Color_ID': 6, // Giả sử Product_Color_ID là 1
    });

    await db.insert('Product_Size', {
      'Price': 1200,
      'Amount': 70,
      'Size_ID': 5, // Giả sử Size_ID là 1
      'Product_Color_ID': 6, // Giả sử Product_Color_ID là 1
    });


    // Chèn dữ liệu vào bảng Account
    await db.insert('Account', {
      'Email': 'cus1@gm.com',
      'Password': '123',
      'CMND': '0935302822',
      'Name': 'Hoàng Nguyên',
      'Gender': 'M',
      'DateOfBirth': '2003-06-30',
      'PhoneNumber': '0935302822',
      'AvatarURL': 'https://inkythuatso.com/uploads/thumbnails/800/2023/03/9-anh-dai-dien-trang-inkythuatso-03-15-27-03.jpg',
      'Address': '70 Ha Huy Tap Street, Thanh Khe, Da Nang',
      'Role': 1,
      'Status': 1,
    });

    // Chèn dữ liệu vào bảng Voucher
    await db.insert('Voucher', {
      'name': 'Voucher 1',
      'token': 'TOKEN123',
      'Discount_Money': 20,
      'Amount': 100,
      'StartDate': '2024-01-01',
      'EndDate': '2024-12-31',
      'Min_Price': 100,
    });

    // Chèn dữ liệu vào bảng Notification
    await db.insert('Notification', {
      'Title': 'Thông báo mới',
      'Description': 'Chi tiết thông báo',
      'CreateAt': DateTime.now().toString(),
      'Shop_ID': 1, // Giả sử Shop_ID là 1
    });

    // Chèn dữ liệu vào bảng Reservation
    await db.insert('Reservation', {
      'Reservation_date': DateTime.now().toString(),
      'Total_Price': 200,
      'Payment_Method': 'Credit Card',
      'Status': 'Pending',
      'Account_ID': 1, // Giả sử Account_ID là 1
    });

    // Chèn dữ liệu vào bảng Reserved_Product_Size
    await db.insert('Reserved_Product_Size', {
      'Reservation_ID': 1, // Giả sử Reservation_ID là 1
      'Product_Size_ID': 1, // Giả sử Product_Size_ID là 1
    });

    // Chèn dữ liệu vào bảng Voucher_Account
    await db.insert('Voucher_Account', {
      'Status': 1,
      'Account_ID': 1, // Giả sử Account_ID là 1
      'Voucher_ID': 1, // Giả sử Voucher_ID là 1
    });


    // Chèn dữ liệu vào bảng Favorite
    await db.insert('Favorite', {
      'Product_ID': 1, // Giả sử Product_ID là 1
      'Account_ID': 1, // Giả sử Account_ID là 1
    });

    await db.insert('Favorite', {
      'Product_ID': 2, // Giả sử Product_ID là 1
      'Account_ID': 1, // Giả sử Account_ID là 1
    });
  }




  // CRUD methods for Shop table
  Future<int> createShop(Map<String, dynamic> shop) async {
    final db = await instance.database;
    return await db.insert('Shop', shop);
  }

  Future<List<Map<String, dynamic>>> getShops() async {
    final db = await instance.database;
    return await db.query('Shop');
  }

  Future<int> updateShop(Map<String, dynamic> shop) async {
    final db = await instance.database;
    final shopId = shop['Shop_ID'];
    return await db.update('Shop', shop, where: 'Shop_ID = ?', whereArgs: [shopId]);
  }

  Future<int> deleteShop(int id) async {
    final db = await instance.database;
    return await db.delete('Shop', where: 'Shop_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Shop_Image table
  Future<int> createShopImage(Map<String, dynamic> shopImage) async {
    final db = await instance.database;
    return await db.insert('Shop_Image', shopImage);
  }

  Future<List<Map<String, dynamic>>> getShopImages() async {
    final db = await instance.database;
    return await db.query('Shop_Image');
  }

  Future<int> updateShopImage(Map<String, dynamic> shopImage) async {
    final db = await instance.database;
    final shopImageId = shopImage['Shop_Image_ID'];
    return await db.update('Shop_Image',shopImage,where:'Shop_Image_ID = ?',whereArgs: [shopImageId]);
  }

  Future<int> deleteShopImage(int id) async {
    final db = await instance.database;
    return await db.delete('Shop_Image', where: 'Shop_Image_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Brand table
  Future<int> createBrand(Map<String, dynamic> brand) async {
    final db = await instance.database;
    return await db.insert('Brand', brand);
  }

  Future<List<Map<String, dynamic>>> getBrands() async {
    final db = await instance.database;
    return await db.query('Brand');
  }

  Future<int> updateBrand(Map<String, dynamic> brand) async {
    final db = await instance.database;
    final brandId = brand['Brand_ID'];
    return await db.update('Brand', brand, where: 'Brand_ID = ?', whereArgs: [brandId]);
  }

  Future<int> deleteBrand(int id) async {
    final db = await instance.database;
    return await db.delete('Brand', where: 'Brand_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Product table
  Future<int> createProduct(Map<String, dynamic> product) async {
    final db = await instance.database;
    return await db.insert('Product', product);
  }

  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await instance.database;
    return await db.query('Product');
  }

  Future<List<Map<String, dynamic>>> getProductDetails() async {
    final db = await database; // Đảm bảo bạn đã khởi tạo SQLite database
    return await db.rawQuery('''
    SELECT 
        Product.Product_ID,
        Product.Name AS Product_Name,
        Product.Description,
        Product_Color.Url_Image AS Product_Image,
        Color.Name AS Color_Name,
        Size.Size AS Size_Name,
        Product_Size.Price,
        Product_Size.Amount
    FROM 
        Product
    LEFT JOIN Product_Image ON Product.Product_ID = Product_Image.Product_ID
    LEFT JOIN Product_Color ON Product.Product_ID = Product_Color.Product_ID
    LEFT JOIN Color ON Product_Color.Color_ID = Color.Color_ID
    LEFT JOIN Product_Size ON Product_Color.Product_Color_ID = Product_Size.Product_Color_ID
    LEFT JOIN Size ON Product_Size.Size_ID = Size.Size_ID;
  ''');
  }



  Future<int> updateProduct(Map<String, dynamic> product) async {
    final db = await instance.database;
    final productId = product['Product_ID'];
    return await db.update('Product', product, where: 'Product_ID = ?', whereArgs: [productId]);
  }

  Future<int> deleteProduct(int id) async {
    final db = await instance.database;
    return await db.delete('Product', where: 'Product_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Color table
  Future<int> createColor(Map<String, dynamic> color) async {
    final db = await instance.database;
    return await db.insert('Color', color);
  }

  Future<List<Map<String, dynamic>>> getColors() async {
    final db = await instance.database;
    return await db.query('Color');
  }

  Future<int> updateColor(Map<String, dynamic> color) async {
    final db = await instance.database;
    final colorId = color['Color_ID'];
    return await db.update('Color', color, where: 'Color_ID = ?', whereArgs: [colorId]);
  }

  Future<int> deleteColor(int id) async {
    final db = await instance.database;
    return await db.delete('Color', where: 'Color_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Size table
  Future<int> createSize(Map<String, dynamic> size) async {
    final db = await instance.database;
    return await db.insert('Size', size);
  }

  Future<List<Map<String, dynamic>>> getSizes() async {
    final db = await instance.database;
    return await db.query('Size');
  }

  Future<int> updateSize(Map<String, dynamic> size) async {
    final db = await instance.database;
    final sizeId = size['Size_ID'];
    return await db.update('Size', size, where: 'Size_ID = ?', whereArgs: [sizeId]);
  }

  Future<int> deleteSize(int id) async {
    final db = await instance.database;
    return await db.delete('Size', where: 'Size_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Product_Color table
  Future<int> createProductColor(Map<String, dynamic> productColor) async {
    final db = await instance.database;
    return await db.insert('Product_Color', productColor);
  }

  Future<List<Map<String, dynamic>>> getProductColors() async {
    final db = await instance.database;
    return await db.query('Product_Color');
  }

  Future<int> updateProductColor(Map<String, dynamic> productColor) async {
    final db = await instance.database;
    final productColorId = productColor['Product_Color_ID'];
    return await db.update('Product_Color', productColor, where: 'Product_Color_ID = ?', whereArgs: [productColorId]);
  }

  Future<int> deleteProductColor(int id) async {
    final db = await instance.database;
    return await db.delete('Product_Color', where: 'Product_Color_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Product_Size table
  Future<int> createProductSize(Map<String, dynamic> productSize) async {
    final db = await instance.database;
    return await db.insert('Product_Size', productSize);
  }

  Future<List<Map<String, dynamic>>> getProductSizes() async {
    final db = await instance.database;
    return await db.query('Product_Size');
  }

  Future<int> updateProductSize(Map<String, dynamic> productSize) async {
    final db = await instance.database;
    final productSizeId = productSize['Product_Size_ID'];
    return await db.update('Product_Size', productSize, where: 'Product_Size_ID = ?', whereArgs: [productSizeId]);
  }

  Future<int> deleteProductSize(int id) async {
    final db = await instance.database;
    return await db.delete('Product_Size', where: 'Product_Size_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Account table
  static Future<int> createAccount(Map<String, dynamic> account) async {
    final db = await instance.database;
    return await db.insert('Account', account);
  }

  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await instance.database;
    return await db.query('Account');
  }

  Future<int> updateAccount(Map<String, dynamic> account) async {
    final db = await instance.database;
    final accountId = account['Account_ID'];
    return await db.update('Account', account, where: 'Account_ID = ?', whereArgs: [accountId]);
  }

  Future<int> deleteAccount(int id) async {
    final db = await instance.database;
    return await db.delete('Account', where: 'Account_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Voucher table
  Future<int> createVoucher(Map<String, dynamic> voucher) async {
    final db = await instance.database;
    return await db.insert('Voucher', voucher);
  }

  Future<List<Map<String, dynamic>>> getVouchers() async {
    final db = await instance.database;
    return await db.query('Voucher');
  }

  Future<int> updateVoucher(Map<String, dynamic> voucher) async {
    final db = await instance.database;
    final voucherId = voucher['Voucher_ID'];
    return await db.update('Voucher', voucher, where: 'Voucher_ID = ?', whereArgs: [voucherId]);
  }

  Future<int> deleteVoucher(int id) async {
    final db = await instance.database;
    return await db.delete('Voucher', where: 'Voucher_ID = ?', whereArgs: [id]);
  }

  // CRUD methods for Product Image table
  Future<int> createProductImage(Map<String, dynamic> productImage) async {
    final db = await instance.database;
    return await db.insert('Product_Image', productImage);
  }

  Future<List<Map<String, dynamic>>> getProductImages() async {
    final db = await instance.database;
    return await db.query('Product_Image');
  }

  Future<int> updateProductImage(Map<String, dynamic> productImage) async {
    final db = await instance.database;
    final productImageId = productImage['Product_Image_ID'];
    return await db.update('Product_Image', productImage,
        where: 'Product_Image_ID = ?', whereArgs: [productImageId]);
  }

  Future<int> deleteProductImage(int id) async {
    final db = await instance.database;
    return await db.delete('Product_Image',
        where: 'Product_Image_ID = ?', whereArgs: [id]);
  }


  Future<List<Map<String, dynamic>>> getAccountByMail(String email) async {
    final db = await instance.database;
    return await db.query('Account', where: 'Email = ?', whereArgs: [email]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }



  //get Product by id
  static Future<Product?> getProductById(int productId) async {
    final db = await instance.database;

    // Query for the product by ID
    final List<Map<String, dynamic>> result = await db.query(
      'Product',
      where: 'Product_ID = ?',
      whereArgs: [productId],
    );

    if (result.isNotEmpty) {
      return Product.fromMap(result.first); // Convert the map to a Product object
    }

    return null; // Return null if no product found
  }

  // Lấy danh sách ProductColor theo Product_ID
  static Future<List<ProductColor>> getProductColorsByProductId(int productId) async {
    final db = await instance.database;

    // Truy vấn bảng Product_Color theo Product_ID
    final List<Map<String, dynamic>> result = await db.query(
      'Product_Color',
      where: 'Product_ID = ?',
      whereArgs: [productId],
    );

    // Nếu kết quả không rỗng, chuyển đổi từng phần tử trong result thành đối tượng ProductColor
    if (result.isNotEmpty) {
      return result.map((map) => ProductColor.fromMap(map)).toList();
    }

    // Trả về danh sách rỗng nếu không tìm thấy dữ liệu
    return [];
  }

  // Lấy danh sách ProductSize theo Product_Color_ID
  static Future<List<ProductSize>> getProductSizesByColorId(int productColorId) async {
    final db = await instance.database;

    // Truy vấn bảng Product_Size theo Product_Color_ID
    final List<Map<String, dynamic>> result = await db.query(
      'Product_Size',
      where: 'Product_Color_ID = ?',
      whereArgs: [productColorId],
    );

    // Nếu kết quả không rỗng, chuyển đổi từng phần tử trong result thành đối tượng ProductSize
    if (result.isNotEmpty) {
      return result.map((map) => ProductSize.fromMap(map)).toList();
    }

    // Trả về danh sách rỗng nếu không tìm thấy dữ liệu
    return [];
  }

  static Future<Size?> getSizeById(int sizeId) async {
    final db = await instance.database;

    // Truy vấn bảng Size theo Size_ID
    final List<Map<String, dynamic>> result = await db.query(
      'Size',
      where: 'Size_ID = ?',
      whereArgs: [sizeId],
    );

    // Nếu tìm thấy kết quả, chuyển đổi Map thành đối tượng Size
    if (result.isNotEmpty) {
      return Size.fromMap(result.first);
    }

    // Nếu không có dữ liệu, trả về null
    return null;
  }

  static Future<List<String>> getSizesByProductColorId(int productColorId) async {
    final db = await instance.database;

    final List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT s.Size
    FROM Size s
    JOIN Product_Size ps ON s.Size_ID = ps.Size_ID
    WHERE ps.Product_Color_ID = ?
  ''', [productColorId]);

    List<String> sizes = results.map((row) => row['Size'] as String).toList();

    return sizes;
  }



}
