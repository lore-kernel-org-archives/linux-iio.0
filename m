Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2347 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754694AbbFQMtn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 17 Jun 2015 08:49:43 -0400
From: Tiberiu Breana <tiberiu.a.breana@intel.com>
To: linux-iio@vger.kernel.org
Subject: [PATCH 1/2] iio: accel: STK8BA50: suspend sensor on init errors
Date: Wed, 17 Jun 2015 15:50:11 +0300
Message-Id: <1434545412-16871-1-git-send-email-tiberiu.a.breana@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Put chip in 'suspend' mode in case something goes wrong
during probe.

Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
 drivers/iio/accel/stk8ba50.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 92229bd..9836880 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -265,7 +265,7 @@ static int stk8ba50_probe(struct i2c_client *client,
 			STK8BA50_REG_SWRST, STK8BA50_RESET_CMD);
 	if (ret < 0) {
 		dev_err(&client->dev, "failed to reset sensor\n");
-		return ret;
+		goto err_power_off;
 	}
 
 	/* The default range is +/-2g */
@@ -277,10 +277,14 @@ static int stk8ba50_probe(struct i2c_client *client,
 	ret = iio_device_register(indio_dev);
 	if (ret < 0) {
 		dev_err(&client->dev, "device_register failed\n");
-		stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
+		goto err_power_off;
 	}
 
 	return ret;
+
+err_power_off:
+	stk8ba50_set_power(data, STK8BA50_MODE_SUSPEND);
+	return ret;
 }
 
 static int stk8ba50_remove(struct i2c_client *client)
-- 
1.9.1

