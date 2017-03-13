Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37114
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753929AbdCMUAQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:16 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Crestez Dan Leonard <leonard.crestez@intel.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 08/17] iio: imu: inv_mpu6050: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:08 -0300
Message-Id: <20170313195917.12190-9-javier@osg.samsung.com>
In-Reply-To: <20170313195917.12190-1-javier@osg.samsung.com>
References: <20170313195917.12190-1-javier@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 2c3f8964a3ea..a7e0547e4413 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -17,6 +17,7 @@
 #include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include "inv_mpu_iio.h"
 
 static const struct regmap_config inv_mpu_regmap_config = {
@@ -101,7 +102,10 @@ static int inv_mpu_probe(struct i2c_client *client,
 				     I2C_FUNC_SMBUS_I2C_BLOCK))
 		return -EOPNOTSUPP;
 
-	if (id) {
+	if (client->dev.of_node) {
+		chip_type = (int)of_device_get_match_data(&client->dev);
+		name = client->name;
+	} else if (id) {
 		chip_type = (int)id->driver_data;
 		name = id->name;
 	} else if (ACPI_HANDLE(&client->dev)) {
@@ -176,6 +180,27 @@ static const struct i2c_device_id inv_mpu_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, inv_mpu_id);
 
+static const struct of_device_id inv_of_match[] = {
+	{
+		.compatible = "invensense,mpu6050",
+		.data = (void *)INV_MPU6050
+	},
+	{
+		.compatible = "invensense,mpu6500",
+		.data = (void *)INV_MPU6500
+	},
+	{
+		.compatible = "invensense,mpu9150",
+		.data = (void *)INV_MPU9150
+	},
+	{
+		.compatible = "invensense,icm20608",
+		.data = (void *)INV_ICM20608
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, inv_of_match);
+
 static const struct acpi_device_id inv_acpi_match[] = {
 	{"INVN6500", INV_MPU6500},
 	{ },
@@ -188,6 +213,7 @@ static struct i2c_driver inv_mpu_driver = {
 	.remove		=	inv_mpu_remove,
 	.id_table	=	inv_mpu_id,
 	.driver = {
+		.of_match_table = of_match_ptr(inv_of_match),
 		.acpi_match_table = ACPI_PTR(inv_acpi_match),
 		.name	=	"inv-mpu6050-i2c",
 		.pm     =       &inv_mpu_pmops,
-- 
2.9.3

