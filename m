Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Jonathan
 Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter
 Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Matt
 Ranostay <mranostay@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Martin Fuzzey
	<mfuzzey@parkeon.com>, Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>, Lucas De Marchi
	<lucas.demarchi@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>, Peter Rosin
	<peda@axentia.se>, Leonard Crestez <leonard.crestez@intel.com>, Gregor Boirie
	<gregor.boirie@parrot.com>
Subject: [PATCH v1 3/3] iio:imu:mpu6050: enhance mounting matrix support
Date: Wed, 20 Apr 2016 19:23:45 +0200
Message-ID: <09429500c3879ba07731ce170d0a2242a0399422.1461170293.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1461170293.git.gregor.boirie@parrot.com>
References: <cover.1461170293.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Add a new rotation matrix sysfs attribute compliant with IIO core
mounting matrix API.
Matrix is retrieved from "in_anglvel_mount_matrix" and
"in_accel_mount_matrix" sysfs attributes. It is declared into mpu6050 DTS
entry as a "mount-matrix" property.

Old interface is kept for backward userspace compatibility and may be
retrieved from legacy platform_data mechanism only.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 Documentation/ABI/testing/sysfs-bus-iio            |  2 ++
 .../devicetree/bindings/iio/imu/inv_mpu6050.txt    | 13 ++++++++
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c         | 36 ++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h          |  4 ++-
 include/linux/platform_data/invensense_mpu6050.h   |  5 ++-
 5 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index ba8df69..df44998 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -1516,6 +1516,8 @@ Description:
 What:           /sys/bus/iio/devices/iio:deviceX/mount_matrix
 What:           /sys/bus/iio/devices/iio:deviceX/in_mount_matrix
 What:           /sys/bus/iio/devices/iio:deviceX/out_mount_matrix
+What:           /sys/bus/iio/devices/iio:deviceX/in_anglvel_mount_matrix
+What:           /sys/bus/iio/devices/iio:deviceX/in_accel_mount_matrix
 KernelVersion:  4.6
 Contact:        linux-iio@vger.kernel.org
 Description:
diff --git a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
index e4d8f1c..a9fc11e 100644
--- a/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
+++ b/Documentation/devicetree/bindings/iio/imu/inv_mpu6050.txt
@@ -8,10 +8,23 @@ Required properties:
  - interrupt-parent : should be the phandle for the interrupt controller
  - interrupts : interrupt mapping for GPIO IRQ
 
