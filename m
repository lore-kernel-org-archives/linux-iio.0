Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>, Irina Tirdea
	<irina.tirdea@intel.com>, Cristina Moraru <cristina.moraru09@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>, Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 5/6] iio:magnetometer:ak8975: mounting matrix support
Date: Wed, 2 Mar 2016 12:10:27 +0100
Message-ID: <9724fb59b280b973dc71b89b8cd47fe04de6a3ea.1456916271.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1456916271.git.gregor.boirie@parrot.com>
References: <cover.1456916271.git.gregor.boirie@parrot.com>
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
 .../bindings/iio/magnetometer/ak8975.txt           | 10 +++++
 drivers/iio/magnetometer/ak8975.c                  | 46 +++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

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
index 141954a..89a8ece 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -370,6 +370,7 @@ struct ak8975_data {
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
 	u8			cntl_cache;
+	const char		*matrix[9];
 };
 
 /*
@@ -698,6 +699,28 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
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
@@ -717,6 +740,12 @@ static const struct iio_info ak8975_info = {
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
@@ -786,6 +815,22 @@ static int ak8975_probe(struct i2c_client *client,
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
@@ -823,7 +868,6 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->dev.parent = &client->dev;
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
-	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 	return devm_iio_device_register(&client->dev, indio_dev);
-- 
2.1.4
