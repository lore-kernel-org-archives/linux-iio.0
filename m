Return-Path: <SRS0=AYw5=AS=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Sun, 17 Sep 2017 17:01:05 +0200
Message-Id: <d6bf7a25a40366e3d816621765a9a05072ca4103.1505660069.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 8/8] iio: accel: kxcjk1013: drop variation number from
 driver's name
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Rename kxcjk-1013 driver by removing -1013 suffix. '1013' is a variation
specifier only (eg. different voltage) as can be seen in datasheet
for eg. KXTF9 parts.

Old name is left as an modules's alias. Should not matter, though,
for distros using proper module loading based on device name not
module name.

Mostly a mechanical change + whitespace fixes.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/Kconfig                   |   9 +-
 drivers/iio/accel/Makefile                  |   2 +-
 drivers/iio/accel/{kxcjk-1013.c => kxcjk.c} | 634 ++++++++++++++--------------
 3 files changed, 322 insertions(+), 323 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 0be352a7b6f4..627f35af4d12 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -212,18 +212,17 @@ config KXSD9_I2C
 	  Say yes here to enable the Kionix KXSD9 accelerometer
 	  I2C transport channel.
 
-config KXCJK1013
+config KXCJK
 	tristate "Kionix 3-Axis Accelerometer Driver"
 	depends on I2C
 	select IIO_BUFFER
 	select IIO_TRIGGERED_BUFFER
 	help
-	  Say Y here if you want to build a driver for the Kionix KXCJK-1013
-	  triaxial acceleration sensor. This driver also supports KXCJ9-1008,
-	  KXTJ2-1009 and KXTF9.
+	  Say Y here if you want to build a driver for the Kionix triaxial
+	  acceleration sensors: KXCJK-1013, KXCJ9-1008, KXTJ2-1009 and KXTF9.
 
 	  To compile this driver as a module, choose M here: the module will
-	  be called kxcjk-1013.
+	  be called kxcjk.
 
 config MC3230
 	tristate "mCube MC3230 Digital Accelerometer Driver"
diff --git a/drivers/iio/accel/Makefile b/drivers/iio/accel/Makefile
index 31fba1974e95..bf99eebd774b 100644
--- a/drivers/iio/accel/Makefile
+++ b/drivers/iio/accel/Makefile
@@ -17,7 +17,7 @@ obj-$(CONFIG_DMARD06)	+= dmard06.o
 obj-$(CONFIG_DMARD09)	+= dmard09.o
 obj-$(CONFIG_DMARD10)	+= dmard10.o
 obj-$(CONFIG_HID_SENSOR_ACCEL_3D) += hid-sensor-accel-3d.o
-obj-$(CONFIG_KXCJK1013) += kxcjk-1013.o
+obj-$(CONFIG_KXCJK)	+= kxcjk.o
 obj-$(CONFIG_KXSD9)	+= kxsd9.o
 obj-$(CONFIG_KXSD9_SPI)	+= kxsd9-spi.o
 obj-$(CONFIG_KXSD9_I2C)	+= kxsd9-i2c.o
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk.c
similarity index 60%
rename from drivers/iio/accel/kxcjk-1013.c
rename to drivers/iio/accel/kxcjk.c
index 7c010892945c..4c830fe76255 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk.c
@@ -30,8 +30,8 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
-#define KXCJK1013_DRV_NAME "kxcjk1013"
-#define KXCJK1013_IRQ_NAME "kxcjk1013_event"
+#define KXCJK_DRV_NAME "kxcjk"
+#define KXCJK_IRQ_NAME "kxcjk-event"
 
 #define KXTF9_REG_HP_XOUT_L		0x00
 #define KXTF9_REG_HP_XOUT_H		0x01
@@ -40,36 +40,36 @@
 #define KXTF9_REG_HP_ZOUT_L		0x04
 #define KXTF9_REG_HP_ZOUT_H		0x05
 
-#define KXCJK1013_REG_XOUT_L		0x06
+#define KXCJK_REG_XOUT_L		0x06
 /*
  * From low byte X axis register, all the other addresses of Y and Z can be
  * obtained by just applying axis offset. The following axis defines are just
  * provide clarity, but not used.
  */
-#define KXCJK1013_REG_XOUT_H		0x07
-#define KXCJK1013_REG_YOUT_L		0x08
-#define KXCJK1013_REG_YOUT_H		0x09
-#define KXCJK1013_REG_ZOUT_L		0x0A
-#define KXCJK1013_REG_ZOUT_H		0x0B
+#define KXCJK_REG_XOUT_H		0x07
+#define KXCJK_REG_YOUT_L		0x08
+#define KXCJK_REG_YOUT_H		0x09
+#define KXCJK_REG_ZOUT_L		0x0A
+#define KXCJK_REG_ZOUT_H		0x0B
 
-#define KXCJK1013_REG_DCST_RESP		0x0C
-#define KXCJK1013_REG_WHO_AM_I		0x0F
+#define KXCJK_REG_DCST_RESP		0x0C
+#define KXCJK_REG_WHO_AM_I		0x0F
 #define KXTF9_REG_TILT_POS_CUR		0x10
 #define KXTF9_REG_TILT_POS_PREV		0x11
 #define KXTF9_REG_INT_SRC1		0x15
-#define KXCJK1013_REG_INT_SRC1		0x16	/* compatible, but called INT_SRC2 in KXTF9 ds */
-#define KXCJK1013_REG_INT_SRC2		0x17
-#define KXCJK1013_REG_STATUS_REG	0x18
-#define KXCJK1013_REG_INT_REL		0x1A
-#define KXCJK1013_REG_CTRL1		0x1B
+#define KXCJK_REG_INT_SRC1		0x16	/* compatible, but called INT_SRC2 in KXTF9 ds */
+#define KXCJK_REG_INT_SRC2		0x17
+#define KXCJK_REG_STATUS_REG		0x18
+#define KXCJK_REG_INT_REL		0x1A
+#define KXCJK_REG_CTRL1			0x1B
 #define KXTF9_REG_CTRL2			0x1C
-#define KXCJK1013_REG_CTRL2		0x1D	/* mostly compatible, CTRL_REG3 in KTXF9 ds */
-#define KXCJK1013_REG_INT_CTRL1		0x1E
-#define KXCJK1013_REG_INT_CTRL2		0x1F
+#define KXCJK_REG_CTRL2			0x1D	/* mostly compatible, CTRL_REG3 in KTXF9 ds */
+#define KXCJK_REG_INT_CTRL1		0x1E
+#define KXCJK_REG_INT_CTRL2		0x1F
 #define KXTF9_REG_INT_CTRL3		0x20