+Optional properties:
+ - mount-matrix: an optional 3x3 mounting rotation matrix
+
+
 Example:
 	mpu6050@68 {
 		compatible = "invensense,mpu6050";
 		reg = <0x68>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <18 1>;
+		mount-matrix = "-0.984807753012208",  /* x0 */
+		               "0",                   /* y0 */
+		               "-0.173648177666930",  /* z0 */
+		               "0",                   /* x1 */
+		               "-1",                  /* y1 */
+		               "0",                   /* z1 */
+		               "-0.173648177666930",  /* x2 */
+		               "0",                   /* y2 */
+		               "0.984807753012208";   /* z2 */
 	};
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index d192953..482a249 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -600,6 +600,10 @@ inv_fifo_rate_show(struct device *dev, struct device_attribute *attr,
 /**
  * inv_attr_show() - calling this function will show current
  *                    parameters.
+ *
+ * Deprecated in favor of IIO mounting matrix API.
+ *
+ * See inv_get_mount_matrix()
  */
 static ssize_t inv_attr_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
@@ -644,6 +648,18 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static const struct iio_mount_matrix *
+inv_get_mount_matrix(const struct iio_dev *indio_dev,
+		     const struct iio_chan_spec *chan)
+{
+	return &((struct inv_mpu6050_state *)iio_priv(indio_dev))->orientation;
+}
+
+static const struct iio_chan_spec_ext_info inv_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_TYPE, inv_get_mount_matrix),
+	{ },
+};
+
 #define INV_MPU6050_CHAN(_type, _channel2, _index)                    \
 	{                                                             \
 		.type = _type,                                        \
@@ -660,6 +676,7 @@ static int inv_mpu6050_validate_trigger(struct iio_dev *indio_dev,
 				.shift = 0,                           \
 				.endianness = IIO_BE,                 \
 			     },                                       \
+		.ext_info = inv_ext_info,                             \
 	}
 
 static const struct iio_chan_spec inv_mpu_channels[] = {
@@ -692,14 +709,16 @@ static IIO_CONST_ATTR(in_accel_scale_available,
 					  "0.000598 0.001196 0.002392 0.004785");
 static IIO_DEV_ATTR_SAMP_FREQ(S_IRUGO | S_IWUSR, inv_fifo_rate_show,
 	inv_mpu6050_fifo_rate_store);
+
+/* Deprecated: kept for userspace backward compatibility. */
 static IIO_DEVICE_ATTR(in_gyro_matrix, S_IRUGO, inv_attr_show, NULL,
 	ATTR_GYRO_MATRIX);
 static IIO_DEVICE_ATTR(in_accel_matrix, S_IRUGO, inv_attr_show, NULL,
 	ATTR_ACCL_MATRIX);
 
 static struct attribute *inv_attributes[] = {
-	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,
-	&iio_dev_attr_in_accel_matrix.dev_attr.attr,
+	&iio_dev_attr_in_gyro_matrix.dev_attr.attr,  /* deprecated */
+	&iio_dev_attr_in_accel_matrix.dev_attr.attr, /* deprecated */
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
 	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
 	&iio_const_attr_in_accel_scale_available.dev_attr.attr,
@@ -779,9 +798,20 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	st->powerup_count = 0;
 	st->irq = irq;
 	st->map = regmap;
+
 	pdata = dev_get_platdata(dev);
-	if (pdata)
+	if (!pdata) {
+		result = of_iio_read_mount_matrix(dev, "mount-matrix",
+						  &st->orientation);
+		if (result) {
+			dev_err(dev, "Failed to retrieve mounting matrix %d\n",
+				result);
+			return result;
+		}
+	} else {
 		st->plat_data = *pdata;
+	}
+
 	/* power is turned on inside check chip type*/
 	result = inv_check_and_setup_chip(st);
 	if (result)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index e302a49..52d60cd 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -114,7 +114,8 @@ struct inv_mpu6050_hw {
  *  @hw:		Other hardware-specific information.
  *  @chip_type:		chip type.
  *  @time_stamp_lock:	spin lock to time stamp.
- *  @plat_data:		platform data.
+ *  @plat_data:		platform data (deprecated in favor of @orientation).
+ *  @orientation:	sensor chip orientation relative to main hardware.
  *  @timestamps:        kfifo queue to store time stamp.
  *  @map		regmap pointer.
  *  @irq		interrupt number.
@@ -131,6 +132,7 @@ struct inv_mpu6050_state {
 	struct i2c_client *mux_client;
 	unsigned int powerup_count;
 	struct inv_mpu6050_platform_data plat_data;
+	struct iio_mount_matrix orientation;
 	DECLARE_KFIFO(timestamps, long long, TIMESTAMP_FIFO_SIZE);
 	struct regmap *map;
 	int irq;
diff --git a/include/linux/platform_data/invensense_mpu6050.h b/include/linux/platform_data/invensense_mpu6050.h
index ad3aa7b..554b598 100644
--- a/include/linux/platform_data/invensense_mpu6050.h
+++ b/include/linux/platform_data/invensense_mpu6050.h
@@ -16,13 +16,16 @@
 
 /**
  * struct inv_mpu6050_platform_data - Platform data for the mpu driver
- * @orientation:	Orientation matrix of the chip
+ * @orientation:	Orientation matrix of the chip (deprecated in favor of
+ *			mounting matrix retrieved from device-tree)
  *
  * Contains platform specific information on how to configure the MPU6050 to
  * work on this platform.  The orientation matricies are 3x3 rotation matricies
  * that are applied to the data to rotate from the mounting orientation to the
  * platform orientation.  The values must be one of 0, 1, or -1 and each row and
  * column should have exactly 1 non-zero value.
+ *
+ * Deprecated in favor of mounting matrix retrieved from device-tree.
  */
 struct inv_mpu6050_platform_data {
 	__s8 orientation[9];
-- 
2.1.4
