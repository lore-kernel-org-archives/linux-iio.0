Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37136
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754184AbdCMUAh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 16:00:37 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alison Schofield <amsfield22@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 15/17] iio: pressure: mpl3115: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:15 -0300
Message-Id: <20170313195917.12190-16-javier@osg.samsung.com>
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

 drivers/iio/pressure/mpl3115.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 525644a7442d..2eaef486a9bf 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -321,9 +321,16 @@ static const struct i2c_device_id mpl3115_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mpl3115_id);
 
+static const struct of_device_id mpl3115_of_match[] = {
+	{ .compatible = "fsl,mpl3115" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mpl3115_of_match);
+
 static struct i2c_driver mpl3115_driver = {
 	.driver = {
 		.name	= "mpl3115",
+		.of_match_table = of_match_ptr(mpl3115_of_match),
 		.pm	= MPL3115_PM_OPS,
 	},
 	.probe = mpl3115_probe,
-- 
2.9.3

