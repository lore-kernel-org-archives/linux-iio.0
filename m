Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a8-242.smtp-out.amazonses.com ([54.240.8.242]:41640 "EHLO
        a8-242.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752218AbdK2WbN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Nov 2017 17:31:13 -0500
From: Jeremy Cline <jeremy@jcline.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Hans de Goede <hdegoede@redhat.com>,
        Lars Kellogg-Stedman <lars@oddbit.com>,
        Steven Presser <steve@pressers.name>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jeremy@jcline.org>
Subject: [PATCH 2/2] iio: accel: bmc150: Check for a second ACPI device for BOSC0200
Date: Wed, 29 Nov 2017 22:31:12 +0000
Message-ID: <0100016009e7c30a-407c2980-d8d5-4506-ab47-d0fb2fed481d-000000@email.amazonses.com>
In-Reply-To: <20171129223016.17848-1-jeremy@jcline.org>
References: <20171129223016.17848-1-jeremy@jcline.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Some BOSC0200 acpi_device-s describe two accelerometers in a single ACPI
device. Check for a companion device and handle a second i2c_client
if it is present.

Signed-off-by: Jeremy Cline <jeremy@jcline.org>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 33 ++++++++++++++++++++++++++++++++-
 drivers/iio/accel/bmc150-accel.h     |  1 +
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index f85014fbaa12..c4557e18123c 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -31,6 +31,10 @@
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
+	int ret;
+	struct acpi_device *adev;
+	struct i2c_board_info board_info;
+	struct bmc150_accel_data *data;
 	struct regmap *regmap;
 	const char *name = NULL;
 	bool block_supported =
@@ -47,12 +51,39 @@ static int bmc150_accel_probe(struct i2c_client *client,
 	if (id)
 		name = id->name;
 
-	return bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
+	ret = bmc150_accel_core_probe(&client->dev, regmap, client->irq, name,
 				       block_supported);
+	if (ret)
+		return ret;
+
+	/*
+	 * Some BOSC0200 acpi_devices describe 2 accelerometers in a single ACPI
+	 * device, try instantiating a second i2c_client for an I2cSerialBusV2
+	 * ACPI resource with index 1.
+	 */
+	adev = ACPI_COMPANION(&client->dev);
+	if (adev && strcmp(acpi_device_hid(adev), "BOSC0200") == 0) {
+		data = i2c_get_clientdata(client);
+		memset(&board_info, 0, sizeof(board_info));
+		strlcpy(board_info.type, "bma250e", I2C_NAME_SIZE);
+		data->driver_priv = i2c_acpi_new_device(&client->dev,
+							1, &board_info);
+		/*
+		 * Don't check for bosc0200 == NULL since most BOSC0200 ACPI
+		 * devices describe only one i2c_client
+		 */
+	}
+
+	return ret;
 }
 
 static int bmc150_accel_remove(struct i2c_client *client)
 {
+	struct bmc150_accel_data *data = i2c_get_clientdata(client);
+
+	if (data->driver_priv)
+		i2c_unregister_device(data->driver_priv);
+
 	return bmc150_accel_core_remove(&client->dev);
 }
 
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index c38754452883..7f49a09b136f 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -47,6 +47,7 @@ struct bmc150_accel_data {
 	int ev_enable_state;
 	int64_t timestamp, old_timestamp; /* Only used in hw fifo mode. */
 	const struct bmc150_accel_chip_info *chip_info;
+	void *driver_priv;
 };
 
 struct regmap;
-- 
2.14.3