-#define KXCJK1013_REG_DATA_CTRL		0x21
+#define KXCJK_REG_DATA_CTRL		0x21
 #define KXTF9_REG_TILT_TIMER		0x28
-#define KXCJK1013_REG_WAKE_TIMER	0x29
+#define KXCJK_REG_WAKE_TIMER		0x29
 #define KXTF9_REG_TDT_TIMER		0x2B
 #define KXTF9_REG_TDT_THRESH_H		0x2C
 #define KXTF9_REG_TDT_THRESH_L		0x2D
@@ -77,23 +77,23 @@
 #define KXTF9_REG_TDT_TOTAL_TIMER	0x2F
 #define KXTF9_REG_TDT_LATENCY_TIMER	0x30
 #define KXTF9_REG_TDT_WINDOW_TIMER	0x31
-#define KXCJK1013_REG_SELF_TEST		0x3A
+#define KXCJK_REG_SELF_TEST		0x3A
 #define KXTF9_REG_WAKE_THRESH		0x5A
 #define KXTF9_REG_TILT_ANGLE		0x5C
 #define KXTF9_REG_HYST_SET		0x5F
-#define KXCJK1013_REG_WAKE_THRES	0x6A
+#define KXCJK_REG_WAKE_THRES		0x6A
 
-#define KXCJK1013_REG_CTRL1_BIT_PC1	BIT(7)
-#define KXCJK1013_REG_CTRL1_BIT_RES	BIT(6)
-#define KXCJK1013_REG_CTRL1_BIT_DRDY	BIT(5)
-#define KXCJK1013_REG_CTRL1_BIT_GSEL1	BIT(4)
-#define KXCJK1013_REG_CTRL1_BIT_GSEL0	BIT(3)
-#define KXCJK1013_REG_CTRL1_BIT_WUFE	BIT(1)
+#define KXCJK_REG_CTRL1_BIT_PC1		BIT(7)
+#define KXCJK_REG_CTRL1_BIT_RES		BIT(6)
+#define KXCJK_REG_CTRL1_BIT_DRDY	BIT(5)
+#define KXCJK_REG_CTRL1_BIT_GSEL1	BIT(4)
+#define KXCJK_REG_CTRL1_BIT_GSEL0	BIT(3)
+#define KXCJK_REG_CTRL1_BIT_WUFE	BIT(1)
 
-#define KXCJK1013_REG_INT_CTRL1_BIT_IEU	BIT(2)	/* KXTF9 */
-#define KXCJK1013_REG_INT_CTRL1_BIT_IEL	BIT(3)
-#define KXCJK1013_REG_INT_CTRL1_BIT_IEA	BIT(4)
-#define KXCJK1013_REG_INT_CTRL1_BIT_IEN	BIT(5)
+#define KXCJK_REG_INT_CTRL1_BIT_IEU	BIT(2)	/* KXTF9 */
+#define KXCJK_REG_INT_CTRL1_BIT_IEL	BIT(3)
+#define KXCJK_REG_INT_CTRL1_BIT_IEA	BIT(4)
+#define KXCJK_REG_INT_CTRL1_BIT_IEN	BIT(5)
 
 #define KXTF9_REG_TILT_BIT_LEFT_EDGE	BIT(5)
 #define KXTF9_REG_TILT_BIT_RIGHT_EDGE	BIT(4)
@@ -102,28 +102,28 @@
 #define KXTF9_REG_TILT_BIT_FACE_DOWN	BIT(1)
 #define KXTF9_REG_TILT_BIT_FACE_UP	BIT(0)
 
-#define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
-#define KXCJK1013_MAX_STARTUP_TIME_US	100000
+#define KXCJK_DATA_MASK_12_BIT		0x0FFF
+#define KXCJK_MAX_STARTUP_TIME_US	100000
 
-#define KXCJK1013_SLEEP_DELAY_MS	2000
+#define KXCJK_SLEEP_DELAY_MS		2000
 
-#define KXCJK1013_REG_INT_SRC1_BIT_TPS	BIT(0)	/* KXTF9 */
-#define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(1)
-#define KXCJK1013_REG_INT_SRC1_MASK_TDTS	(BIT(2) | BIT(3))	/* KXTF9 */
-#define KXCJK1013_REG_INT_SRC1_TAP_NONE		0
-#define KXCJK1013_REG_INT_SRC1_TAP_SINGLE		BIT(2)
-#define KXCJK1013_REG_INT_SRC1_TAP_DOUBLE		BIT(3)
-#define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
+#define KXCJK_REG_INT_SRC1_BIT_TPS	BIT(0)	/* KXTF9 */
+#define KXCJK_REG_INT_SRC1_BIT_WUFS	BIT(1)
+#define KXCJK_REG_INT_SRC1_MASK_TDTS	(BIT(2) | BIT(3))	/* KXTF9 */
+#define KXCJK_REG_INT_SRC1_TAP_NONE		0
+#define KXCJK_REG_INT_SRC1_TAP_SINGLE		BIT(2)
+#define KXCJK_REG_INT_SRC1_TAP_DOUBLE		BIT(3)
+#define KXCJK_REG_INT_SRC1_BIT_DRDY	BIT(4)
 
 /* KXCJK: INT_SOURCE2: motion detect, KXTF9: INT_SRC_REG1: tap detect */
-#define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
-#define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
-#define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
-#define KXCJK1013_REG_INT_SRC2_BIT_YN	BIT(3)
-#define KXCJK1013_REG_INT_SRC2_BIT_XP	BIT(4)
-#define KXCJK1013_REG_INT_SRC2_BIT_XN	BIT(5)
+#define KXCJK_REG_INT_SRC2_BIT_ZP	BIT(0)
+#define KXCJK_REG_INT_SRC2_BIT_ZN	BIT(1)
+#define KXCJK_REG_INT_SRC2_BIT_YP	BIT(2)
+#define KXCJK_REG_INT_SRC2_BIT_YN	BIT(3)
+#define KXCJK_REG_INT_SRC2_BIT_XP	BIT(4)
+#define KXCJK_REG_INT_SRC2_BIT_XN	BIT(5)
 
