Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37154
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754186AbdCMUAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:37 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Giorgio Dal Molin <giorgio.nicole@arcor.de>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Bhumika Goyal <bhumirks@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 12/17] iio: adc: ti-ads1015: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:12 -0300
Message-Id: <20170313195917.12190-13-javier@osg.samsung.com>
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

 drivers/iio/adc/ti-ads1015.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 422b314f5a3f..3302270ab6b1 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -15,6 +15,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/init.h>
 #include <linux/i2c.h>
 #include <linux/regmap.h>
@@ -55,7 +56,7 @@
 #define ADS1015_DEFAULT_DATA_RATE	4
 #define ADS1015_DEFAULT_CHAN		0
 
-enum {
+enum chip_ids {
 	ADS1015,
 	ADS1115,
 };
@@ -578,6 +579,7 @@ static int ads1015_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct ads1015_data *data;
 	int ret;
+	enum chip_ids chip;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
 	if (!indio_dev)
@@ -593,7 +595,11 @@ static int ads1015_probe(struct i2c_client *client,
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	switch (id->driver_data) {
+	if (client->dev.of_node)
+		chip = (enum chip_ids)of_device_get_match_data(&client->dev);
+	else
+		chip = id->driver_data;
+	switch (chip) {
 	case ADS1015:
 		indio_dev->channels = ads1015_channels;
 		indio_dev->num_channels = ARRAY_SIZE(ads1015_channels);
@@ -698,9 +704,23 @@ static const struct i2c_device_id ads1015_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ads1015_id);
 
+static const struct of_device_id ads1015_of_match[] = {
+	{
+		.compatible = "ti,ads1015",
+		.data = (void *)ADS1015
+	},
+	{
+		.compatible = "ti,ads1115",
+		.data = (void *)ADS1115
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ads1015_of_match);
+
 static struct i2c_driver ads1015_driver = {
 	.driver = {
 		.name = ADS1015_DRV_NAME,
+		.of_match_table = of_match_ptr(ads1015_of_match),
 		.pm = &ads1015_pm_ops,
 	},
 	.probe		= ads1015_probe,
-- 
2.9.3

