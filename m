Return-Path: <SRS0=AYw5=AS=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Sun, 17 Sep 2017 17:01:04 +0200
Message-Id: <99eda9726b28113cd8499506b3cda62029d39069.1505660069.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 6/8] iio: accel: kxcjk1013: add support for KXTF9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

KXTF9 has mostly compatible register layout to KXCJK accelerometer.
There is no motion direction interrupt support, but there is tap
direction detection instead (not implemented in this patch).

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/Kconfig      |   4 +-
 drivers/iio/accel/kxcjk-1013.c | 115 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 104 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index 15de262015df..0be352a7b6f4 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -219,8 +219,8 @@ config KXCJK1013
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Say Y here if you want to build a driver for the Kionix KXCJK-1013
-	  triaxial acceleration sensor. This driver also supports KXCJ9-1008
-	  and KXTJ2-1009.
+	  triaxial acceleration sensor. This driver also supports KXCJ9-1008,
+	  KXTJ2-1009 and KXTF9.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called kxcjk-1013.
diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 4e8919d48635..8892dc5d2422 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -34,6 +34,13 @@
 #define KXCJK1013_DRV_NAME "kxcjk1013"
 #define KXCJK1013_IRQ_NAME "kxcjk1013_event"
 
+#define KXTF9_REG_HP_XOUT_L		0x00
+#define KXTF9_REG_HP_XOUT_H		0x01
+#define KXTF9_REG_HP_YOUT_L		0x02
+#define KXTF9_REG_HP_YOUT_H		0x03
+#define KXTF9_REG_HP_ZOUT_L		0x04
+#define KXTF9_REG_HP_ZOUT_H		0x05
+
 #define KXCJK1013_REG_XOUT_L		0x06
 /*
  * From low byte X axis register, all the other addresses of Y and Z can be
@@ -48,17 +55,33 @@
 
 #define KXCJK1013_REG_DCST_RESP		0x0C
 #define KXCJK1013_REG_WHO_AM_I		0x0F
-#define KXCJK1013_REG_INT_SRC1		0x16
+#define KXTF9_REG_TILT_POS_CUR		0x10
+#define KXTF9_REG_TILT_POS_PREV		0x11
+#define KXTF9_REG_INT_SRC1		0x15
+#define KXCJK1013_REG_INT_SRC1		0x16	/* compatible, but called INT_SRC2 in KXTF9 ds */
 #define KXCJK1013_REG_INT_SRC2		0x17
 #define KXCJK1013_REG_STATUS_REG	0x18
 #define KXCJK1013_REG_INT_REL		0x1A
 #define KXCJK1013_REG_CTRL1		0x1B
-#define KXCJK1013_REG_CTRL2		0x1D
+#define KXTF9_REG_CTRL2			0x1C
+#define KXCJK1013_REG_CTRL2		0x1D	/* mostly compatible, CTRL_REG3 in KTXF9 ds */
 #define KXCJK1013_REG_INT_CTRL1		0x1E
 #define KXCJK1013_REG_INT_CTRL2		0x1F
+#define KXTF9_REG_INT_CTRL3		0x20
 #define KXCJK1013_REG_DATA_CTRL		0x21
+#define KXTF9_REG_TILT_TIMER		0x28
 #define KXCJK1013_REG_WAKE_TIMER	0x29
+#define KXTF9_REG_TDT_TIMER		0x2B
+#define KXTF9_REG_TDT_THRESH_H		0x2C
+#define KXTF9_REG_TDT_THRESH_L		0x2D
+#define KXTF9_REG_TDT_TAP_TIMER		0x2E
+#define KXTF9_REG_TDT_TOTAL_TIMER	0x2F
+#define KXTF9_REG_TDT_LATENCY_TIMER	0x30
+#define KXTF9_REG_TDT_WINDOW_TIMER	0x31
 #define KXCJK1013_REG_SELF_TEST		0x3A
+#define KXTF9_REG_WAKE_THRESH		0x5A
+#define KXTF9_REG_TILT_ANGLE		0x5C
+#define KXTF9_REG_HYST_SET		0x5F
 #define KXCJK1013_REG_WAKE_THRES	0x6A
 
 #define KXCJK1013_REG_CTRL1_BIT_PC1	BIT(7)
@@ -68,18 +91,32 @@
 #define KXCJK1013_REG_CTRL1_BIT_GSEL0	BIT(3)
 #define KXCJK1013_REG_CTRL1_BIT_WUFE	BIT(1)
 
+#define KXCJK1013_REG_INT_CTRL1_BIT_IEU	BIT(2)	/* KXTF9 */
 #define KXCJK1013_REG_INT_CTRL1_BIT_IEL	BIT(3)
 #define KXCJK1013_REG_INT_CTRL1_BIT_IEA	BIT(4)
 #define KXCJK1013_REG_INT_CTRL1_BIT_IEN	BIT(5)
 
+#define KXTF9_REG_TILT_BIT_LEFT_EDGE	BIT(5)
+#define KXTF9_REG_TILT_BIT_RIGHT_EDGE	BIT(4)
+#define KXTF9_REG_TILT_BIT_LOWER_EDGE	BIT(3)
+#define KXTF9_REG_TILT_BIT_UPPER_EDGE	BIT(2)
+#define KXTF9_REG_TILT_BIT_FACE_DOWN	BIT(1)
+#define KXTF9_REG_TILT_BIT_FACE_UP	BIT(0)
+
 #define KXCJK1013_DATA_MASK_12_BIT	0x0FFF
 #define KXCJK1013_MAX_STARTUP_TIME_US	100000
 
 #define KXCJK1013_SLEEP_DELAY_MS	2000
 
