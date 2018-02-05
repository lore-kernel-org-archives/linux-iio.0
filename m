Return-Path: <SRS0=wkc1=E7=novotny.cz=tomas@kernel.org>
From: Tomas Novotny <tomas@novotny.cz>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: vcnl4000: add support for VCNL4200
Date: Mon,  5 Feb 2018 19:04:24 +0100
Message-Id: <20180205180424.30725-3-tomas@novotny.cz>
In-Reply-To: <20180205180424.30725-1-tomas@novotny.cz>
References: <20180205180424.30725-1-tomas@novotny.cz>
List-ID: <linux-iio@vger.kernel.org>

VCNL4200 is an integrated long distance (up to 1500mm) proximity and
ambient light sensor.

The support is very basic. There is no configuration of proximity and
ambient light sensing yet. Only the reading of both measured values is
done.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/Kconfig    |  5 +--
 drivers/iio/light/vcnl4000.c | 72 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 2356ed9285df..cab222fa8d18 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -396,11 +396,12 @@ config US5182D
 	 will be called us5182d.
 
 config VCNL4000
-	tristate "VCNL4000/4010/4020 combined ALS and proximity sensor"
+	tristate "VCNL4000/4010/4020/4200 combined ALS and proximity sensor"
 	depends on I2C
 	help
 	 Say Y here if you want to build a driver for the Vishay VCNL4000,
-	 VCNL4010, VCNL4020 combined ambient light and proximity sensor.
+	 VCNL4010, VCNL4020, VCNL4200 combined ambient light and proximity
+	 sensor.
 
 	 To compile this driver as a module, choose M here: the
 	 module will be called vcnl4000.
diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index d7e43fd9333e..41f5fad50f63 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1,5 +1,5 @@
 /*
- * vcnl4000.c - Support for Vishay VCNL4000/4010/4020 combined ambient
+ * vcnl4000.c - Support for Vishay VCNL4000/4010/4020/4200 combined ambient
  * light and proximity sensor
  *
  * Copyright 2012 Peter Meerwald <pmeerw@pmeerw.net>
@@ -8,13 +8,15 @@
  * the GNU General Public License.  See the file COPYING in the main
  * directory of this archive for more details.
  *
- * IIO driver for VCNL4000 (7-bit I2C slave address 0x13)
+ * IIO driver for:
+ *   VCNL4000/10/20 (7-bit I2C slave address 0x13)
+ *   VCNL4200 (7-bit I2C slave address 0x51)
  *
  * TODO:
  *   allow to adjust IR current
  *   proximity threshold and event handling
  *   periodic ALS/proximity measurement (VCNL4010/20)
- *   interrupts (VCNL4010/20)
+ *   interrupts (VCNL4010/20/200)
  */
 
 #include <linux/module.h>
@@ -28,6 +30,7 @@
 #define VCNL4000_DRV_NAME "vcnl4000"
 #define VCNL4000_PROD_ID	0x01
 #define VCNL4010_PROD_ID	0x02 /* for VCNL4020, VCNL4010 */
+#define VCNL4200_PROD_ID	0x58
 
 #define VCNL4000_COMMAND	0x80 /* Command register */
 #define VCNL4000_PROD_REV	0x81 /* Product ID and Revision ID */
@@ -40,6 +43,12 @@
 #define VCNL4000_PS_MEAS_FREQ	0x89 /* Proximity test signal frequency */
 #define VCNL4000_PS_MOD_ADJ	0x8a /* Proximity modulator timing adjustment */
 
+#define VCNL4200_AL_CONF	0x00 /* Ambient light configuration */
+#define VCNL4200_PS_CONF1	0x03 /* Proximity configuration */
+#define VCNL4200_PS_DATA	0x08 /* Proximity data */
+#define VCNL4200_AL_DATA	0x09 /* Ambient light data */
+#define VCNL4200_DEV_ID		0x0e /* Device ID, slave address and version */
+
 /* Bit masks for COMMAND register */
 #define VCNL4000_AL_RDY		BIT(6) /* ALS data ready? */
 #define VCNL4000_PS_RDY		BIT(5) /* proximity data ready? */
@@ -48,6 +57,7 @@
 
 enum vcnl4000_device_ids {
 	VCNL4000,
+	VCNL4200,
 };
 
 struct vcnl4000_data {
@@ -68,6 +78,7 @@ struct vcnl4000_chip_spec {
 
 static const struct i2c_device_id vcnl4000_id[] = {
 	{ "vcnl4000", VCNL4000 },
+	{ "vcnl4200", VCNL4200 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
@@ -92,6 +103,33 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 	return 0;
 };
 
+static int vcnl4200_init(struct vcnl4000_data *data)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
+	if (ret < 0)
+		return ret;
+
+	if ((ret & 0xff) != VCNL4200_PROD_ID)
+		return -ENODEV;
+
+	data->prod = "VCNL4200";
+	data->rev = ret >> 8 & 0xf;
+
+	/* Set defaults and enable both sensors */
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
+	if (ret < 0)
+		return -EIO;
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
+	if (ret < 0)
+		return -EIO;
+
+	data->al_scale = 24000;
+
+	return 0;
+};
+
 static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 				u8 rdy_mask, u8 data_reg, int *val)
 {
@@ -138,6 +176,19 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	return ret;
 }
 
+static int vcnl4200_measure(struct vcnl4000_data *data, u8 reg, int *val)
+{
+	int ret;
+
+	ret = i2c_smbus_read_word_data(data->client, reg);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+
+	return 0;
+}
+
 static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
 {
 	return vcnl4000_measure(data,
@@ -145,6 +196,11 @@ static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
 			VCNL4000_AL_RESULT_HI, val);
 }
 
+static int vcnl4200_measure_light(struct vcnl4000_data *data, int *val)
+{
+	return vcnl4200_measure(data, VCNL4200_AL_DATA, val);
+}
+
 static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
 {
 	return vcnl4000_measure(data,
@@ -152,12 +208,22 @@ static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
 			VCNL4000_PS_RESULT_HI, val);
 }
 
+static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
+{
+	return vcnl4200_measure(data, VCNL4200_PS_DATA, val);
+}
+
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	[VCNL4000] = {
 		.init = vcnl4000_init,
 		.measure_light = vcnl4000_measure_light,
 		.measure_proximity = vcnl4000_measure_proximity,
 	},
+	[VCNL4200] = {
+		.init = vcnl4200_init,
+		.measure_light = vcnl4200_measure_light,
+		.measure_proximity = vcnl4200_measure_proximity,
+	},
 };
 
 static const struct iio_chan_spec vcnl4000_channels[] = {
-- 
2.12.3