-#define KXCJK1013_DEFAULT_WAKE_THRES	1
+#define KXCJK_DEFAULT_WAKE_THRES	1
 
 enum kx_chipset {
 	KXCJK1013,
@@ -133,7 +133,7 @@ enum kx_chipset {
 	KX_MAX_CHIPS /* this must be last */
 };
 
-struct kxcjk1013_data {
+struct kxcjk_data {
 	struct i2c_client *client;
 	struct iio_trigger *dready_trig;
 	struct iio_trigger *motion_trig;
@@ -151,22 +151,22 @@ struct kxcjk1013_data {
 	bool is_smo8500_device;
 };
 
-enum kxcjk1013_axis {
+enum kxcjk_axis {
 	AXIS_X,
 	AXIS_Y,
 	AXIS_Z,
 	AXIS_MAX,
 };
 
-enum kxcjk1013_mode {
+enum kxcjk_mode {
 	STANDBY,
 	OPERATION,
 };
 
-enum kxcjk1013_range {
-	KXCJK1013_RANGE_2G,
-	KXCJK1013_RANGE_4G,
-	KXCJK1013_RANGE_8G,
+enum kxcjk_range {
+	KXCJK_RANGE_2G,
+	KXCJK_RANGE_4G,
+	KXCJK_RANGE_8G,
 };
 
 struct kx_odr_map {
@@ -191,7 +191,7 @@ static const struct kx_odr_map samp_freq_table[] = {
 	{ 1600, 0, 0x07, 0x06 },
 };
 
-static const char *const kxcjk1013_samp_freq_avail =
+static const char *const kxcjk_samp_freq_avail =
 	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600";
 
 static const struct kx_odr_map kxtf9_samp_freq_table[] = {
@@ -271,28 +271,28 @@ static const struct {
 	u16 scale;
 	u8 gsel_0;
 	u8 gsel_1;
-} KXCJK1013_scale_table[] = { {9582, 0, 0},
-			      {19163, 1, 0},
-			      {38326, 0, 1} };
+} kxcjk_scale_table[] = { {9582, 0, 0},
+			  {19163, 1, 0},
+			  {38326, 0, 1} };
 
-static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
-			      enum kxcjk1013_mode mode)
+static int kxcjk_set_mode(struct kxcjk_data *data,
+			      enum kxcjk_mode mode)
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
 	}
 
 	if (mode == STANDBY)
-		ret &= ~KXCJK1013_REG_CTRL1_BIT_PC1;
+		ret &= ~KXCJK_REG_CTRL1_BIT_PC1;
 	else
-		ret |= KXCJK1013_REG_CTRL1_BIT_PC1;
+		ret |= KXCJK_REG_CTRL1_BIT_PC1;
 
 	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1, ret);
+					KXCJK_REG_CTRL1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
@@ -301,18 +301,18 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
 	return 0;
 }
 
-static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
-			      enum kxcjk1013_mode *mode)
+static int kxcjk_get_mode(struct kxcjk_data *data,
+			      enum kxcjk_mode *mode)
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
 	}
 
-	if (ret & KXCJK1013_REG_CTRL1_BIT_PC1)
+	if (ret & KXCJK_REG_CTRL1_BIT_PC1)
 		*mode = OPERATION;
 	else
 		*mode = STANDBY;
@@ -320,23 +320,23 @@ static int kxcjk1013_get_mode(struct kxcjk1013_data *data,
 	return 0;
 }
 
-static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
+static int kxcjk_set_range(struct kxcjk_data *data, int range_index)
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
 	}
 
-	ret &= ~(KXCJK1013_REG_CTRL1_BIT_GSEL0 |
-		 KXCJK1013_REG_CTRL1_BIT_GSEL1);
-	ret |= (KXCJK1013_scale_table[range_index].gsel_0 << 3);
-	ret |= (KXCJK1013_scale_table[range_index].gsel_1 << 4);
+	ret &= ~(KXCJK_REG_CTRL1_BIT_GSEL0 |
+		 KXCJK_REG_CTRL1_BIT_GSEL1);
+	ret |= (kxcjk_scale_table[range_index].gsel_0 << 3);
+	ret |= (kxcjk_scale_table[range_index].gsel_1 << 4);
 
 	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1,
+					KXCJK_REG_CTRL1,
 					ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
@@ -348,11 +348,11 @@ static int kxcjk1013_set_range(struct kxcjk1013_data *data, int range_index)
 	return 0;
 }
 
-static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
+static int kxcjk_chip_init(struct kxcjk_data *data)
 {
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_WHO_AM_I);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_WHO_AM_I);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading who_am_i\n");
 		return ret;
@@ -360,20 +360,20 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 
 	dev_dbg(&data->client->dev, "KXCJK1013 Chip Id %x\n", ret);
 
-	ret = kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk_set_mode(data, STANDBY);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
 	}
 
 	/* Set 12 bit mode */
-	ret |= KXCJK1013_REG_CTRL1_BIT_RES;
+	ret |= KXCJK_REG_CTRL1_BIT_RES;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL1,
+	ret = i2c_smbus_write_byte_data(data->client, KXCJK_REG_CTRL1,
 					ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
@@ -381,11 +381,11 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	}
 
 	/* Setting range to 4G */
-	ret = kxcjk1013_set_range(data, KXCJK1013_RANGE_4G);
+	ret = kxcjk_set_range(data, KXCJK_RANGE_4G);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_DATA_CTRL);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_DATA_CTRL);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_data_ctrl\n");
 		return ret;
@@ -394,32 +394,32 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	data->odr_bits = ret;
 
 	/* Set up INT polarity */
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_INT_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEA;
+	ret |= KXCJK_REG_INT_CTRL1_BIT_IEA;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
+	ret = i2c_smbus_write_byte_data(data->client, KXCJK_REG_INT_CTRL1,
 					ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = kxcjk1013_set_mode(data, OPERATION);
+	ret = kxcjk_set_mode(data, OPERATION);
 	if (ret < 0)
 		return ret;
 
-	data->wake_thres = KXCJK1013_DEFAULT_WAKE_THRES;
+	data->wake_thres = KXCJK_DEFAULT_WAKE_THRES;
 
 	return 0;
 }
 
 #ifdef CONFIG_PM
-static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
+static int kxcjk_get_startup_times(struct kxcjk_data *data)
 {
 	int i;
 	int idx = data->chipset;
@@ -429,11 +429,11 @@ static int kxcjk1013_get_startup_times(struct kxcjk1013_data *data)
 			return odr_start_up_times[idx][i].usec;
 	}
 
-	return KXCJK1013_MAX_STARTUP_TIME_US;
+	return KXCJK_MAX_STARTUP_TIME_US;
 }
 #endif
 
-static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
+static int kxcjk_set_power_state(struct kxcjk_data *data, bool on)
 {
 #ifdef CONFIG_PM
 	int ret;
@@ -446,7 +446,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	}
 	if (ret < 0) {
 		dev_err(&data->client->dev,
-			"Failed: kxcjk1013_set_power_state for %d\n", on);
+			"Failed: kxcjk_set_power_state for %d\n", on);
 		if (on)
 			pm_runtime_put_noidle(&data->client->dev);
 		return ret;
@@ -456,12 +456,12 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 	return 0;
 }
 
