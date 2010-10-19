Return-Path: <matthias.bgg9ab33xy531gmail.com@bounce.antispameurope.com>
Message-ID: <4CBDD2F3.4070800@gmail.com>
Date: Tue, 19 Oct 2010 19:18:43 +0200
From: Matthias Brugger <matthias.bgg@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: linux-iio@vger.kernel.org, shubhrajyoti@ti.com,
        matthias <mensch0815@googlemail.com>
Subject: [PATCH] iio - bmp085 most issues done
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

This patch handles with most of the issues mentioned.

Hope I did it right, with patch submission like this.

Signed-off-by: Matthias Brugger <m_brugger@web.de>
---
 drivers/staging/iio/barometer/baro.h   |    2 +-
 drivers/staging/iio/barometer/bmp085.c |   56
++++++++++---------------------
 drivers/staging/iio/barometer/bmp085.h |   37 ++++++++++++++++++++-
 3 files changed, 55 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/iio/barometer/baro.h
b/drivers/staging/iio/barometer/baro.h
index e3b73a1..a25e4cd 100644
--- a/drivers/staging/iio/barometer/baro.h
+++ b/drivers/staging/iio/barometer/baro.h
@@ -4,5 +4,5 @@
 /* Barometer types of attribute */

 #define IIO_DEV_ATTR_BARO_PRESSURE(_mode, _show, _store, _addr)	\
-	IIO_DEVICE_ATTR(baro_pressure, _mode, _show, NULL, _addr)
+	IIO_DEVICE_ATTR(baro_pressure_input, _mode, _show, NULL, _addr)

diff --git a/drivers/staging/iio/barometer/bmp085.c
b/drivers/staging/iio/barometer/bmp085.c
index 67dac39..580bd57 100644
--- a/drivers/staging/iio/barometer/bmp085.c
+++ b/drivers/staging/iio/barometer/bmp085.c
@@ -37,7 +37,7 @@ module_param(oss, int , S_IRUSR);
 MODULE_PARM_DESC(oss, "Oversampling setting [0-3]");

 /***********************************************************************=
***
- * Calcualtion of temperature and pressure
+ * Calculation of temperature and pressure

*************************************************************************=
*/
 static short bmp085_calc_temperature(struct i2c_client *client,
 	       unsigned long ut)
@@ -90,17 +90,6 @@ static long bmp085_calc_pressure(struct
i2c_client *client, unsigned long up)
  * Digital interface to sensor

*************************************************************************=
*/

-static ssize_t bmp085_read(struct i2c_client *client, u8 reg,
size_t count,
-	       unsigned char *buffer)
-{
-	int rc;
-	rc =3D i2c_smbus_read_i2c_block_data(client, reg, count, buffer);
-	if (rc < 0)
-			return -EIO;
-
-	return count;
-}
-
 static short bmp085_read_temp(struct i2c_client *client)
 {
 	s32 ret;
@@ -117,8 +106,9 @@ static short bmp085_read_temp(struct i2c_client
*client)
 		return ret;
 	}

-	mdelay(5);
-	ret =3D bmp085_read(client, BMP085_REG_CONV, 2, data->data);
+	msleep(5);
+	ret =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_CONV, 2,
+			data->data);
 	if (ret < 0) {
 		dev_warn(&client->dev, "reading ut failed, value is %#x\n"
 				, ret);
@@ -139,7 +129,6 @@ static long bmp085_read_pressure(struct
i2c_client *client)
 	u8 xlsb, ret1, ret2;
 	long pressure;
 	u8 reg;
-	/* TODO should be 4.5, 7.5, 13.5, 25.5 ms */
 	int time_delay[4] =3D {5, 8, 14, 26};
 	struct bmp085_data *data =3D i2c_get_clientdata(client);

@@ -163,7 +152,7 @@ static long bmp085_read_pressure(struct
i2c_client *client)
 	if (ret < 0)
 		return ret;

-	mdelay(time_delay[data->oss]);
+	msleep(time_delay[data->oss]);

 	mutex_lock(&data->bmp085_lock);
 	ret1 =3D i2c_smbus_read_byte_data(client, 0xf6);
@@ -176,7 +165,6 @@ static long bmp085_read_pressure(struct
i2c_client *client)
 	data->up =3D up;

 	pressure =3D bmp085_calc_pressure(client, up);
-	data->pressure =3D pressure;

 	return pressure;
 }
@@ -199,13 +187,13 @@ static ssize_t barometer_show_temp(struct
device *dev,

 	data->temp =3D status;

-	return sprintf(buf, "%ld\n", data->temp);
+	return sprintf(buf, "%d\n", data->temp);
 }
 static IIO_DEV_ATTR_TEMP_RAW(barometer_show_temp);

 /**
- * In standard mode, the temperature has to be reat every second
before the
- * pressure can be reat. We leave this semantics to the userspace,
if later
+ * In standard mode, the temperature has to be read every second
before the
+ * pressure can be read. We leave this semantics to the userspace,
if later
  * on a trigger based reading will be implemented, this should be
taken into
  * account.
  */
@@ -213,7 +201,7 @@ static ssize_t barometer_show_pressure(struct
device *dev,
 		struct device_attribute *da, char *buf)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct bmp085_data *data =3D indio_dev->dev_data;
+	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);
 	struct i2c_client *client =3D data->client;
 	long status;

@@ -231,7 +219,7 @@ static ssize_t barometer_show_id_version(struct
device *dev,
 		struct device_attribute *da, char *buf)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct bmp085_data *data =3D indio_dev->dev_data;
+	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);

 	return sprintf(buf, "%x_%x\n", data->chip_id, data->chip_version);
 }
