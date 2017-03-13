Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37056
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752053AbdCMT7w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 15:59:52 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Irina Tirdea <irina.tirdea@intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 03/17] iio: magnetometer: bmc150_magn_i2c: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:03 -0300
Message-Id: <20170313195917.12190-4-javier@osg.samsung.com>
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

 drivers/iio/magnetometer/bmc150_magn_i2c.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/magnetometer/bmc150_magn_i2c.c b/drivers/iio/magnetometer/bmc150_magn_i2c.c
index ee05722587aa..6842cc5d9e59 100644
--- a/drivers/iio/magnetometer/bmc150_magn_i2c.c
+++ b/drivers/iio/magnetometer/bmc150_magn_i2c.c
@@ -63,9 +63,18 @@ static const struct i2c_device_id bmc150_magn_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, bmc150_magn_i2c_id);
 
+static const struct of_device_id bmc150_magn_of_match[] = {
+	{ .compatible = "bosch,bmc150_magn" },
+	{ .compatible = "bosch,bmc156_magn" },
+	{ .compatible = "bosch,bmm150_magn" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, bmc150_magn_of_match);
+
 static struct i2c_driver bmc150_magn_driver = {
 	.driver = {
 		.name	= "bmc150_magn_i2c",
+		.of_match_table = of_match_ptr(bmc150_magn_of_match),
 		.acpi_match_table = ACPI_PTR(bmc150_magn_acpi_match),
 		.pm	= &bmc150_magn_pm_ops,
 	},
-- 
2.9.3

