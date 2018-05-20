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
Subject: [PATCH 8/9] iio: gyro: bmg160: Add support for BSG1160 ACPI HID
Date: Sun, 20 May 2018 15:28:56 +0200
Message-Id: <20180520132857.8103-9-hdegoede@redhat.com>
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

This commit not only adds the BSG1160 HID to the bmg160 code, but it also
makes the i2c probe function check the client address for devices with a
BSG1160 HID and only bind to the one at address 0x68.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/gyro/bmg160_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_i2c.c b/drivers/iio/gyro/bmg160_i2c.c
index 90126a5a7663..2f72f41e33bb 100644
--- a/drivers/iio/gyro/bmg160_i2c.c
+++ b/drivers/iio/gyro/bmg160_i2c.c
@@ -15,9 +15,17 @@ static const struct regmap_config bmg160_regmap_i2c_conf = {
 static int bmg160_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
+	const struct acpi_device_id *acpi_id;
 	struct regmap *regmap;
+	struct device *dev = &client->dev;
 	const char *name = NULL;
 
+	/* The BSG1160 ACPI id describes multiple sensors, only bind to ours */
+	acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
+	if (acpi_id && acpi_id->driver_data &&
+	    client->addr != acpi_id->driver_data)
+		return -ENODEV;
+
 	regmap = devm_regmap_init_i2c(client, &bmg160_regmap_i2c_conf);
 	if (IS_ERR(regmap)) {
 		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
@@ -41,6 +49,7 @@ static int bmg160_i2c_remove(struct i2c_client *client)
 static const struct acpi_device_id bmg160_acpi_match[] = {
 	{"BMG0160", 0},
 	{"BMI055B", 0},
+	{"BSG1160", 0x68},
 	{},
 };
 
-- 
2.17.0
