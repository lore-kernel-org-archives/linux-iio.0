Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45595
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751222AbdCOEpe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 00:45:34 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH v2 01/17] iio: adc: ina2xx: Add OF device ID table
Date: Wed, 15 Mar 2017 01:44:49 -0300
Message-Id: <20170315044505.20660-2-javier@osg.samsung.com>
In-Reply-To: <20170315044505.20660-1-javier@osg.samsung.com>
References: <20170315044505.20660-1-javier@osg.samsung.com>
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

 drivers/iio/adc/ina2xx-adc.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
index 3263231276ca..db9838230257 100644
--- a/drivers/iio/adc/ina2xx-adc.c
+++ b/drivers/iio/adc/ina2xx-adc.c
@@ -28,6 +28,7 @@
 #include <linux/iio/sysfs.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
+#include <linux/of_device.h>
 #include <linux/regmap.h>
 #include <linux/util_macros.h>
 
@@ -635,6 +636,7 @@ static int ina2xx_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 	struct iio_buffer *buffer;
 	unsigned int val;
+	enum ina2xx_ids type;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
@@ -652,7 +654,11 @@ static int ina2xx_probe(struct i2c_client *client,
 		return PTR_ERR(chip->regmap);
 	}
 
-	chip->config = &ina2xx_config[id->driver_data];
+	if (client->dev.of_node)
+		type = (enum ina2xx_ids)of_device_get_match_data(&client->dev);
+	else
+		type = id->driver_data;
+	chip->config = &ina2xx_config[type];
 
 	mutex_init(&chip->state_lock);
 
@@ -726,9 +732,35 @@ static const struct i2c_device_id ina2xx_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ina2xx_id);
 
+static const struct of_device_id ina2xx_of_match[] = {
+	{
+		.compatible = "ti,ina219",
+		.data = (void *)ina219
+	},
+	{
+		.compatible = "ti,ina220",
+		.data = (void *)ina219
+	},
+	{
+		.compatible = "ti,ina226",
+		.data = (void *)ina226
+	},
+	{
+		.compatible = "ti,ina230",
+		.data = (void *)ina226
+	},
+	{
+		.compatible = "ti,ina231",
+		.data = (void *)ina226
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, ina2xx_of_match);
+
 static struct i2c_driver ina2xx_driver = {
 	.driver = {
 		   .name = KBUILD_MODNAME,
+		   .of_match_table = ina2xx_of_match,
 	},
 	.probe = ina2xx_probe,
 	.remove = ina2xx_remove,
-- 
2.9.3

