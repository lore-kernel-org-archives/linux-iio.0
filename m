Return-Path: <mranostay@gmail.com>
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: lidar: return -EIO on invalid signal
Date: Sun, 25 Oct 2015 16:07:18 -0700
Message-Id: <1445814438-17163-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Returning zero from the measurment function has the side effect of
corrupting the triggered buffer readings, better to use -EIO than a
zero measurement reading.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 961f9f99..359beac 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -130,10 +130,10 @@ static int lidar_get_measurement(struct lidar_data *data, u16 *reg)
 		if (ret < 0)
 			break;
 
-		/* return 0 since laser is likely pointed out of range */
+		/* return -EIO since laser is likely pointed out of range */
 		if (ret & LIDAR_REG_STATUS_INVALID) {
 			*reg = 0;
-			ret = 0;
+			ret = -EIO;
 			break;
 		}
 
-- 
1.9.1
