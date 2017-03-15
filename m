Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45639
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751676AbdCOEpr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 00:45:47 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 05/17] iio: light: us5182d: Add OF device ID table
Date: Wed, 15 Mar 2017 01:44:53 -0300
Message-Id: <20170315044505.20660-6-javier@osg.samsung.com>
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

 drivers/iio/light/us5182d.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/light/us5182d.c b/drivers/iio/light/us5182d.c
index 18cf2e29e4d5..d571ad7291ed 100644
--- a/drivers/iio/light/us5182d.c
+++ b/drivers/iio/light/us5182d.c
@@ -972,10 +972,17 @@ static const struct i2c_device_id us5182d_id[] = {
 
 MODULE_DEVICE_TABLE(i2c, us5182d_id);
 
+static const struct of_device_id us5182d_of_match[] = {
+	{ .compatible = "upisemi,usd5182" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, us5182d_of_match);
+
 static struct i2c_driver us5182d_driver = {
 	.driver = {
 		.name = US5182D_DRV_NAME,
 		.pm = &us5182d_pm_ops,
+		.of_match_table = us5182d_of_match,
 		.acpi_match_table = ACPI_PTR(us5182d_acpi_match),
 	},
 	.probe = us5182d_probe,
-- 
2.9.3

