Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45754
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752250AbdCOEqc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 00:46:32 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 17/17] iio: gyro: itg3200: Add OF device ID table
Date: Wed, 15 Mar 2017 01:45:05 -0300
Message-Id: <20170315044505.20660-18-javier@osg.samsung.com>
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

 drivers/iio/gyro/itg3200_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/gyro/itg3200_core.c b/drivers/iio/gyro/itg3200_core.c
index c102a6325bb0..cfa2db04a8ab 100644
--- a/drivers/iio/gyro/itg3200_core.c
+++ b/drivers/iio/gyro/itg3200_core.c
@@ -377,9 +377,16 @@ static const struct i2c_device_id itg3200_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, itg3200_id);
 
+static const struct of_device_id itg3200_of_match[] = {
+	{ .compatible = "invensense,itg3200" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, itg3200_of_match);
+
 static struct i2c_driver itg3200_driver = {
 	.driver = {
 		.name	= "itg3200",
+		.of_match_table = itg3200_of_match,
 		.pm	= &itg3200_pm_ops,
 	},
 	.id_table	= itg3200_id,
-- 
2.9.3

