Return-Path: <SRS0=3s93=Y7=ranostay.consulting=matt@kernel.org>
From: Matt Ranostay <matt@ranostay.consulting>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH] iio: health: max30100: fixed parenthesis around FIFO count check
Date: Mon, 16 Jan 2017 18:04:18 -0800
Message-Id: <20170117020418.23359-1-matt@ranostay.consulting>
List-ID: <linux-iio@vger.kernel.org>

FIFO was being read every sample after the "almost full" state was
reached. This was due to an incorrect placement of the parenthesis
in the while condition check.

Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 90ab8a2d2846..183c14329d6e 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -238,7 +238,7 @@ static irqreturn_t max30100_interrupt_handler(int irq, void *private)
 
 	mutex_lock(&data->lock);
 
-	while (cnt || (cnt = max30100_fifo_count(data) > 0)) {
+	while (cnt || (cnt = max30100_fifo_count(data)) > 0) {
 		ret = max30100_read_measurement(data);
 		if (ret)
 			break;
-- 
2.10.2
