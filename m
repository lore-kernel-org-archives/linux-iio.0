Return-Path: <spk.linux@gmail.com>
Sender: Sachin Kamat <spk.linux@gmail.com>
From: Sachin Kamat <sachin.kamat@samsung.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	gregkh@linuxfoundation.org,
	spk.linux@gmail.com,
	Michael Hennerich <hennerich@blackfin.uclinux.org>
Subject: [PATCH 1/1] staging: iio: ad9832: Remove redundant check
Date: Thu,  3 Jul 2014 17:26:08 +0530
Message-Id: <1404388568-5370-1-git-send-email-sachin.kamat@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

'val' is unsigned and cannot be negative.

Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
Cc: Michael Hennerich <hennerich@blackfin.uclinux.org>
---
 drivers/staging/iio/frequency/ad9832.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b7c8351..cf68159 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -120,7 +120,7 @@ static ssize_t ad9832_write(struct device *dev, struct device_attribute *attr,
 		ret = spi_sync(st->spi, &st->msg);
 		break;
 	case AD9832_PHASE_SYM:
-		if (val < 0 || val > 3) {
+		if (val > 3) {
 			ret = -EINVAL;
 			break;
 		}
-- 
1.7.9.5
