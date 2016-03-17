Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: Rob Herring <robh+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter
 Meerwald <pmeerw@pmeerw.net>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Irina Tirdea <irina.tirdea@intel.com>, Cristina Moraru
	<cristina.moraru09@gmail.com>, Daniel Baluta <daniel.baluta@intel.com>, Julia
 Lawall <Julia.Lawall@lip6.fr>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v3 2/3] iio:magnetometer:ak8975: mounting matrix support
Date: Thu, 17 Mar 2016 17:43:27 +0100
Message-ID: <a1efa2b83719dc3898c39a5886b7678892e7de3b.1458231723.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1458231723.git.gregor.boirie@parrot.com>
References: <cover.1458231723.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Expose a rotation matrix to indicate userspace the chip placement with
respect to the overall hardware system. This is needed to adjust
coordinates sampled from a magnetometer chip when its position deviates
from the main hardware system.

Final coordinates computation is delegated to userspace since:
* computation may involve floating point arithmetics ;
* it allows an application to combine adjustments with arbitrary
  transformations.

This 3 dimentional space rotation matrix is expressed as 3x3 array of
strings to support floating point numbers. It may be retrieved from a
"in_magn_matrix" sysfs attribute file. It is declared into ak8975 DTS
entry as a "matrix" property.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-ak8975     | 46 ++++++++++++++++++++++
 .../bindings/iio/magnetometer/ak8975.txt           | 10 +++++
 drivers/iio/magnetometer/ak8975.c                  | 46 +++++++++++++++++++++-
 3 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-ak8975

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-ak8975 b/Documentation/ABI/testing/sysfs-bus-iio-ak8975
new file mode 100644
index 0000000..fa92ee1
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-ak8975
@@ -0,0 +1,46 @@
+What:           /sys/bus/iio/devices/iio:deviceX/in_magn_matrix
+KernelVersion:  4.6
+Contact:        linux-iio@vger.kernel.org
+Description:
+		Mounting matrix for magnetometer sensors. This is a rotation
+		matrix which informs userspace about sensor chip's orientation
+		relative to the main hardware it is mounted on.
+		More specifically, main hardware orientation is defined with
+		respect to the local earth geomagnetic reference frame where :
+		* Y is in the ground plane and positive towards magnetic North ;
+		* X is in the ground plane, perpendicular to the North axis and
+		  positive towards the East ;
+		* Z is perpendicular to the ground plane and positive upwards.
+
+		Sensor orientation is defined with respect to the main hardware
+		reference frame. Given that the rotation matrix is defined in a
+		board specific way (platform data and / or device-tree), the
+		main hardware reference frame definition is left to the
+		implementor's choice.
+		As an examplary guideline, one can consider that for a hand-held
+		device, a 'natural' orientation would be 'front facing camera at
+		the top'. The main hardware reference frame could then be
+		described as :
+		* Y is in the plane of the screen and is positive towards the
+		  top of the screen ;
+		* X is in the plane of the screen, perpendicular to Y axis, and
+		  positive towards the right hand side of the screen ;
+		* Z is perpendicular to the screen plane and positive out of the
+		  screen.
+		Another example for a quadrotor UAV might be :
+		* Y is in the plane of the propellers is positive towards the
+		  front-view camera;
+		* X is in the plane of the propellers, perpendicular to Y axis,
+		  and positive towards the starboard side of the UAV ;
+		* Z is perpendicular to propellers plane and positive upwards.
+
+		Applications should apply this rotation matrix to samples so
+		that when main hardware reference frame is aligned onto local
+		earth geomagnetic reference frame, then sensor chip reference
+		frame is also perfectly aligned with it.
+
+		Matrix is a 3x3 unitary matrix and typically looks like
+		[0, 1, 0; 1, 0, 0; 0, 0, -1]. A missing in_magn_matrix sysfs
+		entry means sensor chip and main hardware are perfectly aligned
+		with each other. It would be identical to exposing the identity
+		matrix [1, 0, 0; 0, 1, 0; 0, 0, 1].
diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
index 34a3206..f936f86 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
@@ -9,6 +9,7 @@ Optional properties:
 
   - gpios : should be device tree identifier of the magnetometer DRDY pin
   - vdd-supply: an optional regulator that needs to be on to provide VDD
+  - matrix: an optional 3x3 mounting rotation matrix
 
 Example:
 
@@ -17,4 +18,13 @@ ak8975@0c {
         reg = <0x0c>;
         gpios = <&gpj0 7 0>;
         vdd-supply = <&ldo_3v3_gnss>;
+        matrix = "-0.984807753012208",  /* x0 */
+                 "0",                   /* y0 */
+                 "-0.173648177666930",  /* z0 */
+                 "0",                   /* x1 */
+                 "-1",                  /* y1 */
+                 "0",                   /* z1 */
+                 "-0.173648177666930",  /* x2 */
+                 "0",                   /* y2 */
+                 "0.984807753012208";   /* z2 */
 };
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 48d127a..3814a6a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -370,6 +370,7 @@ struct ak8975_data {
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
 	u8			cntl_cache;
+	const char		*matrix[9];
 	struct regulator	*vdd;
 };
 
@@ -714,6 +715,28 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static ssize_t ak8975_show_matrix(struct device *dev,
+				  struct device_attribute *attr,
+				  char *buf)
+{
+	const struct ak8975_data *data = iio_priv(dev_to_iio_dev(dev));
+	const char * const *m = data->matrix;
+
+	return sprintf(buf, "%s, %s, %s; %s, %s, %s; %s, %s, %s\n",
+		       m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);
+}
+
+static IIO_DEVICE_ATTR(in_magn_matrix, S_IRUGO, ak8975_show_matrix, NULL, -1);
+
+static struct attribute *ak8975_attrs[] = {
+	&iio_dev_attr_in_magn_matrix.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ak8975_attrs_group = {
+	.attrs = ak8975_attrs
+};
+
 #define AK8975_CHANNEL(axis, index)					\
 	{								\
 		.type = IIO_MAGN,					\
@@ -733,6 +756,12 @@ static const struct iio_info ak8975_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct iio_info ak8975_matrix_info = {
+	.read_raw = &ak8975_read_raw,
+	.attrs = &ak8975_attrs_group,
+	.driver_module = THIS_MODULE,
+};
+
 static const struct acpi_device_id ak_acpi_match[] = {
 	{"AK8975", AK8975},
 	{"AK8963", AK8963},
@@ -802,6 +831,22 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_gpio = eoc_gpio;
 	data->eoc_irq = 0;
 
+	/*
+	 * Rotation matrix is expressed as an array of 3x3 strings to be able
+	 * to represent floating point numbers.
+	 */
+	err = of_property_read_string_array(client->dev.of_node, "matrix",
+					    data->matrix,
+					    ARRAY_SIZE(data->matrix));
+	if (err == ARRAY_SIZE(data->matrix))
+		indio_dev->info = &ak8975_matrix_info;
+	else if (err == -EINVAL)
+		indio_dev->info = &ak8975_info;
+	else if (err >= 0)
+		return -EINVAL;
+	else
+		return err;
+
 	/* id will be NULL when enumerated via ACPI */
 	if (id) {
 		chipset = (enum asahi_compass_chipset)(id->driver_data);
@@ -844,7 +889,6 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
-	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-- 
2.1.4
