Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:32993 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751454AbcLJGen (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Dec 2016 01:34:43 -0500
Received: by mail-pg0-f54.google.com with SMTP id 3so15491657pgd.0
        for <linux-iio@vger.kernel.org>; Fri, 09 Dec 2016 22:34:43 -0800 (PST)
From: Matt Ranostay <matt@ranostay.consulting>
To: linux-iio@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 2/2] iio: pulsedlight-lidar-lite-v2: add lidar-lite-v3 property
Date: Fri,  9 Dec 2016 22:34:39 -0800
Message-Id: <1481351679-23400-2-git-send-email-matt@ranostay.consulting>
In-Reply-To: <1481351679-23400-1-git-send-email-matt@ranostay.consulting>
References: <1481351679-23400-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 1fa9eefa0982..0adcc417967d 100644
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
+	{ .compatible = "garmin,lidar-lite-v3" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, lidar_dt_ids);
-- 
2.7.4

