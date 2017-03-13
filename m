Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37094
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753717AbdCMUAI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:08 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Amitoj Kaur Chawla <amitoj1606@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 06/17] iio: light: tsl2563: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:06 -0300
Message-Id: <20170313195917.12190-7-javier@osg.samsung.com>
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

 drivers/iio/light/tsl2563.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/iio/light/tsl2563.c b/drivers/iio/light/tsl2563.c
index 04598ae993d4..9e5cd09a329f 100644
--- a/drivers/iio/light/tsl2563.c
+++ b/drivers/iio/light/tsl2563.c
@@ -884,9 +884,19 @@ static const struct i2c_device_id tsl2563_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tsl2563_id);
 
+static const struct of_device_id tsl2563_of_match[] = {
+	{ .compatible = "amstaos,tsl2560" },
+	{ .compatible = "amstaos,tsl2561" },
+	{ .compatible = "amstaos,tsl2562" },
+	{ .compatible = "amstaos,tsl2563" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, tsl2563_of_match);
+
 static struct i2c_driver tsl2563_i2c_driver = {
 	.driver = {
 		.name	 = "tsl2563",
+		.of_match_table = of_match_ptr(tsl2563_of_match),
 		.pm	= TSL2563_PM_OPS,
 	},
 	.probe		= tsl2563_probe,
-- 
2.9.3

