Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:27016 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751757AbcDHOLH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Apr 2016 10:11:07 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <mranostay@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Varka Bhadram <varkabhadram@gmail.com>,
	Adriana Reus <adriana.reus@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Julia Lawall <Julia.Lawall@lip6.fr>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 2/3] iio:ak8975: add mounting matrix support
Date: Fri, 8 Apr 2016 16:12:04 +0200
Message-ID: <443cbafb38dc5ce38cbb7753aa6a4230d7188df9.1460113510.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1460113510.git.gregor.boirie@parrot.com>
References: <cover.1460113510.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Expose a rotation matrix to indicate userspace the chip orientation with
respect to the overall hardware system.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 .../bindings/iio/magnetometer/ak8975.txt           | 10 ++++++
 drivers/iio/magnetometer/ak8975.c                  | 40 ++++++++++++++++++++--
 include/linux/iio/magnetometer/ak8975.h            | 16 +++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/iio/magnetometer/ak8975.h

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
index 34a3206..e1e7dd32 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
+++ b/Documentation/devicetree/bindings/iio/magnetometer/ak8975.txt
@@ -9,6 +9,7 @@ Optional properties:
 
   - gpios : should be device tree identifier of the magnetometer DRDY pin
   - vdd-supply: an optional regulator that needs to be on to provide VDD
+  - mount-matrix: an optional 3x3 mounting rotation matrix
 
 Example:
 
@@ -17,4 +18,13 @@ ak8975@0c {
         reg = <0x0c>;
         gpios = <&gpj0 7 0>;
         vdd-supply = <&ldo_3v3_gnss>;
+        mount-matrix = "-0.984807753012208",  /* x0 */
+                       "0",                   /* y0 */
+                       "-0.173648177666930",  /* z0 */
+                       "0",                   /* x1 */
+                       "-1",                  /* y1 */
+                       "0",                   /* z1 */
+                       "-0.173648177666930",  /* x2 */
+                       "0",                   /* y2 */
+                       "0.984807753012208";   /* z2 */
 };
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 48d127a..ec3f27a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -36,6 +36,9 @@
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+
+#include <linux/iio/magnetometer/ak8975.h>
+
 /*
  * Register definitions, as well as various shifts and masks to get at the
  * individual fields of the registers.
@@ -370,6 +373,7 @@ struct ak8975_data {
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
 	u8			cntl_cache;
+	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
 };
 
@@ -714,6 +718,27 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static ssize_t ak8975_show_orientation(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	const struct ak8975_data *data = iio_priv(dev_to_iio_dev(dev));
+
+	return iio_show_mount_matrix(&data->orientation, buf);
+}
+
+static IIO_DEV_ATTR_MOUNT_MATRIX(in_magn_mount_matrix, ak8975_show_orientation,
+				 -1);
+
+static struct attribute *ak8975_attrs[] = {
+	&iio_dev_attr_in_magn_mount_matrix.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ak8975_attrs_group = {
+	.attrs = ak8975_attrs,
+};
+
 #define AK8975_CHANNEL(axis, index)					\
 	{								\
 		.type = IIO_MAGN,					\
@@ -730,6 +755,7 @@ static const struct iio_chan_spec ak8975_channels[] = {
 
 static const struct iio_info ak8975_info = {
 	.read_raw = &ak8975_read_raw,
+	.attrs = &ak8975_attrs_group,
 	.driver_module = THIS_MODULE,
 };
 
@@ -765,10 +791,11 @@ static int ak8975_probe(struct i2c_client *client,
 	int err;
 	const char *name = NULL;
 	enum asahi_compass_chipset chipset;
+	const struct ak8975_platform_data *pdata = client->dev.platform_data;
 
 	/* Grab and set up the supplied GPIO. */
-	if (client->dev.platform_data)
-		eoc_gpio = *(int *)(client->dev.platform_data);
+	if (pdata)
+		eoc_gpio = pdata->eoc_gpio;
 	else if (client->dev.of_node)
 		eoc_gpio = of_get_gpio(client->dev.of_node, 0);
 	else
@@ -802,6 +829,15 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_gpio = eoc_gpio;
 	data->eoc_irq = 0;
 
+	if (!pdata) {
+		err = of_iio_read_mount_matrix(&client->dev,
+					       "mount-matrix",
+					       &data->orientation);
+		if (err)
+			return err;
+	} else
+		data->orientation = pdata->orientation;
+
 	/* id will be NULL when enumerated via ACPI */
 	if (id) {
 		chipset = (enum asahi_compass_chipset)(id->driver_data);
diff --git a/include/linux/iio/magnetometer/ak8975.h b/include/linux/iio/magnetometer/ak8975.h
new file mode 100644
index 0000000..52947d7
--- /dev/null
+++ b/include/linux/iio/magnetometer/ak8975.h
@@ -0,0 +1,16 @@
+#ifndef __IIO_MAGNETOMETER_AK8975_H__
+#define __IIO_MAGNETOMETER_AK8975_H__
+
+#include <linux/iio/sysfs.h>
+
+/**
+ * struct ak8975_platform_data - AK8975 magnetometer driver platform data
+ * @eoc_gpio:    data ready event gpio
+ * @orientation: mounting matrix relative to main hardware
+ */
+struct ak8975_platform_data {
+	int                     eoc_gpio;
+	struct iio_mount_matrix orientation;
+};
+
+#endif
-- 
2.1.4

