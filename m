Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37101
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753661AbdCMUAG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:06 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Marek Vasut <marex@denx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 07/17] iio: pressure: hp03: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:07 -0300
Message-Id: <20170313195917.12190-8-javier@osg.samsung.com>
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

 drivers/iio/pressure/hp03.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/hp03.c b/drivers/iio/pressure/hp03.c
index ac76515d5d49..0f3824cf1278 100644
--- a/drivers/iio/pressure/hp03.c
+++ b/drivers/iio/pressure/hp03.c
@@ -297,9 +297,16 @@ static const struct i2c_device_id hp03_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, hp03_id);
 
+static const struct of_device_id hp03_of_match[] = {
+	{ .compatible = "hoperf,hp03" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, hp03_of_match);
+
 static struct i2c_driver hp03_driver = {
 	.driver = {
 		.name	= "hp03",
+		.of_match_table = of_match_ptr(hp03_of_match),
 	},
 	.probe		= hp03_probe,
 	.remove		= hp03_remove,
-- 
2.9.3

