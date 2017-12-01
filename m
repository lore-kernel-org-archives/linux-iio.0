Return-Path: <SRS0=zYSb=C5=redhat.com=javierm@kernel.org>
From: Javier Martinez Canillas <javierm@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javierm@redhat.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Hans de Goede <hdegoede@redhat.com>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: accel: bmc150: Add OF device ID table
Date: Fri,  1 Dec 2017 12:10:58 +0100
Message-Id: <20171201111058.13483-1-javierm@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

The I2C device ID table entries have the .driver_data field set, but they
are not used in the driver so weren't set in the OF device table entries.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/iio/accel/bmc150-accel-i2c.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index f85014fbaa12..8ffc308d5fd0 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -81,9 +81,21 @@ static const struct i2c_device_id bmc150_accel_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, bmc150_accel_id);
 
+static const struct of_device_id bmc150_accel_of_match[] = {
+	{ .compatible = "bosch,bmc150_accel" },
+	{ .compatible = "bosch,bmi055_accel" },
+	{ .compatible = "bosch,bma255" },
+	{ .compatible = "bosch,bma250e" },
+	{ .compatible = "bosch,bma222e" },
+	{ .compatible = "bosch,bma280" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, bmc150_accel_of_match);
+
 static struct i2c_driver bmc150_accel_driver = {
 	.driver = {
 		.name	= "bmc150_accel_i2c",
+		.of_match_table = bmc150_accel_of_match,
 		.acpi_match_table = ACPI_PTR(bmc150_accel_acpi_match),
 		.pm	= &bmc150_accel_pm_ops,
 	},
-- 
2.14.3
