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
Subject: [PATCH v1 2/3] iio:ak8975: add mounting matrix support
Date: Wed, 20 Apr 2016 19:23:44 +0200
Message-ID: <43de59ea1cc5ba93bebd721b761da4749956afa0.1461170293.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1461170293.git.gregor.boirie@parrot.com>
References: <cover.1461170293.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Expose a rotation matrix to indicate userspace the chip orientation with
respect to the overall hardware system.
Matrix is retrieved from "in_mount_matrix". It is declared into ak8975 DTS
entry as a "mount-matrix" property.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 .../bindings/iio/magnetometer/ak8975.txt           | 10 +++++++
 drivers/iio/magnetometer/ak8975.c                  | 34 +++++++++++++++++++---
 include/linux/iio/magnetometer/ak8975.h            | 16 ++++++++++
 3 files changed, 56 insertions(+), 4 deletions(-)
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
index a2aac50..dbf0661 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -40,7 +40,8 @@
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-#include <linux/regulator/consumer.h>
+
+#include <linux/iio/magnetometer/ak8975.h>
 
 /*
  * Register definitions, as well as various shifts and masks to get at the
@@ -376,6 +377,7 @@ struct ak8975_data {
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
 	u8			cntl_cache;
+	struct iio_mount_matrix orientation;
 	struct regulator	*vdd;
 };
 
@@ -726,6 +728,18 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 	return -EINVAL;
 }
 
+static const struct iio_mount_matrix *
+ak8975_get_mount_matrix(const struct iio_dev *indio_dev,
+			const struct iio_chan_spec *chan)
+{
+	return &((struct ak8975_data *)iio_priv(indio_dev))->orientation;
+}
+
+static const struct iio_chan_spec_ext_info ak8975_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_DIR, ak8975_get_mount_matrix),
+	{ },
+};
+
 #define AK8975_CHANNEL(axis, index)					\
 	{								\
 		.type = IIO_MAGN,					\
@@ -740,7 +754,8 @@ static int ak8975_read_raw(struct iio_dev *indio_dev,
 			.realbits = 16,					\
 			.storagebits = 16,				\
 			.endianness = IIO_CPU				\
-		}							\
+		},							\
+		.ext_info = ak8975_ext_info,				\
 	}
 
 static const struct iio_chan_spec ak8975_channels[] = {
@@ -837,10 +852,12 @@ static int ak8975_probe(struct i2c_client *client,
 	int err;
 	const char *name = NULL;
 	enum asahi_compass_chipset chipset;
+	const struct ak8975_platform_data *pdata =
+		dev_get_platdata(&client->dev);
 
 	/* Grab and set up the supplied GPIO. */
-	if (client->dev.platform_data)
-		eoc_gpio = *(int *)(client->dev.platform_data);
+	if (pdata)
+		eoc_gpio = pdata->eoc_gpio;
 	else if (client->dev.of_node)
 		eoc_gpio = of_get_gpio(client->dev.of_node, 0);
 	else
@@ -874,6 +891,15 @@ static int ak8975_probe(struct i2c_client *client,
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
index 0000000..c840095
--- /dev/null
+++ b/include/linux/iio/magnetometer/ak8975.h
@@ -0,0 +1,16 @@
+#ifndef __IIO_MAGNETOMETER_AK8975_H__
+#define __IIO_MAGNETOMETER_AK8975_H__
+
+#include <linux/iio/iio.h>
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
