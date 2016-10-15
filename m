Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33108 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752987AbcJOSEv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Oct 2016 14:04:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id i85so6160473pfa.0
        for <linux-iio@vger.kernel.org>; Sat, 15 Oct 2016 11:04:51 -0700 (PDT)
From: Matt Ranostay <mranostay@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH] iio: proximity: pulsedlight-lidar-lite-v2: cleanup power management
Date: Sat, 15 Oct 2016 11:04:37 -0700
Message-Id: <1476554677-1777-1-git-send-email-matt@ranostay.consulting>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove pm_runtime_mark_last_busy() call that wasn't need in the probe
since the device should be put to sleep

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 3141c3c161bb..1fa9eefa0982 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -301,8 +301,6 @@ static int lidar_probe(struct i2c_client *client,
 	if (ret)
 		goto error_unreg_buffer;
 	pm_runtime_enable(&client->dev);
-
-	pm_runtime_mark_last_busy(&client->dev);
 	pm_runtime_idle(&client->dev);
 
 	return 0;
-- 
2.7.4