-static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
+static int kxcjk_chip_update_thresholds(struct kxcjk_data *data)
 {
 	int waketh_reg, ret;
 
 	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_WAKE_TIMER,
+					KXCJK_REG_WAKE_TIMER,
 					data->wake_dur);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
@@ -470,7 +470,7 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 	}
 
 	waketh_reg = data->chipset == KXTF9 ?
-		KXTF9_REG_WAKE_THRESH : KXCJK1013_REG_WAKE_THRES;
+		KXTF9_REG_WAKE_THRESH : KXCJK_REG_WAKE_THRES;
 	ret = i2c_smbus_write_byte_data(data->client, waketh_reg,
 					data->wake_thres);
 	if (ret < 0) {
@@ -481,63 +481,63 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 	return 0;
 }
 
-static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
-						bool status)
+static int kxcjk_setup_any_motion_interrupt(struct kxcjk_data *data,
+					    bool status)
 {
 	int ret;
-	enum kxcjk1013_mode store_mode;
+	enum kxcjk_mode store_mode;
 
-	ret = kxcjk1013_get_mode(data, &store_mode);
+	ret = kxcjk_get_mode(data, &store_mode);
 	if (ret < 0)
 		return ret;
 
 	/* This is requirement by spec to change state to STANDBY */
-	ret = kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk_set_mode(data, STANDBY);
 	if (ret < 0)
 		return ret;
 
-	ret = kxcjk1013_chip_update_thresholds(data);
+	ret = kxcjk_chip_update_thresholds(data);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_INT_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
 	}
 
 	if (status)
-		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
+		ret |= KXCJK_REG_INT_CTRL1_BIT_IEN;
 	else
-		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
+		ret &= ~KXCJK_REG_INT_CTRL1_BIT_IEN;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
+	ret = i2c_smbus_write_byte_data(data->client, KXCJK_REG_INT_CTRL1,
 					ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
 	}
 
 	if (status)
-		ret |= KXCJK1013_REG_CTRL1_BIT_WUFE;
+		ret |= KXCJK_REG_CTRL1_BIT_WUFE;
 	else
-		ret &= ~KXCJK1013_REG_CTRL1_BIT_WUFE;
+		ret &= ~KXCJK_REG_CTRL1_BIT_WUFE;
 
 	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1, ret);
+					KXCJK_REG_CTRL1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
 	}
 
 	if (store_mode == OPERATION) {
-		ret = kxcjk1013_set_mode(data, OPERATION);
+		ret = kxcjk_set_mode(data, OPERATION);
 		if (ret < 0)
 			return ret;
 	}
@@ -545,59 +545,58 @@ static int kxcjk1013_setup_any_motion_interrupt(struct kxcjk1013_data *data,
 	return 0;
 }
 
-static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
-					      bool status)
+static int kxcjk_setup_new_data_interrupt(struct kxcjk_data *data, bool status)
 {
 	int ret;
-	enum kxcjk1013_mode store_mode;
+	enum kxcjk_mode store_mode;
 
-	ret = kxcjk1013_get_mode(data, &store_mode);
+	ret = kxcjk_get_mode(data, &store_mode);
 	if (ret < 0)
 		return ret;
 
 	/* This is requirement by spec to change state to STANDBY */
-	ret = kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk_set_mode(data, STANDBY);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_INT_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_ctrl1\n");
 		return ret;
 	}
 
 	if (status)
-		ret |= KXCJK1013_REG_INT_CTRL1_BIT_IEN;
+		ret |= KXCJK_REG_INT_CTRL1_BIT_IEN;
 	else
-		ret &= ~KXCJK1013_REG_INT_CTRL1_BIT_IEN;
+		ret &= ~KXCJK_REG_INT_CTRL1_BIT_IEN;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_INT_CTRL1,
+	ret = i2c_smbus_write_byte_data(data->client, KXCJK_REG_INT_CTRL1,
 					ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_int_ctrl1\n");
 		return ret;
 	}
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_CTRL1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_CTRL1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_ctrl1\n");
 		return ret;
 	}
 
 	if (status)
-		ret |= KXCJK1013_REG_CTRL1_BIT_DRDY;
+		ret |= KXCJK_REG_CTRL1_BIT_DRDY;
 	else
-		ret &= ~KXCJK1013_REG_CTRL1_BIT_DRDY;
+		ret &= ~KXCJK_REG_CTRL1_BIT_DRDY;
 
 	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_CTRL1, ret);
+					KXCJK_REG_CTRL1, ret);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
 	}
 
 	if (store_mode == OPERATION) {
-		ret = kxcjk1013_set_mode(data, OPERATION);
+		ret = kxcjk_set_mode(data, OPERATION);
 		if (ret < 0)
 			return ret;
 	}
@@ -605,7 +604,7 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
 	return 0;
 }
 
