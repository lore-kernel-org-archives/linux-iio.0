Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:37048
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753090AbdCMT7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 15:59:48 -0400
From: Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH 02/17] iio: mlx96014: Add OF device ID table
Date: Mon, 13 Mar 2017 16:59:02 -0300
Message-Id: <20170313195917.12190-3-javier@osg.samsung.com>
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

 drivers/iio/temperature/mlx90614.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 4b645fc672aa..c82d49b85cdc 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -585,6 +585,12 @@ static const struct i2c_device_id mlx90614_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, mlx90614_id);
 
+static const struct of_device_id mlx90614_of_match[] = {
+	{ .compatible = "melexis,mlx90614" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mlx90614_of_match);
+
 #ifdef CONFIG_PM_SLEEP
 static int mlx90614_pm_suspend(struct device *dev)
 {
@@ -644,6 +650,7 @@ static const struct dev_pm_ops mlx90614_pm_ops = {
 static struct i2c_driver mlx90614_driver = {
 	.driver = {
 		.name	= "mlx90614",
+		.of_match_table = of_match_ptr(mlx90614_of_match),
 		.pm	= &mlx90614_pm_ops,
 	},
 	.probe = mlx90614_probe,
-- 
2.9.3

