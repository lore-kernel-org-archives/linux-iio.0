Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37166
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754164AbdCMUAf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:35 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 13/17] iio: magnetometer: mag3110: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:13 -0300
Message-Id: <20170313195917.12190-14-javier@osg.samsung.com>
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

 drivers/iio/magnetometer/mag3110.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index b4f643fb3b1e..06830358a175 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -441,9 +441,16 @@ static const struct i2c_device_id mag3110_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mag3110_id);
 
+static const struct of_device_id mag3110_of_match[] = {
+	{ .compatible = "fsl,mag3110" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mag3110_of_match);
+
 static struct i2c_driver mag3110_driver = {
 	.driver = {
 		.name	= "mag3110",
+		.of_match_table = of_match_ptr(mag3110_of_match),
 		.pm	= MAG3110_PM_OPS,
 	},
 	.probe = mag3110_probe,
-- 
2.9.3