-static const struct kx_odr_map *kxcjk1013_find_odr_value(
+static const struct kx_odr_map *kxcjk_find_odr_value(
 	const struct kx_odr_map *map, size_t map_size, int val, int val2)
 {
 	int i;
@@ -618,9 +617,9 @@ static const struct kx_odr_map *kxcjk1013_find_odr_value(
 	return ERR_PTR(-EINVAL);
 }
 
-static int kxcjk1013_convert_odr_value(const struct kx_odr_map *map,
-				       size_t map_size, int odr_bits,
-				       int *val, int *val2)
+static int kxcjk_convert_odr_value(const struct kx_odr_map *map,
+				   size_t map_size, int odr_bits,
+				   int *val, int *val2)
 {
 	int i;
 
@@ -635,22 +634,22 @@ static int kxcjk1013_convert_odr_value(const struct kx_odr_map *map,
 	return -EINVAL;
 }
 
-static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
+static int kxcjk_set_odr(struct kxcjk_data *data, int val, int val2)
 {
 	int ret;
-	enum kxcjk1013_mode store_mode;
+	enum kxcjk_mode store_mode;
 	const struct kx_odr_map *odr_setting;
 
-	ret = kxcjk1013_get_mode(data, &store_mode);
+	ret = kxcjk_get_mode(data, &store_mode);
 	if (ret < 0)
 		return ret;
 
 	if (data->chipset == KXTF9)
-		odr_setting = kxcjk1013_find_odr_value(kxtf9_samp_freq_table,
+		odr_setting = kxcjk_find_odr_value(kxtf9_samp_freq_table,
 						       ARRAY_SIZE(kxtf9_samp_freq_table),
 						       val, val2);
 	else
-		odr_setting = kxcjk1013_find_odr_value(samp_freq_table,
+		odr_setting = kxcjk_find_odr_value(samp_freq_table,
 						       ARRAY_SIZE(samp_freq_table),
 						       val, val2);
 
@@ -658,11 +657,11 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 		return PTR_ERR(odr_setting);
 
 	/* To change ODR, the chip must be set to STANDBY as per spec */
-	ret = kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk_set_mode(data, STANDBY);
 	if (ret < 0)
 		return ret;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_DATA_CTRL,
+	ret = i2c_smbus_write_byte_data(data->client, KXCJK_REG_DATA_CTRL,
 					odr_setting->odr_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing data_ctrl\n");
@@ -671,7 +670,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 	data->odr_bits = odr_setting->odr_bits;
 
-	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL2,
+	ret = i2c_smbus_write_byte_data(data->client, KXCJK_REG_CTRL2,
 					odr_setting->wuf_bits);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_ctrl2\n");
@@ -679,7 +678,7 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	}
 
 	if (store_mode == OPERATION) {
-		ret = kxcjk1013_set_mode(data, OPERATION);
+		ret = kxcjk_set_mode(data, OPERATION);
 		if (ret < 0)
 			return ret;
 	}
@@ -687,21 +686,21 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	return 0;
 }
 
-static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
+static int kxcjk_get_odr(struct kxcjk_data *data, int *val, int *val2)
 {
 	if (data->chipset == KXTF9)
-		return kxcjk1013_convert_odr_value(kxtf9_samp_freq_table,
+		return kxcjk_convert_odr_value(kxtf9_samp_freq_table,
 						   ARRAY_SIZE(kxtf9_samp_freq_table),
 						   data->odr_bits, val, val2);
 	else
-		return kxcjk1013_convert_odr_value(samp_freq_table,
+		return kxcjk_convert_odr_value(samp_freq_table,
 						   ARRAY_SIZE(samp_freq_table),
 						   data->odr_bits, val, val2);
 }
 
-static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
+static int kxcjk_get_acc_reg(struct kxcjk_data *data, int axis)
 {
-	u8 reg = KXCJK1013_REG_XOUT_L + axis * 2;
+	u8 reg = KXCJK_REG_XOUT_L + axis * 2;
 	int ret;
 
 	ret = i2c_smbus_read_word_data(data->client, reg);
@@ -714,27 +713,27 @@ static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
 	return ret;
 }
 
-static int kxcjk1013_set_scale(struct kxcjk1013_data *data, int val)
+static int kxcjk_set_scale(struct kxcjk_data *data, int val)
 {
 	int ret, i;
-	enum kxcjk1013_mode store_mode;
+	enum kxcjk_mode store_mode;
 
-	for (i = 0; i < ARRAY_SIZE(KXCJK1013_scale_table); ++i) {
-		if (KXCJK1013_scale_table[i].scale == val) {
-			ret = kxcjk1013_get_mode(data, &store_mode);
+	for (i = 0; i < ARRAY_SIZE(kxcjk_scale_table); ++i) {
+		if (kxcjk_scale_table[i].scale == val) {
+			ret = kxcjk_get_mode(data, &store_mode);
 			if (ret < 0)
 				return ret;
 
-			ret = kxcjk1013_set_mode(data, STANDBY);
+			ret = kxcjk_set_mode(data, STANDBY);
 			if (ret < 0)
 				return ret;
 
-			ret = kxcjk1013_set_range(data, i);
+			ret = kxcjk_set_range(data, i);
 			if (ret < 0)
 				return ret;
 
 			if (store_mode == OPERATION) {
-				ret = kxcjk1013_set_mode(data, OPERATION);
+				ret = kxcjk_set_mode(data, OPERATION);
 				if (ret)
 					return ret;
 			}
@@ -746,11 +745,11 @@ static int kxcjk1013_set_scale(struct kxcjk1013_data *data, int val)
 	return -EINVAL;
 }
 
-static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
+static int kxcjk_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan, int *val,
 			      int *val2, long mask)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
@@ -759,19 +758,19 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 		if (iio_buffer_enabled(indio_dev))
 			ret = -EBUSY;
 		else {
-			ret = kxcjk1013_set_power_state(data, true);
+			ret = kxcjk_set_power_state(data, true);
 			if (ret < 0) {
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
-			ret = kxcjk1013_get_acc_reg(data, chan->scan_index);
+			ret = kxcjk_get_acc_reg(data, chan->scan_index);
 			if (ret < 0) {
-				kxcjk1013_set_power_state(data, false);
+				kxcjk_set_power_state(data, false);
 				mutex_unlock(&data->mutex);
 				return ret;
 			}
 			*val = sign_extend32(ret >> 4, 11);
-			ret = kxcjk1013_set_power_state(data, false);
+			ret = kxcjk_set_power_state(data, false);
 		}
 		mutex_unlock(&data->mutex);
 
@@ -782,12 +781,12 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		*val = 0;
-		*val2 = KXCJK1013_scale_table[data->range].scale;
+		*val2 = kxcjk_scale_table[data->range].scale;
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		mutex_lock(&data->mutex);
-		ret = kxcjk1013_get_odr(data, val, val2);
+		ret = kxcjk_get_odr(data, val, val2);
 		mutex_unlock(&data->mutex);
 		return ret;
 
@@ -796,17 +795,17 @@ static int kxcjk1013_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan, int val,
-			       int val2, long mask)
+static int kxcjk_write_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int val,
+			   int val2, long mask)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		mutex_lock(&data->mutex);
-		ret = kxcjk1013_set_odr(data, val, val2);
+		ret = kxcjk_set_odr(data, val, val2);
 		mutex_unlock(&data->mutex);
 		break;
 	case IIO_CHAN_INFO_SCALE:
@@ -814,7 +813,7 @@ static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		mutex_lock(&data->mutex);
-		ret = kxcjk1013_set_scale(data, val2);
+		ret = kxcjk_set_scale(data, val2);
 		mutex_unlock(&data->mutex);
 		break;
 	default:
@@ -824,14 +823,14 @@ static int kxcjk1013_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int kxcjk1013_read_event(struct iio_dev *indio_dev,
-				   const struct iio_chan_spec *chan,
-				   enum iio_event_type type,
-				   enum iio_event_direction dir,
-				   enum iio_event_info info,
-				   int *val, int *val2)
+static int kxcjk_read_event(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    enum iio_event_type type,
+			    enum iio_event_direction dir,
+			    enum iio_event_info info,
+			    int *val, int *val2)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
 	*val2 = 0;
 	switch (info) {
@@ -848,14 +847,14 @@ static int kxcjk1013_read_event(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
-static int kxcjk1013_write_event(struct iio_dev *indio_dev,
-				    const struct iio_chan_spec *chan,
-				    enum iio_event_type type,
-				    enum iio_event_direction dir,
-				    enum iio_event_info info,
-				    int val, int val2)
+static int kxcjk_write_event(struct iio_dev *indio_dev,
+			     const struct iio_chan_spec *chan,
+			     enum iio_event_type type,
+			     enum iio_event_direction dir,
+			     enum iio_event_info info,
+			     int val, int val2)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
 	if (data->ev_enable_state)
 		return -EBUSY;
@@ -874,23 +873,23 @@ static int kxcjk1013_write_event(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int kxcjk1013_read_event_config(struct iio_dev *indio_dev,
-					  const struct iio_chan_spec *chan,
-					  enum iio_event_type type,
-					  enum iio_event_direction dir)
+static int kxcjk_read_event_config(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
 	return data->ev_enable_state;
 }
 
-static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
-					   const struct iio_chan_spec *chan,
-					   enum iio_event_type type,
-					   enum iio_event_direction dir,
-					   int state)
+static int kxcjk_write_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    int state)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
 	if (state && data->ev_enable_state)
@@ -913,15 +912,15 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	 * enable operation. When runtime pm is disabled the mode
 	 * is always on so sequence doesn't matter
 	 */
-	ret = kxcjk1013_set_power_state(data, state);
+	ret = kxcjk_set_power_state(data, state);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
 
-	ret =  kxcjk1013_setup_any_motion_interrupt(data, state);
+	ret =  kxcjk_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
-		kxcjk1013_set_power_state(data, false);
+		kxcjk_set_power_state(data, false);
 		data->ev_enable_state = 0;
 		mutex_unlock(&data->mutex);
 		return ret;
@@ -933,66 +932,66 @@ static int kxcjk1013_write_event_config(struct iio_dev *indio_dev,
 	return 0;
 }
 
-static int kxcjk1013_buffer_preenable(struct iio_dev *indio_dev)
+static int kxcjk_buffer_preenable(struct iio_dev *indio_dev)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
-	return kxcjk1013_set_power_state(data, true);
+	return kxcjk_set_power_state(data, true);
 }
 
-static int kxcjk1013_buffer_postdisable(struct iio_dev *indio_dev)
+static int kxcjk_buffer_postdisable(struct iio_dev *indio_dev)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
-	return kxcjk1013_set_power_state(data, false);
+	return kxcjk_set_power_state(data, false);
 }
 
-static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
+static ssize_t kxcjk_get_samp_freq_avail(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	const char *str;
 
 	if (data->chipset == KXTF9)
 		str = kxtf9_samp_freq_avail;
 	else
-		str = kxcjk1013_samp_freq_avail;
+		str = kxcjk_samp_freq_avail;
 
 	return sprintf(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(in_accel_sampling_frequency_available, S_IRUGO,
-		       kxcjk1013_get_samp_freq_avail, NULL, 0);
+		       kxcjk_get_samp_freq_avail, NULL, 0);
 
 static IIO_CONST_ATTR(in_accel_scale_available, "0.009582 0.019163 0.038326");
 
-static struct attribute *kxcjk1013_attributes[] = {
+static struct attribute *kxcjk_attributes[] = {
 	&iio_dev_attr_in_accel_sampling_frequency_available.dev_attr.attr,
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
 	NULL,
 };
 
-static const struct attribute_group kxcjk1013_attrs_group = {
-	.attrs = kxcjk1013_attributes,
+static const struct attribute_group kxcjk_attrs_group = {
+	.attrs = kxcjk_attributes,
 };
 
-static const struct iio_event_spec kxcjk1013_event = {
-		.type = IIO_EV_TYPE_THRESH,
-		.dir = IIO_EV_DIR_EITHER,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
-				 BIT(IIO_EV_INFO_ENABLE) |
-				 BIT(IIO_EV_INFO_PERIOD)
+static const struct iio_event_spec kxcjk_event = {
+	.type = IIO_EV_TYPE_THRESH,
+	.dir = IIO_EV_DIR_EITHER,
+	.mask_separate = BIT(IIO_EV_INFO_VALUE) |
+			 BIT(IIO_EV_INFO_ENABLE) |
+			 BIT(IIO_EV_INFO_PERIOD)
 };
 
-#define KXCJK1013_CHANNEL(_axis) {					\
+#define KXCJK_CHANNEL(_axis) {						\
 	.type = IIO_ACCEL,						\
 	.modified = 1,							\
 	.channel2 = IIO_MOD_##_axis,					\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |		\
-				BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.scan_index = AXIS_##_axis,					\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -1001,47 +1000,47 @@ static const struct iio_event_spec kxcjk1013_event = {
 		.shift = 4,						\
 		.endianness = IIO_LE,					\
 	},								\
-	.event_spec = &kxcjk1013_event,				\
+	.event_spec = &kxcjk_event,					\
 	.num_event_specs = 1						\
 }
 
-static const struct iio_chan_spec kxcjk1013_channels[] = {
-	KXCJK1013_CHANNEL(X),
-	KXCJK1013_CHANNEL(Y),
-	KXCJK1013_CHANNEL(Z),
+static const struct iio_chan_spec kxcjk_channels[] = {
+	KXCJK_CHANNEL(X),
+	KXCJK_CHANNEL(Y),
+	KXCJK_CHANNEL(Z),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
-static const struct iio_buffer_setup_ops kxcjk1013_buffer_setup_ops = {
-	.preenable		= kxcjk1013_buffer_preenable,
+static const struct iio_buffer_setup_ops kxcjk_buffer_setup_ops = {
+	.preenable		= kxcjk_buffer_preenable,
 	.postenable		= iio_triggered_buffer_postenable,
-	.postdisable		= kxcjk1013_buffer_postdisable,
+	.postdisable		= kxcjk_buffer_postdisable,
 	.predisable		= iio_triggered_buffer_predisable,
 };
 
-static const struct iio_info kxcjk1013_info = {
-	.attrs			= &kxcjk1013_attrs_group,
-	.read_raw		= kxcjk1013_read_raw,
-	.write_raw		= kxcjk1013_write_raw,
-	.read_event_value	= kxcjk1013_read_event,
-	.write_event_value	= kxcjk1013_write_event,
-	.write_event_config	= kxcjk1013_write_event_config,
-	.read_event_config	= kxcjk1013_read_event_config,
+static const struct iio_info kxcjk_info = {
+	.attrs			= &kxcjk_attrs_group,
+	.read_raw		= kxcjk_read_raw,
+	.write_raw		= kxcjk_write_raw,
+	.read_event_value	= kxcjk_read_event,
+	.write_event_value	= kxcjk_write_event,
+	.write_event_config	= kxcjk_write_event_config,
+	.read_event_config	= kxcjk_read_event_config,
 	.driver_module		= THIS_MODULE,
 };
 
-static const unsigned long kxcjk1013_scan_masks[] = {0x7, 0};
+static const unsigned long kxcjk_scan_masks[] = {0x7, 0};
 
-static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
+static irqreturn_t kxcjk_trigger_handler(int irq, void *p)
 {
 	struct iio_poll_func *pf = p;
 	struct iio_dev *indio_dev = pf->indio_dev;
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&data->mutex);
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(data->client,
-							KXCJK1013_REG_XOUT_L,
+							KXCJK_REG_XOUT_L,
 							AXIS_MAX * 2,
 							(u8 *)data->buffer);
 	mutex_unlock(&data->mutex);
@@ -1056,13 +1055,13 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-static int kxcjk1013_trig_try_reen(struct iio_trigger *trig)
+static int kxcjk_trig_try_reen(struct iio_trigger *trig)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_INT_REL);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 		return ret;
@@ -1071,11 +1070,11 @@ static int kxcjk1013_trig_try_reen(struct iio_trigger *trig)
 	return 0;
 }
 
-static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
-						bool state)
+static int kxcjk_data_rdy_trigger_set_state(struct iio_trigger *trig,
+					    bool state)
 {
 	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&data->mutex);
@@ -1086,17 +1085,17 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	}
 
-	ret = kxcjk1013_set_power_state(data, state);
+	ret = kxcjk_set_power_state(data, state);
 	if (ret < 0) {
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
 	if (data->motion_trig == trig)
-		ret = kxcjk1013_setup_any_motion_interrupt(data, state);
+		ret = kxcjk_setup_any_motion_interrupt(data, state);
 	else
-		ret = kxcjk1013_setup_new_data_interrupt(data, state);
+		ret = kxcjk_setup_new_data_interrupt(data, state);
 	if (ret < 0) {
-		kxcjk1013_set_power_state(data, false);
+		kxcjk_set_power_state(data, false);
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
@@ -1110,24 +1109,24 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	return 0;
 }
 
-static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
-	.set_trigger_state = kxcjk1013_data_rdy_trigger_set_state,
-	.try_reenable = kxcjk1013_trig_try_reen,
+static const struct iio_trigger_ops kxcjk_trigger_ops = {
+	.set_trigger_state = kxcjk_data_rdy_trigger_set_state,
+	.try_reenable = kxcjk_trig_try_reen,
 	.owner = THIS_MODULE,
 };
 
-static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
+static void kxcjk_report_motion_event(struct iio_dev *indio_dev)
 {
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
 	int ret = i2c_smbus_read_byte_data(data->client,
-					   KXCJK1013_REG_INT_SRC2);
+					   KXCJK_REG_INT_SRC2);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_src2\n");
 		return;
 	}
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XN)
+	if (ret & KXCJK_REG_INT_SRC2_BIT_XN)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1136,7 +1135,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_FALLING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XP)
+	if (ret & KXCJK_REG_INT_SRC2_BIT_XP)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1145,7 +1144,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_RISING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YN)
+	if (ret & KXCJK_REG_INT_SRC2_BIT_YN)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1154,7 +1153,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_FALLING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YP)
+	if (ret & KXCJK_REG_INT_SRC2_BIT_YP)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1163,7 +1162,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_RISING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZN)
+	if (ret & KXCJK_REG_INT_SRC2_BIT_ZN)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1172,7 +1171,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_FALLING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZP)
+	if (ret & KXCJK_REG_INT_SRC2_BIT_ZP)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1182,19 +1181,19 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 			       data->timestamp);
 }
 
-static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
+static irqreturn_t kxcjk_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_SRC1);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_INT_SRC1);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error reading reg_int_src1\n");
 		goto ack_intr;
 	}
 
