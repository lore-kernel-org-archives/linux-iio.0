Return-Path: <SRS0=3Bdj=KB=novotny.cz=tomas@kernel.org>
From: Tomas Novotny <tomas@novotny.cz>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 4/4] iio: vcnl4000: add support for VCNL4200
Date: Tue, 17 Jul 2018 18:46:55 +0200
Message-Id: <20180717164655.27142-5-tomas@novotny.cz>
In-Reply-To: <20180717164655.27142-1-tomas@novotny.cz>
References: <20180717164655.27142-1-tomas@novotny.cz>
List-ID: <linux-iio@vger.kernel.org>

VCNL4200 is an integrated long distance (up to 1500mm) proximity and
ambient light sensor.

The support is very basic. There is no configuration of proximity and
ambient light sensing yet. Only the reading of both measured values is
done.

The reading of ambient light and proximity values is blocking. If you
request a new value too early, the driver waits for new value to be
ready.

Signed-off-by: Tomas Novotny <tomas@novotny.cz>
---
 drivers/iio/light/Kconfig    |   5 +-
 drivers/iio/light/vcnl4000.c | 114 ++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 109 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 074e50657366..c0344a961f54 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -430,11 +430,12 @@ config US5182D
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
index 642a366c1479..5de0d500c310 100644
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
+ *   interrupts (VCNL4010/20, VCNL4200)
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
@@ -49,6 +58,14 @@
 enum vcnl4000_device_ids {
 	VCNL4000,
 	VCNL4010,
+	VCNL4200,
+};
+
+struct vcnl4200_channel {
+	u8 reg;
+	ktime_t last_measurement;
+	ktime_t sampling_rate;
+	struct mutex lock;
 };
 
 struct vcnl4000_data {
@@ -57,7 +74,9 @@ struct vcnl4000_data {
 	int rev;
 	int al_scale;
 	const struct vcnl4000_chip_spec *chip_spec;
-	struct mutex lock;
+	struct mutex vcnl4000_lock;
+	struct vcnl4200_channel vcnl4200_al;
+	struct vcnl4200_channel vcnl4200_ps;
 };
 
 struct vcnl4000_chip_spec {
@@ -70,6 +89,7 @@ struct vcnl4000_chip_spec {
 static const struct i2c_device_id vcnl4000_id[] = {
 	{ "vcnl4000", VCNL4000 },
 	{ "vcnl4010", VCNL4010 },
+	{ "vcnl4200", VCNL4200 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vcnl4000_id);
@@ -100,6 +120,42 @@ static int vcnl4000_init(struct vcnl4000_data *data)
 
 	data->rev = ret & 0xf;
 	data->al_scale = 250000;
+	mutex_init(&data->vcnl4000_lock);
+
+	return 0;
+};
+
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
+	data->rev = (ret >> 8) & 0xf;
+
+	/* Set defaults and enable both channels */
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_AL_CONF, 0x00);
+	if (ret < 0)
+		return ret;
+	ret = i2c_smbus_write_byte_data(data->client, VCNL4200_PS_CONF1, 0x00);
+	if (ret < 0)
+		return ret;
+
+	data->al_scale = 24000;
+	data->vcnl4200_al.reg = VCNL4200_AL_DATA;
+	data->vcnl4200_ps.reg = VCNL4200_PS_DATA;
+	/* Integration time is 50ms, but the experiments show 54ms in total. */
+	data->vcnl4200_al.sampling_rate = ktime_set(0, 54000 * 1000);
+	data->vcnl4200_ps.sampling_rate = ktime_set(0, 4200 * 1000);
+	data->vcnl4200_al.last_measurement = ktime_set(0, 0);
+	data->vcnl4200_ps.last_measurement = ktime_set(0, 0);
+	mutex_init(&data->vcnl4200_al.lock);
+	mutex_init(&data->vcnl4200_ps.lock);
 
 	return 0;
 };
@@ -111,7 +167,7 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	__be16 buf;
 	int ret;
 
-	mutex_lock(&data->lock);
+	mutex_lock(&data->vcnl4000_lock);
 
 	ret = i2c_smbus_write_byte_data(data->client, VCNL4000_COMMAND,
 					req_mask);
@@ -140,16 +196,43 @@ static int vcnl4000_measure(struct vcnl4000_data *data, u8 req_mask,
 	if (ret < 0)
 		goto fail;
 
-	mutex_unlock(&data->lock);
+	mutex_unlock(&data->vcnl4000_lock);
 	*val = be16_to_cpu(buf);
 
 	return 0;
 
 fail:
-	mutex_unlock(&data->lock);
+	mutex_unlock(&data->vcnl4000_lock);
 	return ret;
 }
 
+static int vcnl4200_measure(struct vcnl4000_data *data,
+		struct vcnl4200_channel *chan, int *val)
+{
+	int ret;
+	s64 delta;
+	ktime_t next_measurement;
+
+	mutex_lock(&chan->lock);
+
+	next_measurement = ktime_add(chan->last_measurement,
+			chan->sampling_rate);
+	delta = ktime_us_delta(next_measurement, ktime_get());
+	if (delta > 0)
+		usleep_range(delta, delta + 500);
+	chan->last_measurement = ktime_get();
+
+	mutex_unlock(&chan->lock);
+
+	ret = i2c_smbus_read_word_data(data->client, chan->reg);
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
@@ -157,6 +240,11 @@ static int vcnl4000_measure_light(struct vcnl4000_data *data, int *val)
 			VCNL4000_AL_RESULT_HI, val);
 }
 
+static int vcnl4200_measure_light(struct vcnl4000_data *data, int *val)
+{
+	return vcnl4200_measure(data, &data->vcnl4200_al, val);
+}
+
 static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
 {
 	return vcnl4000_measure(data,
@@ -164,6 +252,11 @@ static int vcnl4000_measure_proximity(struct vcnl4000_data *data, int *val)
 			VCNL4000_PS_RESULT_HI, val);
 }
 
+static int vcnl4200_measure_proximity(struct vcnl4000_data *data, int *val)
+{
+	return vcnl4200_measure(data, &data->vcnl4200_ps, val);
+}
+
 static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 	[VCNL4000] = {
 		.prod = "VCNL4000",
@@ -177,6 +270,12 @@ static const struct vcnl4000_chip_spec vcnl4000_chip_spec_cfg[] = {
 		.measure_light = vcnl4000_measure_light,
 		.measure_proximity = vcnl4000_measure_proximity,
 	},
+	[VCNL4200] = {
+		.prod = "VCNL4200",
+		.init = vcnl4200_init,
+		.measure_light = vcnl4200_measure_light,
+		.measure_proximity = vcnl4200_measure_proximity,
+	},
 };
 
 static const struct iio_chan_spec vcnl4000_channels[] = {
@@ -245,7 +344,6 @@ static int vcnl4000_probe(struct i2c_client *client,
 	data->client = client;
 	data->id = id->driver_data;
 	data->chip_spec = &vcnl4000_chip_spec_cfg[data->id];
-	mutex_init(&data->lock);
 
 	ret = data->chip_spec->init(data);
 	if (ret < 0)
-- 
2.12.3
