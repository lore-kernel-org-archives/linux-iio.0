Return-Path: <SRS0=cLh2=CF=googlemail.com=chf.fritz@kernel.org>
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 3/3] iio: light: isl76683 add way to adjust irq threshold
Date: Tue,  7 Nov 2017 16:36:23 +0100
Message-Id: <1510068983-25769-4-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com>
References: <1510068983-25769-1-git-send-email-chf.fritz@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds sysfs read/write support for upper and lower irq
thresholds. So it's possible that only on certain lux ranges the
irq triggered measurement happens.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 .../ABI/testing/sysfs-bus-iio-light-isl76683       | 17 +++++++
 drivers/iio/light/isl76683.c                       | 58 ++++++++++++++++++++--
 2 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-isl76683

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-isl76683 b/Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
new file mode 100644
index 0000000..c7e08d7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-light-isl76683
@@ -0,0 +1,17 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_threshold_low
+Date:		November 2017
+KernelVersion:	4.15.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of lower threshold for the interrupt.
+		Reading returns 8-bit MSB data of a 16-bit threshold.
+		Writing 0...255 represents 8-bit MSB data of a 16-bit threshold.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_threshold_up
+Date:		November 2017
+KernelVersion:	4.15.0
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Raw value of upper threshold for the interrupt.
+		Reading returns 8-bit MSB data of a 16-bit threshold.
+		Writing 0...255 represents 8-bit MSB data of a 16-bit threshold.
diff --git a/drivers/iio/light/isl76683.c b/drivers/iio/light/isl76683.c
index b730276..889fb85 100644
--- a/drivers/iio/light/isl76683.c
+++ b/drivers/iio/light/isl76683.c
@@ -74,11 +74,14 @@ static const int isl76683_lux_ranges_available[] = {
 #define ISL76683_KOHM_MAX		1000
 #define ISL76683_INTPERS_DEFAULT	0x0
 #define ISL76683_THR_DEFAULT		0x7f
+#define ISL76683_THR_MAX		0xFF
 
 struct isl76683_chip {
 	enum isl76683_lux_range	luxrange;
 	int			external_resistor;
 	enum isl76683_dmode	photodiode;
+	int			threshold_up;
+	int			threshold_low;
 	struct i2c_client	*client;
 	struct regmap		*rmp;
 	struct completion	irq_complete;
@@ -159,13 +162,11 @@ static int isl76683_set_config(struct isl76683_chip *chip)
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_write(chip->rmp, ISL76683_REG_THR_HI,
-				ISL76683_THR_DEFAULT);
+	ret = regmap_write(chip->rmp, ISL76683_REG_THR_HI, chip->threshold_up);
 	if (ret < 0)
 		return ret;
 
-	ret = regmap_write(chip->rmp, ISL76683_REG_THR_LO,
-				ISL76683_THR_DEFAULT);
+	ret = regmap_write(chip->rmp, ISL76683_REG_THR_LO, chip->threshold_low);
 	if (ret < 0)
 		return ret;
 
@@ -415,11 +416,58 @@ static int isl76683_write_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+#define ISL76683_SYSFS_STORE(ident, _max)				\
+static ssize_t in_illuminance_##ident##_store(struct device *dev,	\
+					struct device_attribute *attr,	\
+					const char *buf, size_t len)	\
+{									\
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);		\
+	struct isl76683_chip *chip = iio_priv(indio_dev);		\
+	unsigned int val;						\
+	int ret;							\
+									\
+	if (kstrtouint(buf, 10, &val))					\
+		return -EINVAL;						\
+									\
+	if (val > _max)							\
+		return -EINVAL;						\
+									\
+	mutex_lock(&chip->lock);					\
+	chip->ident = val;						\
+	ret = isl76683_set_config(chip);				\
+	mutex_unlock(&chip->lock);					\
+									\
+	if (ret)							\
+		return -EIO;						\
+									\
+	return len;							\
+}
+
+ISL76683_SYSFS_STORE(threshold_low, ISL76683_THR_MAX)
+ISL76683_SYSFS_STORE(threshold_up, ISL76683_THR_MAX)
+
+#define ISL76683_SYSFS_SHOW(ident, show_val)				\
+static ssize_t in_illuminance_##ident##_show(struct device *dev,	\
+			struct device_attribute *attr, char *buf)	\
+{									\
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);		\
+	struct isl76683_chip *chip = iio_priv(indio_dev);		\
+									\
+	return snprintf(buf, PAGE_SIZE, "%i\n", show_val);		\
+}
+
+ISL76683_SYSFS_SHOW(threshold_up, chip->threshold_up)
+ISL76683_SYSFS_SHOW(threshold_low, chip->threshold_low)
+
 static IIO_CONST_ATTR(in_illuminance_hardwaregain_available,
 		ISL76683_LUXRANGE_STR);
+static IIO_DEVICE_ATTR_RW(in_illuminance_threshold_up, 0);
+static IIO_DEVICE_ATTR_RW(in_illuminance_threshold_low, 0);
 
 static struct attribute *isl76683_attributes[] = {
 	&iio_const_attr_in_illuminance_hardwaregain_available.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_threshold_up.dev_attr.attr,
+	&iio_dev_attr_in_illuminance_threshold_low.dev_attr.attr,
 	NULL
 };
 
@@ -535,6 +583,8 @@ static int isl76683_probe(struct i2c_client *client,
 	chip->luxrange = ISL76683_LUX_RANGE_DEFAULT;
 	chip->external_resistor = rs;
 	chip->photodiode = ISL76683_DIODE_DEFAULT;
+	chip->threshold_up = ISL76683_THR_DEFAULT;
+	chip->threshold_low = ISL76683_THR_DEFAULT;
 	chip->buffer_running = false;
 
 	chip->rmp = devm_regmap_init_i2c(client, &isl76683_regmap_config);
-- 
2.1.4