-	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
+	if (ret & KXCJK_REG_INT_SRC1_BIT_WUFS) {
 		if (data->chipset == KXTF9)
 			iio_push_event(indio_dev,
 				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
@@ -1204,24 +1203,24 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 				       IIO_EV_DIR_RISING),
 				       data->timestamp);
 		else
-			kxcjk1013_report_motion_event(indio_dev);
+			kxcjk_report_motion_event(indio_dev);
 	}
 
 ack_intr:
 	if (data->dready_trigger_on)
 		return IRQ_HANDLED;
 
-	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
+	ret = i2c_smbus_read_byte_data(data->client, KXCJK_REG_INT_REL);
 	if (ret < 0)
 		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
+static irqreturn_t kxcjk_data_rdy_trig_poll(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
 	data->timestamp = iio_get_time_ns(indio_dev);
 
@@ -1236,9 +1235,9 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 		return IRQ_HANDLED;
 }
 
-static const char *kxcjk1013_match_acpi_device(struct device *dev,
-					       enum kx_chipset *chipset,
-					       bool *is_smo8500_device)
+static const char *kxcjk_match_acpi_device(struct device *dev,
+					   enum kx_chipset *chipset,
+					   bool *is_smo8500_device)
 {
 	const struct acpi_device_id *id;
 
@@ -1254,10 +1253,10 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	return dev_name(dev);
 }
 
