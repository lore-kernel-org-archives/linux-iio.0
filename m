Return-Path: <SRS0=N3n8=5L=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/2] Revert "iio: accel: bma180: Add ACPI enumeration support for BMA250E"
Date: Tue,  6 Jun 2017 22:35:37 +0200
Message-Id: <20170606203538.15250-2-hdegoede@redhat.com>
In-Reply-To: <20170606203538.15250-1-hdegoede@redhat.com>
References: <20170606203538.15250-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

This reverts commit 5333e88661f2079d5ca8b94690ac920976300de3.

The BMA250E is already handled by the bmc150-accel-i2c driver, which
supports the "E" variants of the BMA??? accelerometers better then the
bma180 driver.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bma180.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 17b7953..3d66948 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -14,7 +14,6 @@
  * BMA250: 7-bit I2C slave address 0x18 or 0x19
  */
 
-#include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
@@ -728,8 +727,6 @@ static const struct iio_trigger_ops bma180_trigger_ops = {
 static int bma180_probe(struct i2c_client *client,
 		const struct i2c_device_id *id)
 {
-	struct device *dev = &client->dev;
-	const struct acpi_device_id *acpi_id;
 	struct bma180_data *data;
 	struct iio_dev *indio_dev;
 	enum chip_ids chip;
@@ -742,17 +739,10 @@ static int bma180_probe(struct i2c_client *client,
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 	data->client = client;
-	if (dev->of_node) {
+	if (client->dev.of_node)
 		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
-	} else if (id) {
+	else
 		chip = id->driver_data;
-	} else {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id)
-			return -ENODEV;
-
-		chip = acpi_id->driver_data;
-	}
 	data->part_info = &bma180_part_info[chip];
 
 	ret = data->part_info->chip_config(data);
@@ -873,12 +863,6 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 #define BMA180_PM_OPS NULL
 #endif
 
-static const struct acpi_device_id bma180_acpi_match[] = {
-	{ "BMA250E", BMA250E },
-	{ }
-};
-MODULE_DEVICE_TABLE(acpi, bma180_acpi_match);
-
 static struct i2c_device_id bma180_ids[] = {
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
@@ -904,7 +888,6 @@ MODULE_DEVICE_TABLE(of, bma180_of_match);
 static struct i2c_driver bma180_driver = {
 	.driver = {
 		.name	= "bma180",
-		.acpi_match_table = ACPI_PTR(bma180_acpi_match),
 		.pm	= BMA180_PM_OPS,
 		.of_match_table = bma180_of_match,
 	},
-- 
2.9.4
