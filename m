Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, <jic23@cam.ac.uk>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH] iio: adc: ad7280a: Fix memory leak
Date: Wed, 26 Oct 2011 13:38:18 +0200
Message-ID: <1319629098-27442-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Free channels in case read fails with error.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7280a.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0c212e0..f45b66b 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -688,7 +688,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 
 	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
 	if (ret < 0)
-		return IRQ_HANDLED;
+		goto out;
 
 	for (i = 0; i < st->scan_cnt; i++) {
 		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
@@ -731,6 +731,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		}
 	}
 
+out:
 	kfree(channels);
 
 	return IRQ_HANDLED;
-- 
1.7.0.4
