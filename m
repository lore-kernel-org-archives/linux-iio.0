Return-Path: <SRS0=sUvW=IH=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org
Subject: [PATCH 7/9] iio: accel: bmc150: Add support for BSG1160 ACPI HID
Date: Sun, 20 May 2018 15:28:55 +0200
Message-Id: <20180520132857.8103-8-hdegoede@redhat.com>
In-Reply-To: <20180520132857.8103-1-hdegoede@redhat.com>
References: <20180520132857.8103-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

The BSG1160 ACPI HID is a HID describing a sensor complex consisting of
3 sensors:

Accel: BMC150A at addr 0x11
Gyro: BMG160 at addr 0x68
Magneto: BMC150B at addr 0x13

A previous patch on this series has added the BSG1160 HID to the
i2c_acpi_multiple_devices_ids list, so that one i2c_client gets
instantiated per sensor.

This commit not only adds the BSG1160 HID to the bmc150 code, but it also
makes the i2c probe function check the client address for devices with a
BSG1160 HID and only bind to the one at address 0x11.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-i2c.c | 8 ++++++++
 drivers/iio/accel/bmc150-accel.h     | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index 8ffc308d5fd0..e0d7b507e397 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -31,13 +31,20 @@
 static int bmc150_accel_probe(struct i2c_client *client,
 			      const struct i2c_device_id *id)
 {
+	const struct acpi_device_id *acpi_id;
 	struct regmap *regmap;
+	struct device *dev = &client->dev;
 	const char *name = NULL;
 	bool block_supported =
 		i2c_check_functionality(client->adapter, I2C_FUNC_I2C) ||
 		i2c_check_functionality(client->adapter,
 					I2C_FUNC_SMBUS_READ_I2C_BLOCK);
 
+	/* The BSG1160 ACPI id describes multiple sensors, only bind to ours */
+	acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (acpi_id && acpi_id->driver_data == bsg1160 && client->addr != 0x11)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i2c(client, &bmc150_regmap_conf);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to initialize i2c regmap\n");
@@ -64,6 +71,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMA250E",	bma250e},
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
+	{"BSG1160",	bsg1160},
 	{"BOSC0200"},
 	{ },
 };
diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
index ae6118ae11b1..ac540a775d54 100644
--- a/drivers/iio/accel/bmc150-accel.h
+++ b/drivers/iio/accel/bmc150-accel.h
@@ -11,6 +11,7 @@ enum {
 	bma250e,
 	bma222e,
 	bma280,
+	bsg1160,
 };
 
 int bmc150_accel_core_probe(struct device *dev, struct regmap *regmap, int irq,
-- 
2.17.0
