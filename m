Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:56541 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752081AbaJTTwL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 20 Oct 2014 15:52:11 -0400
From: Dan Murphy <dmurphy@ti.com>
To: <jic23@kernel.org>, <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] iio: tsl4531: Fix compiler error when CONFIG_PM_OPS is not defined
Date: Mon, 20 Oct 2014 14:52:02 -0500
Message-ID: <1413834722-7500-1-git-send-email-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix the compiler error when the CONFIG_PM_OPS flag is not set.

drivers/iio/light/tsl4531.c:235:8: error: ‘tsl4531_suspend’ undeclared here (not in a function)
drivers/iio/light/tsl4531.c:235:8: error: ‘tsl4531_resume’ undeclared here (not in a function)

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 drivers/iio/light/tsl4531.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
index a15006e..0763b86 100644
--- a/drivers/iio/light/tsl4531.c
+++ b/drivers/iio/light/tsl4531.c
@@ -230,9 +230,12 @@ static int tsl4531_resume(struct device *dev)
 	return i2c_smbus_write_byte_data(to_i2c_client(dev), TSL4531_CONTROL,
 		TSL4531_MODE_NORMAL);
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(tsl4531_pm_ops, tsl4531_suspend, tsl4531_resume);
+#define TSL4531_PM_OPS (&tsl4531_pm_ops)
+#else
+#define TSL4531_PM_OPS NULL
+#endif
 
 static const struct i2c_device_id tsl4531_id[] = {
 	{ "tsl4531", 0 },
@@ -243,7 +246,7 @@ MODULE_DEVICE_TABLE(i2c, tsl4531_id);
 static struct i2c_driver tsl4531_driver = {
 	.driver = {
 		.name   = TSL4531_DRV_NAME,
-		.pm	= &tsl4531_pm_ops,
+		.pm	= TSL4531_PM_OPS,
 		.owner  = THIS_MODULE,
 	},
 	.probe  = tsl4531_probe,
-- 
1.7.9.5

