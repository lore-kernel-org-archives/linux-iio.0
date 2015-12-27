Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: proximity: lidar: correct return value
Date: Sat, 26 Dec 2015 20:56:30 -0800
Message-Id: <1451192190-2624-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

lidar_i2c_xfer() function was never a non-positive value on error,
and this correct that with a -EIO return code.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 93e29fb..db35e04 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -87,7 +87,7 @@ static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
 
 	ret = i2c_transfer(client->adapter, msg, 2);
 
-	return (ret == 2) ? 0 : ret;
+	return (ret == 2) ? 0 : -EIO;
 }
 
 static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
-- 
2.6.4
