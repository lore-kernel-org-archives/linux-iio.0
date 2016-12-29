Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35300 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcL2FNZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Dec 2016 00:13:25 -0500
Received: by mail-pg0-f43.google.com with SMTP id i5so97979533pgh.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Dec 2016 21:13:25 -0800 (PST)
From: Matt Ranostay <matt@ranostay.consulting>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v2 2/2] iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property
Date: Wed, 28 Dec 2016 21:13:06 -0800
Message-Id: <20161229051306.28547-2-matt@ranostay.consulting>
In-Reply-To: <20161229051306.28547-1-matt@ranostay.consulting>
References: <20161229051306.28547-1-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
Changes from v1:
* switch to using Garmin stock ticker

 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 1fa9eefa0982..20c16a08c9d9 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -326,12 +326,14 @@ static int lidar_remove(struct i2c_client *client)
 
 static const struct i2c_device_id lidar_id[] = {
 	{"lidar-lite-v2", 0},
+	{"lidar-lite-v3", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, lidar_id);
 
 static const struct of_device_id lidar_dt_ids[] = {
 	{ .compatible = "pulsedlight,lidar-lite-v2" },
+	{ .compatible = "grmn,lidar-lite-v3" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lidar_dt_ids);
-- 
2.10.2

