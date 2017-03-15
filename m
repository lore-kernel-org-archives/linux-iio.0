Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:45730
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751959AbdCOEqV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Mar 2017 00:46:21 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH v2 14/17] iio: accel: mma7455_i2c: Add OF device ID table
Date: Wed, 15 Mar 2017 01:45:02 -0300
Message-Id: <20170315044505.20660-15-javier@osg.samsung.com>
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

 drivers/iio/accel/mma7455_i2c.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/accel/mma7455_i2c.c b/drivers/iio/accel/mma7455_i2c.c
index 3cab5fb4a3c4..73bf81a8ab14 100644
--- a/drivers/iio/accel/mma7455_i2c.c
+++ b/drivers/iio/accel/mma7455_i2c.c
@@ -41,12 +41,20 @@ static const struct i2c_device_id mma7455_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mma7455_i2c_ids);
 
+static const struct of_device_id mma7455_of_match[] = {
+	{ .compatible = "fsl,mma7455" },
+	{ .compatible = "fsl,mma7456" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mma7455_of_match);
+
 static struct i2c_driver mma7455_i2c_driver = {
 	.probe = mma7455_i2c_probe,
 	.remove = mma7455_i2c_remove,
 	.id_table = mma7455_i2c_ids,
 	.driver = {
 		.name	= "mma7455-i2c",
+		.of_match_table = mma7455_of_match,
 	},
 };
 module_i2c_driver(mma7455_i2c_driver);
-- 
2.9.3

