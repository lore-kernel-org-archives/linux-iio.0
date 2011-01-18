Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:56116 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753264Ab1ARG7T (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 18 Jan 2011 01:59:19 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p0I6xGsl002454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-iio@vger.kernel.org>; Tue, 18 Jan 2011 00:59:18 -0600
From: shubhrajyoti@ti.com
To: linux-iio@vger.kernel.org
Cc: Shubhrajyoti Datta <shubhrajyoti@ti.com>
Subject: [PATCH ]hmc5843: Convert to dev pm ops
Date: Tue, 18 Jan 2011 12:29:10 +0530
Message-Id: <1295333951-3793-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Shubhrajyoti Datta <shubhrajyoti@ti.com>


Signed-off-by: Shubhrajyoti Datta <shubhrajyoti@ti.com>
---
 drivers/staging/iio/magnetometer/hmc5843.c |   18 ++++++++++++------
 1 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 5168917..b1c26d8 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -583,20 +583,25 @@ static int hmc5843_remove(struct i2c_client *client)
 	kfree(i2c_get_clientdata(client));
 	return 0;
 }
-
-static int hmc5843_suspend(struct i2c_client *client, pm_message_t mesg)
+#ifdef CONFIG_PM
+static int hmc5843_suspend(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	hmc5843_configure(client, MODE_SLEEP);
 	return 0;
 }
 
-static int hmc5843_resume(struct i2c_client *client)
+static int hmc5843_resume(struct device *dev)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct hmc5843_data *data = i2c_get_clientdata(client);
 	hmc5843_configure(client, data->operating_mode);
 	return 0;
 }
-
+static SIMPLE_DEV_PM_OPS(hmc5843_pm, hmc5843_suspend, hmc5843_resume);
+#else
+#define hmc5843_pm NULL
+#endif
 static const struct i2c_device_id hmc5843_id[] = {
 	{ "hmc5843", 0 },
 	{ }
@@ -605,14 +610,15 @@ static const struct i2c_device_id hmc5843_id[] = {
 static struct i2c_driver hmc5843_driver = {
 	.driver = {
 		.name	= "hmc5843",
+#ifdef CONFIG_PM
+		.pm	= &hmc5843_pm,
+#endif
 	},
 	.id_table	= hmc5843_id,
 	.probe		= hmc5843_probe,
 	.remove		= hmc5843_remove,
 	.detect		= hmc5843_detect,
 	.address_list	= normal_i2c,
-	.suspend	= hmc5843_suspend,
-	.resume		= hmc5843_resume,
 };
 
 static int __init hmc5843_init(void)
-- 
1.7.1

