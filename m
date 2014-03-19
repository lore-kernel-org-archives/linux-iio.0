Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Patch v1 2/2] iio: ak8975: Added ACPI enumeration
Date: Wed, 19 Mar 2014 09:56:07 -0700
Message-Id: <1395248167-16991-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1395248167-16991-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1395248167-16991-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Added capability so that this device can be enumerated via ACPI.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 40 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index aa7682d..09ea5c4 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -475,6 +476,27 @@ static const struct iio_info ak8975_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct acpi_device_id ak_acpi_match[] = {
+	{"AK8975", AK8975},
+	{"AK8963", AK8963},
+	{"INVN6500", AK8963},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
+
+static char *ak8975_match_acpi_device(struct device *dev,
+				enum asahi_compass_chipset *chipset)
+{
+	const struct acpi_device_id *id;
+
+	id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (!id)
+		return NULL;
+	*chipset = (int)id->driver_data;
+
+	return (char *)dev_name(dev);
+}
+
 static int ak8975_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
@@ -482,6 +504,7 @@ static int ak8975_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int eoc_gpio;
 	int err;
+	char *name = NULL;
 
 	/* Grab and set up the supplied GPIO. */
 	if (client->dev.platform_data)
@@ -519,8 +542,18 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_gpio = eoc_gpio;
 	data->eoc_irq = 0;
 
-	data->chipset = (enum asahi_compass_chipset)(id->driver_data);
-	dev_dbg(&client->dev, "Asahi compass chip %s\n", id->name);
+	/* id will be NULL when enumerated via ACPI */
+	if (id) {
+		data->chipset =
+			(enum asahi_compass_chipset)(id->driver_data);
+		name = (char *) id->name;
+	} else if (ACPI_HANDLE(&client->dev))
+		name = ak8975_match_acpi_device(&client->dev, &data->chipset);
+	else {
+		err = -ENOSYS;
+		goto exit_free_iio;
+	}
+	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
@@ -537,7 +570,7 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-
+	indio_dev->name = name;
 	err = iio_device_register(indio_dev);
 	if (err < 0)
 		goto exit_free_iio;
@@ -592,6 +625,7 @@ static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
 		.of_match_table = ak8975_of_match,
+		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
 	.probe		= ak8975_probe,
 	.remove		= ak8975_remove,
-- 
1.7.11.7
