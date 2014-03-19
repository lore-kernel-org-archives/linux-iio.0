Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:28733 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757376AbaCSQxw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 19 Mar 2014 12:53:52 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-acpi@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [Patch v1 1/2] iio: ak8975 : Add AK8963 compatibility mode support
Date: Wed, 19 Mar 2014 09:56:06 -0700
Message-Id: <1395248167-16991-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

AK8963 and AK8975 use same register definitions, except the range
of X,Y,Z values. Added support of 8963 based on i2c_device_id.
Unfortunately there is no way to detect the type via registers,
both device registers return 0x48 as id of chipset.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/magnetometer/Kconfig  |  3 ++-
 drivers/iio/magnetometer/ak8975.c | 34 +++++++++++++++++++++++++++++-----
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
index d86d226..05a364c54 100644
--- a/drivers/iio/magnetometer/Kconfig
+++ b/drivers/iio/magnetometer/Kconfig
@@ -11,7 +11,8 @@ config AK8975
 	depends on GPIOLIB
 	help
 	  Say yes here to build support for Asahi Kasei AK8975 3-Axis
-	  Magnetometer.
+	  Magnetometer. This driver can also support AK8963, if i2c
+	  device name is identified as ak8963.
 
 	  To compile this driver as a module, choose M here: the module
 	  will be called ak8975.
diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 0542354..aa7682d 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -85,7 +85,14 @@
 #define AK8975_MAX_CONVERSION_TIMEOUT	500
 #define AK8975_CONVERSION_DONE_POLL_TIME 10
 #define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
-#define RAW_TO_GAUSS(asa) ((((asa) + 128) * 3000) / 256)
+#define RAW_TO_GAUSS_8975(asa) ((((asa) + 128) * 3000) / 256)
+#define RAW_TO_GAUSS_8963(asa) ((((asa) + 128) * 6000) / 256)
+
+/* Compatible Asahi Kasei Compass parts */
+enum asahi_compass_chipset {
+	AK8975,
+	AK8963,
+};
 
 /*
  * Per-instance context data for the device.
@@ -101,6 +108,7 @@ struct ak8975_data {
 	int			eoc_irq;
 	wait_queue_head_t	data_ready_queue;
 	unsigned long		flags;
+	enum asahi_compass_chipset chipset;
 };
 
 static const int ak8975_index_to_reg[] = {
@@ -272,9 +280,21 @@ static int ak8975_setup(struct i2c_client *client)
  * Since ASA doesn't change, we cache the resultant scale factor into the
  * device context in ak8975_setup().
  */
-	data->raw_to_gauss[0] = RAW_TO_GAUSS(data->asa[0]);
-	data->raw_to_gauss[1] = RAW_TO_GAUSS(data->asa[1]);
-	data->raw_to_gauss[2] = RAW_TO_GAUSS(data->asa[2]);
+	if (data->chipset == AK8963) {
+		/*
+		 * H range is +-8190 and magnetometer range is +-4912.
+		 * So HuT using the above explanation for 8975,
+		 * 4912/8190 = ~ 6/10.
+		 * So the Hadj should use 6/10 instead of 3/10.
+		 */
+		data->raw_to_gauss[0] = RAW_TO_GAUSS_8963(data->asa[0]);
+		data->raw_to_gauss[1] = RAW_TO_GAUSS_8963(data->asa[1]);
+		data->raw_to_gauss[2] = RAW_TO_GAUSS_8963(data->asa[2]);
+	} else {
+		data->raw_to_gauss[0] = RAW_TO_GAUSS_8975(data->asa[0]);
+		data->raw_to_gauss[1] = RAW_TO_GAUSS_8975(data->asa[1]);
+		data->raw_to_gauss[2] = RAW_TO_GAUSS_8975(data->asa[2]);
+	}
 
 	return 0;
 }
@@ -499,6 +519,9 @@ static int ak8975_probe(struct i2c_client *client,
 	data->eoc_gpio = eoc_gpio;
 	data->eoc_irq = 0;
 
+	data->chipset = (enum asahi_compass_chipset)(id->driver_data);
+	dev_dbg(&client->dev, "Asahi compass chip %s\n", id->name);
+
 	/* Perform some basic start-of-day setup of the device. */
 	err = ak8975_setup(client);
 	if (err < 0) {
@@ -551,7 +574,8 @@ static int ak8975_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ak8975_id[] = {
-	{"ak8975", 0},
+	{"ak8975", AK8975},
+	{"ak8963", AK8963},
 	{}
 };
 
-- 
1.7.11.7

