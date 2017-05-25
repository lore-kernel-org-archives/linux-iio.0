Return-Path: <SRS0=IgB6=47=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	devicetree@vger.kernel.org
Subject: [PATCH v2] iio: proximity: as3935: noise detection + threshold changes
Date: Wed, 24 May 2017 22:52:29 -0700
Message-Id: <20170525055229.11659-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

Most applications are too noisy to allow the default noise and
watchdog settings, and thus need to be configurable via DT
properties.

Also default settings to POR defaults on a reset, and register
distuber interrupts as noise since it prevents proper usage.

Cc: devicetree@vger.kernel.org
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---

Changes from v1:
* Add documentation for noise_level_tripped attribute
* Broke out spi-max-frequency to another patchset

 .../ABI/testing/sysfs-bus-iio-proximity-as3935     |  8 ++++
 .../devicetree/bindings/iio/proximity/as3935.txt   |  5 +++
 drivers/iio/proximity/as3935.c                     | 43 ++++++++++++++++++++--
 3 files changed, 53 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935 b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
index 33e96f740639..147d4e8a1403 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
+++ b/Documentation/ABI/testing/sysfs-bus-iio-proximity-as3935
@@ -14,3 +14,11 @@ Description:
 		Show or set the gain boost of the amp, from 0-31 range.
 		18 = indoors (default)
 		14 = outdoors
+
+What		/sys/bus/iio/devices/iio:deviceX/noise_level_tripped
+Date:		May 2017
+KernelVersion:	4.13
+Contact:	Matt Ranostay <matt.ranostay@konsulko.com>
+Description:
+		When 1 the noise level is over the trip level and not reporting
+		valid data
diff --git a/Documentation/devicetree/bindings/iio/proximity/as3935.txt b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
index ae23dd8da736..0b8a7ec1d3dc 100644
--- a/Documentation/devicetree/bindings/iio/proximity/as3935.txt
+++ b/Documentation/devicetree/bindings/iio/proximity/as3935.txt
@@ -15,6 +15,10 @@ Optional properties:
 	- ams,tuning-capacitor-pf: Calibration tuning capacitor stepping
 	  value 0 - 120pF. This will require using the calibration data from
 	  the manufacturer.
+	- ams,nflwdth: Set the noise and watchdog threshold register on
+	  startup. This will need to set according to the noise from the
+	  MCU board, and possibly the local environment. Refer to the
+	  datasheet for the threshold settings.
 
 Example:
 
@@ -25,4 +29,5 @@ as3935@0 {
 	interrupt-parent = <&gpio1>;
 	interrupts = <16 1>;
 	ams,tuning-capacitor-pf = <80>;
+	ams,nflwdth = <0x44>;
 };
diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index aa4df0dcc8c9..ec2f40e0791c 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -39,8 +39,12 @@
 #define AS3935_AFE_GAIN_MAX	0x1F
 #define AS3935_AFE_PWR_BIT	BIT(0)
 
+#define AS3935_NFLWDTH		0x01
+#define AS3935_NFLWDTH_MASK	0x7f
+
 #define AS3935_INT		0x03
 #define AS3935_INT_MASK		0x0f
+#define AS3935_DISTURB_INT	BIT(2)
 #define AS3935_EVENT_INT	BIT(3)
 #define AS3935_NOISE_INT	BIT(0)
 
@@ -48,6 +52,7 @@
 #define AS3935_DATA_MASK	0x3F
 
 #define AS3935_TUNE_CAP		0x08
+#define AS3935_DEFAULTS		0x3C
 #define AS3935_CALIBRATE	0x3D
 
 #define AS3935_READ_DATA	BIT(14)
@@ -62,7 +67,9 @@ struct as3935_state {
 	struct mutex lock;
 	struct delayed_work work;
 
+	unsigned long noise_tripped;
 	u32 tune_cap;
+	u32 nflwdth_reg;
 	u8 buffer[16]; /* 8-bit data + 56-bit padding + 64-bit timestamp */
 	u8 buf[2] ____cacheline_aligned;
 };
@@ -145,12 +152,29 @@ static ssize_t as3935_sensor_sensitivity_store(struct device *dev,
 	return len;
 }
 
+static ssize_t as3935_noise_level_tripped_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct as3935_state *st = iio_priv(dev_to_iio_dev(dev));
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = sprintf(buf, "%d\n", !time_after(jiffies, st->noise_tripped + HZ));
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
 static IIO_DEVICE_ATTR(sensor_sensitivity, S_IRUGO | S_IWUSR,
 	as3935_sensor_sensitivity_show, as3935_sensor_sensitivity_store, 0);
 
+static IIO_DEVICE_ATTR(noise_level_tripped, S_IRUGO,
+	as3935_noise_level_tripped_show, NULL, 0);
 
 static struct attribute *as3935_attributes[] = {
 	&iio_dev_attr_sensor_sensitivity.dev_attr.attr,
+	&iio_dev_attr_noise_level_tripped.dev_attr.attr,
 	NULL,
 };
 
@@ -246,7 +270,11 @@ static void as3935_event_work(struct work_struct *work)
 	case AS3935_EVENT_INT:
 		iio_trigger_poll_chained(st->trig);
 		break;
+	case AS3935_DISTURB_INT:
 	case AS3935_NOISE_INT:
+		mutex_lock(&st->lock);
+		st->noise_tripped = jiffies;
+		mutex_unlock(&st->lock);
 		dev_warn(&st->spi->dev, "noise level is too high\n");
 		break;
 	}
@@ -269,15 +297,14 @@ static irqreturn_t as3935_interrupt_handler(int irq, void *private)
 
 static void calibrate_as3935(struct as3935_state *st)
 {
-	/* mask disturber interrupt bit */
-	as3935_write(st, AS3935_INT, BIT(5));
-
+	as3935_write(st, AS3935_DEFAULTS, 0x96);
 	as3935_write(st, AS3935_CALIBRATE, 0x96);
 	as3935_write(st, AS3935_TUNE_CAP,
 		BIT(5) | (st->tune_cap / TUNE_CAP_DIV));
 
 	mdelay(2);
 	as3935_write(st, AS3935_TUNE_CAP, (st->tune_cap / TUNE_CAP_DIV));
+	as3935_write(st, AS3935_NFLWDTH, st->nflwdth_reg);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -370,6 +397,15 @@ static int as3935_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
+	ret = of_property_read_u32(np,
+			"ams,nflwdth", &st->nflwdth_reg);
+	if (!ret && st->nflwdth_reg > AS3935_NFLWDTH_MASK) {
+		dev_err(&spi->dev,
+			"invalid nflwdth setting of %d\n",
+			st->nflwdth_reg);
+		return -EINVAL;
+	}
+
 	indio_dev->dev.parent = &spi->dev;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->channels = as3935_channels;
@@ -384,6 +420,7 @@ static int as3935_probe(struct spi_device *spi)
 		return -ENOMEM;
 
 	st->trig = trig;
+	st->noise_tripped = jiffies - HZ;
 	trig->dev.parent = indio_dev->dev.parent;
 	iio_trigger_set_drvdata(trig, indio_dev);
 	trig->ops = &iio_interrupt_trigger_ops;
-- 
2.11.0
