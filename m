Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:6365 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbaCKVNa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 11 Mar 2014 17:13:30 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] iio: ak8975: Added ACPI enumeration
Date: Tue, 11 Mar 2014 14:15:56 -0700
Message-Id: <1394572557-8102-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1394572557-8102-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1394572557-8102-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added capability so that this device can be enumerated via ACPI.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index a55c94f..fe5e9c8 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -31,6 +31,7 @@
 #include <linux/bitops.h>
 #include <linux/gpio.h>
 #include <linux/of_gpio.h>
+#include <linux/acpi.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -476,6 +477,27 @@ static const struct iio_info ak8975_info = {
 	.driver_module = THIS_MODULE,
 };
 
+static const struct acpi_device_id ak_acpi_match[] = {
+	{"AK8975", 0},
+	{"AK8963", AK8963},
+	{"INVN6500", AK8963},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, ak_acpi_match);
+
+static char *ak8975_match_acpi_device(struct device *dev,
+							int *chipset)
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
@@ -483,7 +505,10 @@ static int ak8975_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	int eoc_gpio;
 	int err;
+	char *name = NULL;
 
+	if (id)
+		name = (char *) id->name;
 	/* Grab and set up the supplied GPIO. */
 	if (client->dev.platform_data)
 		eoc_gpio = *(int *)(client->dev.platform_data);
@@ -529,6 +554,13 @@ static int ak8975_probe(struct i2c_client *client,
 			dev_dbg(&client->dev,
 				"AK8975 driver is running in normal mode\n");
 	}
+	if (ACPI_HANDLE(&client->dev)) {
+		int chip_id;
+
+		name = ak8975_match_acpi_device(&client->dev, &chip_id);
+		if (chip_id > 0)
+			data->chipset = chip_id;
+	}
 
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
@@ -545,7 +577,7 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-
+	indio_dev->name = name;
 	err = iio_device_register(indio_dev);
 	if (err < 0)
 		goto exit_free_iio;
@@ -600,6 +632,7 @@ static struct i2c_driver ak8975_driver = {
 	.driver = {
 		.name	= "ak8975",
 		.of_match_table = ak8975_of_match,
+		.acpi_match_table = ACPI_PTR(ak_acpi_match),
 	},
 	.probe		= ak8975_probe,
 	.remove		= ak8975_remove,
-- 
1.7.11.7

