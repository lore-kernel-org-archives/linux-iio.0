Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: lidar: add missing MODULE_DEVICE_TABLE for dt
Date: Tue, 22 Sep 2015 23:22:03 -0700
Message-Id: <1442989323-12247-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The device tree compatible strings weren't properly
registered for the pulsedlight-lidar-lite-v2 driver.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 185a7ab..961f9f99 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -271,6 +271,7 @@ static const struct of_device_id lidar_dt_ids[] = {
 	{ .compatible = "pulsedlight,lidar-lite-v2" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, lidar_dt_ids);
 
 static struct i2c_driver lidar_driver = {
 	.driver = {
-- 
1.9.1