-static int kxcjk1013_probe(struct i2c_client *client,
-			   const struct i2c_device_id *id)
+static int kxcjk_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
 {
-	struct kxcjk1013_data *data;
+	struct kxcjk_data *data;
 	struct iio_dev *indio_dev;
 	const char *name;
 	int ret;
@@ -1274,32 +1273,32 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		data->chipset = (enum kx_chipset)(id->driver_data);
 		name = id->name;
 	} else if (ACPI_HANDLE(&client->dev)) {
-		name = kxcjk1013_match_acpi_device(&client->dev,
+		name = kxcjk_match_acpi_device(&client->dev,
 						   &data->chipset,
 						   &data->is_smo8500_device);
 	} else
 		return -ENODEV;
 
-	ret = kxcjk1013_chip_init(data);
+	ret = kxcjk_chip_init(data);
 	if (ret < 0)
 		return ret;
 
 	mutex_init(&data->mutex);
 
 	indio_dev->dev.parent = &client->dev;
-	indio_dev->channels = kxcjk1013_channels;
-	indio_dev->num_channels = ARRAY_SIZE(kxcjk1013_channels);
-	indio_dev->available_scan_masks = kxcjk1013_scan_masks;
+	indio_dev->channels = kxcjk_channels;
+	indio_dev->num_channels = ARRAY_SIZE(kxcjk_channels);
+	indio_dev->available_scan_masks = kxcjk_scan_masks;
 	indio_dev->name = name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &kxcjk1013_info;
+	indio_dev->info = &kxcjk_info;
 
 	if (client->irq > 0 && !data->is_smo8500_device) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
-						kxcjk1013_data_rdy_trig_poll,
-						kxcjk1013_event_handler,
+						kxcjk_data_rdy_trig_poll,
+						kxcjk_event_handler,
 						IRQF_TRIGGER_RISING,
-						KXCJK1013_IRQ_NAME,
+						KXCJK_IRQ_NAME,
 						indio_dev);
 		if (ret)
 			goto err_poweroff;
