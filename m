Return-Path: <SRS0=wvzB=7T=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 17 Aug 2017 16:21:37 +0200
Message-Id: <4e2e4ba1a5b762949c4fb27e0dbc1de807ea7774.1502979014.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 6/6] iio: accel: kxcjk1013: add support for KXTF9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

KXTF9 has mostly compatible register layout to KXCJK accelerometer.
There is no motion direction interrupt support, but there is tap
direction detection instead (not implemented in this patch).

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/Kconfig      |   4 +-
 drivers/iio/accel/kxcjk-1013.c | 119 +++++++++++++++++++++++++++++++++++------
 2 files changed, 106 insertions(+), 17 deletions(-)

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
index 8bde6bead073..a3f4fe1813d1 100644
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
@@ -48,19 +55,43 @@
 
 #define KXCJK1013_REG_DCST_RESP		0x0C
 #define KXCJK1013_REG_WHO_AM_I		0x0F
-#define KXREG_INT_SRC_DATA		0x16
+#define KXTF9_REG_TILT_POS_CUR		0x10
+#define KXTF9_REG_TILT_POS_PREV		0x11
+#define KXTF9_REG_INT_SRC1		0x15
+#define KXREG_INT_SRC_DATA		0x16	/* compatible; KXTF9: INT_SRC2, KXCJK: INT_SRC1 */
 #define KXCJK1013_REG_INT_SRC2		0x17
 #define KXCJK1013_REG_STATUS_REG	0x18
 #define KXCJK1013_REG_INT_REL		0x1A
 #define KXREG_CTRL1			0x1B
-#define KXREG_CTRL3			0x1D
+#define KXREG_CTRL2			0x1C	/* KXTF9: CTRL_REG2 */
+#define KXREG_CTRL3			0x1D	/* mostly compatible; KXTF9: CTRL_REG3, KXCJK: CTRL_REG2 */
 #define KXREG_INT_CTRL1			0x1E
 #define KXREG_INT_CTRL2			0x1F
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
 
+/* TILT_POS bits */
+#define KXTF9_REG_TILT_BIT_LEFT_EDGE	BIT(5)
+#define KXTF9_REG_TILT_BIT_RIGHT_EDGE	BIT(4)
+#define KXTF9_REG_TILT_BIT_LOWER_EDGE	BIT(3)
+#define KXTF9_REG_TILT_BIT_UPPER_EDGE	BIT(2)
+#define KXTF9_REG_TILT_BIT_FACE_DOWN	BIT(1)
+#define KXTF9_REG_TILT_BIT_FACE_UP	BIT(0)
+
 #define KXREG_CTRL1_BIT_PC1	BIT(7)
 #define KXREG_CTRL1_BIT_RES	BIT(6)
 #define KXREG_CTRL1_BIT_DRDY	BIT(5)
@@ -70,6 +101,7 @@
 #define KXREG_CTRL1_BIT_WUFE	BIT(1)
 #define KXREG_CTRL1_BIT_TPE	BIT(0)
 
+#define KXREG_INT_CTRL1_BIT_IEU	BIT(2)
 #define KXREG_INT_CTRL1_BIT_IEL	BIT(3)
 #define KXREG_INT_CTRL1_BIT_IEA	BIT(4)
 #define KXREG_INT_CTRL1_BIT_IEN	BIT(5)
@@ -79,11 +111,16 @@
 
 #define KXCJK1013_SLEEP_DELAY_MS	2000
 
-/* KXCJK: INT_SOURCE1 */
+/* KXCJK: INT_SOURCE1, KXTF9: INT_SRC_REG2 */
+#define KXREG_INT_BIT_TPS	BIT(0)
 #define KXREG_INT_BIT_WUFS	BIT(1)
+#define KXREG_INT_MASK_TDTS	(BIT(2) | BIT(3))
+#define KXREG_INT_TAP_NONE		0
+#define KXREG_INT_TAP_SINGLE		BIT(2)
+#define KXREG_INT_TAP_DOUBLE		BIT(3)
 #define KXREG_INT_BIT_DRDY	BIT(4)
 
-/* KXCJK: INT_SOURCE2: motion detect */
+/* KXCJK: INT_SOURCE2: motion detect, KXTF9: INT_SRC_REG1: tap detect */
 #define KXREG_MOTION_INT_BIT_ZP	BIT(0)
 #define KXREG_MOTION_INT_BIT_ZN	BIT(1)
 #define KXREG_MOTION_INT_BIT_YP	BIT(2)
@@ -97,6 +134,7 @@ enum kx_chipset {
 	KXCJK1013,
 	KXCJ91008,
 	KXTJ21009,
+	KXTF9,
 	KX_MAX_CHIPS /* this must be last */
 };
 
@@ -162,6 +200,18 @@ static const struct kx_odr_map samp_freq_table[] = {
 static const char *const samp_freq_avail =
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
@@ -212,6 +262,15 @@ static const struct {
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
@@ -408,7 +467,7 @@ static int kxcjk1013_set_power_state(struct kxcjk1013_data *data, bool on)
 
 static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
 {
-	int ret;
+	int waketh_reg, ret;
 
 	ret = i2c_smbus_write_byte_data(data->client,
 					KXCJK1013_REG_WAKE_TIMER,
@@ -419,8 +478,9 @@ static int kxcjk1013_chip_update_thresholds(struct kxcjk1013_data *data)
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
@@ -592,9 +652,14 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
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
@@ -631,9 +696,14 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
 
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
@@ -888,7 +958,16 @@ static ssize_t kxcjk1013_get_samp_freq_avail(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
 {
-	return sprintf(buf, "%s\n", samp_freq_avail);
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct kxcjk1013_data *data = iio_priv(indio_dev);
+	const char *str;
+
+	if (data->chipset == KXTF9)
+		str = kxtf9_samp_freq_avail;
+	else
+		str = samp_freq_avail;
+
+	return sprintf(buf, "%s\n", str);
 }
 
 static IIO_DEVICE_ATTR(in_accel_sampling_frequency_available, S_IRUGO,
@@ -1121,7 +1200,16 @@ static irqreturn_t kxcjk1013_event_handler(int irq, void *private)
 	}
 
 	if (ret & KXREG_INT_BIT_WUFS) {
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
