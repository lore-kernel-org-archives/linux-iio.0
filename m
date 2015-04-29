Return-Path: <ao2@ao2.it>
From: Antonio Ospite <ao2@ao2.it>
To: linux-iio@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>,
	Jonathan Cameron <jic23@kernel.org>,
	Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 3/3] iio: accel: kxcjk-1013: add some blank lines for readability
Date: Wed, 29 Apr 2015 11:01:51 +0200
Message-Id: <1430298111-20127-4-git-send-email-ao2@ao2.it>
In-Reply-To: <1430298111-20127-1-git-send-email-ao2@ao2.it>
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>
List-ID: <linux-iio@vger.kernel.org>

Some extra blank lines between if checks don't hurt and improve
readability.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Bastien Nocera <hadess@hadess.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/accel/kxcjk-1013.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index eccec0e..2519692 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1147,8 +1147,10 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	id = acpi_match_device(dev->driver->acpi_match_table, dev);
 	if (!id)
 		return NULL;
+
 	if (strcmp(id->id, "SMO8500") == 0)
 		*polling_mode = true;
+
 	*chipset = (enum kx_chipset)id->driver_data;
 
 	return dev_name(dev);
@@ -1163,6 +1165,7 @@ static int kxcjk1013_gpio_probe(struct i2c_client *client,
 
 	if (!client)
 		return -EINVAL;
+
 	if (data->polling_mode)
 		return -ENOTSUPP;
 
-- 
2.1.4
