Return-Path: <ao2@ao2.it>
From: Antonio Ospite <ao2@ao2.it>
To: linux-iio@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/3] iio: accel: kxcjk-1013: rename is_smo8500_device to polling_mode
Date: Wed, 29 Apr 2015 11:01:50 +0200
Message-Id: <1430298111-20127-3-git-send-email-ao2@ao2.it>
In-Reply-To: <1430298111-20127-1-git-send-email-ao2@ao2.it>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
List-ID: <linux-iio@vger.kernel.org>

The purpose of the variable is to remember when an interrupt cannot be
requested and hence the driver must work in polling mode, so tell that
instead of mentioning the specific case when this is needed.

This makes the variable name to be still meaningful when some other
devices requiring this show up.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/accel/kxcjk-1013.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 5b7a860..eccec0e 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -108,7 +108,7 @@ struct kxcjk1013_data {
 	bool motion_trigger_on;
 	int64_t timestamp;
 	enum kx_chipset chipset;
-	bool is_smo8500_device;
+	bool polling_mode;
 };
 
 enum kxcjk1013_axis {
@@ -1140,7 +1140,7 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 
 static const char *kxcjk1013_match_acpi_device(struct device *dev,
 					       enum kx_chipset *chipset,
-					       bool *is_smo8500_device)
+					       bool *polling_mode)
 {
 	const struct acpi_device_id *id;
 
@@ -1148,7 +1148,7 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	if (!id)
 		return NULL;
 	if (strcmp(id->id, "SMO8500") == 0)
-		*is_smo8500_device = true;
+		*polling_mode = true;
 	*chipset = (enum kx_chipset)id->driver_data;
 
 	return dev_name(dev);
@@ -1163,7 +1163,7 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
 
 	if (!client)
 		return -EINVAL;
-	if (data->is_smo8500_device)
+	if (data->polling_mode)
 		return -ENOTSUPP;
 
 	dev = &client->dev;
@@ -1211,7 +1211,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	} else if (ACPI_HANDLE(&client->dev)) {
 		name = kxcjk1013_match_acpi_device(&client->dev,
 						   &data->chipset,
-						   &data->is_smo8500_device);
+						   &data->polling_mode);
 	} else
 		return -ENODEV;
 
-- 
2.1.4
