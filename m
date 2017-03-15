Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45697
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751959AbdCOEqH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 00:46:07 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Slawomir Stepien <sst@poczta.fm>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yong Li <sdliyong@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH v2 10/17] iio: light: apds9960: Add OF device ID table
Date: Wed, 15 Mar 2017 01:44:58 -0300
Message-Id: <20170315044505.20660-11-javier@osg.samsung.com>
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

 drivers/iio/light/apds9960.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/apds9960.c b/drivers/iio/light/apds9960.c
index a4304edc3e0f..90bc98df362b 100644
--- a/drivers/iio/light/apds9960.c
+++ b/drivers/iio/light/apds9960.c
@@ -1122,9 +1122,16 @@ static const struct i2c_device_id apds9960_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, apds9960_id);
 
+static const struct of_device_id apds9960_of_match[] = {
+	{ .compatible = "avago,apds9960" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, apds9960_of_match);
+
 static struct i2c_driver apds9960_driver = {
 	.driver = {
 		.name	= APDS9960_DRV_NAME,
+		.of_match_table = apds9960_of_match,
 		.pm	= &apds9960_pm_ops,
 	},
 	.probe		= apds9960_probe,
-- 
2.9.3