@@ -241,7 +229,7 @@ static ssize_t barometer_show_oss(struct device
*dev,
 		struct device_attribute *da, char *buf)
 {
 	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
-	struct bmp085_data *data =3D indio_dev->dev_data;
+	struct bmp085_data *data =3D iio_dev_get_devdata(indio_dev);

 	return sprintf(buf, "%d\n", data->oss);
 }
@@ -251,7 +239,7 @@ static IIO_CONST_ATTR_TEMP_SCALE("0.1");

 static struct attribute *bmp085_attributes[] =3D {
 	&iio_dev_attr_temp_raw.dev_attr.attr,
-	&iio_dev_attr_baro_pressure.dev_attr.attr,
+	&iio_dev_attr_baro_pressure_input.dev_attr.attr,
 	&iio_dev_attr_revision.dev_attr.attr,
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_temp_scale.dev_attr.attr,
@@ -271,15 +259,17 @@ static int bmp085_init_client(struct
i2c_client *client)
 	struct bmp085_data *data =3D i2c_get_clientdata(client);
 	int i;

-	i =3D bmp085_read(client, BMP085_REG_CHIP_ID, 1, &data->chip_id);
+	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_CHIP_ID, 1,
+			&data->chip_id);
 	if (i < 0)
 		dev_warn(&client->dev, "Chip ID not read\n");

-	i =3D bmp085_read(client, BMP085_REG_VERSION, 1, &data->chip_version);
+	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_VERSION, 1,
+			&data->chip_version);
 	if (i < 0)
 		dev_warn(&client->dev, "Version not read\n");

-	i =3D bmp085_read(client, BMP085_REG_PROM, BMP085_PROM_LENGTH,
+	i =3D i2c_smbus_read_i2c_block_data(client, BMP085_REG_PROM,
BMP085_PROM_LENGTH,
 			data->data);
 	if (i < 0)
 		dev_warn(&client->dev, "Unable to read %d bytes from address "
@@ -300,13 +290,11 @@ static int bmp085_init_client(struct
i2c_client *client)
 	return 0;
 }

-static struct i2c_driver bmp085_drv;
 static int bmp085_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
 	struct i2c_adapter *adapter =3D to_i2c_adapter(client->dev.parent);
 	struct bmp085_data *data;
-	struct bmp085_data *data2;
 	int status =3D 0;

 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
@@ -326,12 +314,11 @@ static int bmp085_probe(struct i2c_client *client,

 	data->client =3D client;
 	i2c_set_clientdata(client, data);
-	data2 =3D i2c_get_clientdata(client);

 	/* Initialize the BMP085 chip */
 	bmp085_init_client(client);

-	__mutex_init(&data->bmp085_lock, "bmp085_lock", NULL);
+	mutex_init(&data->bmp085_lock);

 	/* Register with IIO */
 	data->indio_dev =3D iio_allocate_device();
@@ -350,8 +337,6 @@ static int bmp085_probe(struct i2c_client *client,
 	if (status < 0)
 		goto err_iio;

-	dev_info(&client->dev, "driver enabled\n");
-
 	return 0;

 err_iio:
@@ -365,16 +350,11 @@ static int __devexit bmp085_remove(struct
i2c_client *client)
 {
 	struct bmp085_data *data =3D i2c_get_clientdata(client);

-	if (mutex_is_locked(&data->bmp085_lock))
-		mutex_unlock(&data->bmp085_lock);
-
 	iio_device_unregister(data->indio_dev);
 	iio_free_device(data->indio_dev);

 	kfree(data);

-	dev_info(&client->dev, "driver removed\n");
-
 	return 0;
 }

diff --git a/drivers/staging/iio/barometer/bmp085.h
b/drivers/staging/iio/barometer/bmp085.h
index 5ed2fb1..aec2ee4 100644
--- a/drivers/staging/iio/barometer/bmp085.h
+++ b/drivers/staging/iio/barometer/bmp085.h
@@ -35,6 +35,41 @@
 #define BMP085_REG_VERSION	0xD1
 #define BMP085_CHIP_ID		0x55

+/*
+ * data structure for every sensor
+ *
+ * @client		i2c client
+ * @ indio_dev		iio device representation
+ *
+ * @bmp085_lock		mutex to synchronize parallel reads and writes
+ *
+ * @oss			oversampling setting, determines how accurate the chip works
+ * @temp		holding actual temperature in 0.1=B0C
+ * @pressure		holding actual pressure in pascal
+ *
+ * @ac1			calibration value read at start-up
+ * @ac2			calibration value read at start-up
+ * @ac3			calibration value read at start-up
+ * @ac4			calibration value read at start-up
+ * @ac5			calibration value read at start-up
+ * @ac6			calibration value read at start-up
+ *
+ * @b1			calibration value read at start-up
+ * @b2			calibration value read at start-up
+ * @b3			calibration value read at start-up
+ *
+ * @mb			calibration value read at start-up
+ * @mc			calibration value read at start-up
+ * @md			calibration value read at start-up
+ *
+ * @ut			raw data to compute temperature
+ * @up			raw data to compute pressure
+ *
+ * @chip_id		id of the chip
+ * @chip_version	version of the chip
+ *
+ * @data		array to read initial calib data as a bulk
+ */
 struct bmp085_data {
 	struct i2c_client *client;
 	struct iio_dev *indio_dev;
@@ -42,7 +77,7 @@ struct bmp085_data {
 	struct mutex bmp085_lock;

 	int oss;
-	long temp;
+	s16 temp;
 	long pressure;

 	short ac1;
--=20
1.5.6.5