+#define KXCJK1013_REG_INT_SRC1_BIT_TPS	BIT(0)	/* KXTF9 */
 #define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(1)
+#define KXCJK1013_REG_INT_SRC1_MASK_TDTS	(BIT(2) | BIT(3))	/* KXTF9 */
+#define KXCJK1013_REG_INT_SRC1_TAP_NONE		0
+#define KXCJK1013_REG_INT_SRC1_TAP_SINGLE		BIT(2)
+#define KXCJK1013_REG_INT_SRC1_TAP_DOUBLE		BIT(3)
 #define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
 
+/* KXCJK: INT_SOURCE2: motion detect, KXTF9: INT_SRC_REG1: tap detect */
 #define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
 #define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
 #define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
@@ -93,6 +130,7 @@ enum kx_chipset {
 	KXCJK1013,
 	KXCJ91008,
 	KXTJ21009,
+	KXTF9,
 	KX_MAX_CHIPS /* this must be last */
 };
 
@@ -158,6 +196,18 @@ static const struct kx_odr_map samp_freq_table[] = {
 static const char *const kxcjk1013_samp_freq_avail =
 	"0.781000 1.563000 3.125000 6.250000 12.500000 25 50 100 200 400 800 1600";
 
+static const struct kx_odr_map kxtf9_samp_freq_table[] = {
+	{ 25, 0, 0x01, 0x00 },
+	{ 50, 0, 0x02, 0x01 },
+	{ 100, 0, 0x03, 0x01 },
+	{ 200, 0, 0x04, 0x01 },
+	{ 400, 0, 0x05, 0x01 },
+	{ 800, 0, 0x06, 0x01 },
+};
+
+static const char *const kxtf9_samp_freq_avail =
+	"25 50 100 200 400 800";
+
 /* Refer to section 4 of the specification */
 static const struct {
 	int odr_bits;
@@ -208,6 +258,15 @@ static const struct {
 		{0x06, 3000},
 		{0x07, 2000},
 	},
+	/* KXTF9 */
+	{
+		{0x01, 81000},
+		{0x02, 41000},
+		{0x03, 21000},
+		{0x04, 11000},
+		{0x05, 5100},
+		{0x06, 2700},
+	},
 };
 
 static const struct {
@@ -404,7 +463,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
-	int ret;
+	int waketh_reg, ret;
 
 	ret = i2c_smbus_write_byte_data(data->client,
 					KXCJK1013_REG_WAKE_TIMER,
@@ -415,8 +474,9 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 		return ret;
 	}
 
-	ret = i2c_smbus_write_byte_data(data->client,
-					KXCJK1013_REG_WAKE_THRES,
+	waketh_reg = data->chipset == KXTF9 ?
+		KXTF9_REG_WAKE_THRESH : KXCJK1013_REG_WAKE_THRES;
+	ret = i2c_smbus_write_byte_data(data->client, waketh_reg,
 					data->wake_thres);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_wake_thres\n");
@@ -590,9 +650,14 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 	if (ret < 0)
 		return ret;
 
-	odr_setting = kxcjk1013_find_odr_value(samp_freq_table,
-					       ARRAY_SIZE(samp_freq_table),
-					       val, val2);
+	if (data->chipset == KXTF9)
+		odr_setting = kxcjk1013_find_odr_value(kxtf9_samp_freq_table,
+						       ARRAY_SIZE(kxtf9_samp_freq_table),
+						       val, val2);
+	else
+		odr_setting = kxcjk1013_find_odr_value(samp_freq_table,
+						       ARRAY_SIZE(samp_freq_table),
+						       val, val2);
 
 	if (IS_ERR(odr_setting))
 		return PTR_ERR(odr_setting);
@@ -629,9 +694,14 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
 static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
 {
-	return kxcjk1013_convert_odr_value(samp_freq_table,
-					   ARRAY_SIZE(samp_freq_table),
-					   data->odr_bits, val, val2);
+	if (data->chipset == KXTF9)
+		return kxcjk1013_convert_odr_value(kxtf9_samp_freq_table,
+						   ARRAY_SIZE(kxtf9_samp_freq_table),
+						   data->odr_bits, val, val2);
+	else
+		return kxcjk1013_convert_odr_value(samp_freq_table,
+						   ARRAY_SIZE(samp_freq_table),
+						   data->odr_bits, val, val2);
 }
 
 static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
@@ -886,7 +956,16 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%s\n", kxcjk1013_samp_freq_avail);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	const char *str;
+
+	if (data->chipset == KXTF9)
+		str = kxtf9_samp_freq_avail;
+	else
+		str = kxcjk1013_samp_freq_avail;
+
+	return sprintf(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(in_accel_sampling_frequency_available, S_IRUGO,
@@ -1121,7 +1200,16 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	}
 
 	if (ret & KXCJK1013_REG_INT_SRC1_BIT_WUFS) {
-		kxcjk1013_report_motion_event(indio_dev);
+		if (data->chipset == KXTF9)
+			iio_push_event(indio_dev,
+				       IIO_MOD_EVENT_CODE(IIO_ACCEL,
+				       0,
+				       IIO_MOD_X_AND_Y_AND_Z,
+				       IIO_EV_TYPE_THRESH,
+				       IIO_EV_DIR_RISING),
+				       data->timestamp);
+		else
+			kxcjk1013_report_motion_event(indio_dev);
 	}
 
 ack_intr:
@@ -1414,6 +1502,7 @@ static const struct i2c_device_id kxcjk1013_id[] = {
 	{"kxcjk1013", KXCJK1013},
 	{"kxcj91008", KXCJ91008},
 	{"kxtj21009", KXTJ21009},
+	{"kxtf9",     KXTF9},
 	{"SMO8500",   KXCJ91008},
 	{}
 };
-- 
2.11.0
