Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] kmx61: Use KMX61_DRV_NAME instead of hardcoded value
Date: Mon, 17 Nov 2014 15:18:36 +0200
Message-Id: <1416230316-14511-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1416230316-14511-1-git-send-email-daniel.baluta@intel.com>
References: <1416230316-14511-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index e49b1cc..8c4b365 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -578,7 +578,7 @@ MODULE_DEVICE_TABLE(i2c, kmx61_id);
 
 static struct i2c_driver kmx61_driver = {
 	.driver = {
-		.name = "kmx61",
+		.name = KMX61_DRV_NAME,
 	},
 	.probe		= kmx61_probe,
 	.remove		= kmx61_remove,
-- 
1.9.1