@@ -1323,7 +1322,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		}
 
 		data->dready_trig->dev.parent = &client->dev;
-		data->dready_trig->ops = &kxcjk1013_trigger_ops;
+		data->dready_trig->ops = &kxcjk_trigger_ops;
 		iio_trigger_set_drvdata(data->dready_trig, indio_dev);
 		indio_dev->trig = data->dready_trig;
 		iio_trigger_get(indio_dev->trig);
@@ -1332,7 +1331,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 			goto err_poweroff;
 
 		data->motion_trig->dev.parent = &client->dev;
-		data->motion_trig->ops = &kxcjk1013_trigger_ops;
+		data->motion_trig->ops = &kxcjk_trigger_ops;
 		iio_trigger_set_drvdata(data->motion_trig, indio_dev);
 		ret = iio_trigger_register(data->motion_trig);
 		if (ret) {
@@ -1343,8 +1342,8 @@ static int kxcjk1013_probe(struct i2c_client *client,
 
 	ret = iio_triggered_buffer_setup(indio_dev,
 					 &iio_pollfunc_store_time,
-					 kxcjk1013_trigger_handler,
-					 &kxcjk1013_buffer_setup_ops);
+					 kxcjk_trigger_handler,
+					 &kxcjk_buffer_setup_ops);
 	if (ret < 0) {
 		dev_err(&client->dev, "iio triggered buffer setup failed\n");
 		goto err_trigger_unregister;
@@ -1356,7 +1355,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
-					 KXCJK1013_SLEEP_DELAY_MS);
+					 KXCJK_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
 
 	ret = iio_device_register(indio_dev);
@@ -1376,15 +1375,15 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	if (data->motion_trig)
 		iio_trigger_unregister(data->motion_trig);
 err_poweroff:
-	kxcjk1013_set_mode(data, STANDBY);
+	kxcjk_set_mode(data, STANDBY);
 
 	return ret;
 }
 
-static int kxcjk1013_remove(struct i2c_client *client)
+static int kxcjk_remove(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 
@@ -1399,34 +1398,34 @@ static int kxcjk1013_remove(struct i2c_client *client)
 	}
 
 	mutex_lock(&data->mutex);
-	kxcjk1013_set_mode(data, STANDBY);
+	kxcjk_set_mode(data, STANDBY);
 	mutex_unlock(&data->mutex);
 
 	return 0;
 }
 
 #ifdef CONFIG_PM_SLEEP
-static int kxcjk1013_suspend(struct device *dev)
+static int kxcjk_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
 	mutex_lock(&data->mutex);
-	ret = kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk_set_mode(data, STANDBY);
 	mutex_unlock(&data->mutex);
 
 	return ret;
 }
 
-static int kxcjk1013_resume(struct device *dev)
+static int kxcjk_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret = 0;
 
 	mutex_lock(&data->mutex);
-	ret = kxcjk1013_set_mode(data, OPERATION);
+	ret = kxcjk_set_mode(data, OPERATION);
 	mutex_unlock(&data->mutex);
 
 	return ret;
@@ -1434,13 +1433,13 @@ static int kxcjk1013_resume(struct device *dev)
 #endif
 
 #ifdef CONFIG_PM
-static int kxcjk1013_runtime_suspend(struct device *dev)
+static int kxcjk_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 
-	ret = kxcjk1013_set_mode(data, STANDBY);
+	ret = kxcjk_set_mode(data, STANDBY);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "powering off device failed\n");
 		return -EAGAIN;
@@ -1448,18 +1447,18 @@ static int kxcjk1013_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int kxcjk1013_runtime_resume(struct device *dev)
+static int kxcjk_runtime_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
-	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	struct kxcjk_data *data = iio_priv(indio_dev);
 	int ret;
 	int sleep_val;
 
-	ret = kxcjk1013_set_mode(data, OPERATION);
+	ret = kxcjk_set_mode(data, OPERATION);
 	if (ret < 0)
 		return ret;
 
-	sleep_val = kxcjk1013_get_startup_times(data);
+	sleep_val = kxcjk_get_startup_times(data);
 	if (sleep_val < 20000)
 		usleep_range(sleep_val, 20000);
 	else
@@ -1469,10 +1468,10 @@ static int kxcjk1013_runtime_resume(struct device *dev)
 }
 #endif
 
-static const struct dev_pm_ops kxcjk1013_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(kxcjk1013_suspend, kxcjk1013_resume)
-	SET_RUNTIME_PM_OPS(kxcjk1013_runtime_suspend,
-			   kxcjk1013_runtime_resume, NULL)
+static const struct dev_pm_ops kxcjk_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(kxcjk_suspend, kxcjk_resume)
+	SET_RUNTIME_PM_OPS(kxcjk_runtime_suspend,
+			   kxcjk_runtime_resume, NULL)
 };
 
 static const struct acpi_device_id kx_acpi_match[] = {
@@ -1486,7 +1485,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, kx_acpi_match);
 
-static const struct i2c_device_id kxcjk1013_id[] = {
+static const struct i2c_device_id kxcjk_id[] = {
 	{"kxcjk1013", KXCJK1013},
 	{"kxcj91008", KXCJ91008},
 	{"kxtj21009", KXTJ21009},
@@ -1495,20 +1494,21 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 	{}
 };
 
-MODULE_DEVICE_TABLE(i2c, kxcjk1013_id);
+MODULE_DEVICE_TABLE(i2c, kxcjk_id);
 
-static struct i2c_driver kxcjk1013_driver = {
+static struct i2c_driver kxcjk_driver = {
 	.driver = {
-		.name	= KXCJK1013_DRV_NAME,
+		.name	= KXCJK_DRV_NAME,
 		.acpi_match_table = ACPI_PTR(kx_acpi_match),
-		.pm	= &kxcjk1013_pm_ops,
+		.pm	= &kxcjk_pm_ops,
 	},
-	.probe		= kxcjk1013_probe,
-	.remove		= kxcjk1013_remove,
-	.id_table	= kxcjk1013_id,
+	.probe		= kxcjk_probe,
+	.remove		= kxcjk_remove,
+	.id_table	= kxcjk_id,
 };
-module_i2c_driver(kxcjk1013_driver);
+module_i2c_driver(kxcjk_driver);
 
+MODULE_ALIAS("kxcjk-1013");
 MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("KXCJK1013 accelerometer driver");
-- 
2.11.0
