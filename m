Return-Path: <standby24x7@gmail.com>
From: Masanari Iida <standby24x7@gmail.com>
To: devel@driverdev.osuosl.org,
	jic23@kernel.org,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] staging: iio: Fix format string mismatch in ad7280a.c
Date: Tue, 29 Apr 2014 01:00:02 +0900
Message-Id: <1398700802-31361-1-git-send-email-standby24x7@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix two format string mismatch in ad7280a.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 1ac11f6..d215edf 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -443,7 +443,7 @@ static ssize_t ad7280_show_balance_timer(struct device *dev,
 
 	msecs = (ret >> 3) * 71500;
 
-	return sprintf(buf, "%d\n", msecs);
+	return sprintf(buf, "%u\n", msecs);
 }
 
 static ssize_t ad7280_store_balance_timer(struct device *dev,
@@ -619,7 +619,7 @@ static ssize_t ad7280_read_channel_config(struct device *dev,
 		return -EINVAL;
 	}
 
-	return sprintf(buf, "%d\n", val);
+	return sprintf(buf, "%u\n", val);
 }
 
 static ssize_t ad7280_write_channel_config(struct device *dev,
-- 
2.0.0.rc1
