Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 34/38] iio:adc: drop assignment of iio_trigger_ops.owner
Date: Mon, 29 May 2017 16:51:50 +0100
Message-Id: <20170529155154.22580-35-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
index 4e0b4eedb53d..d80dcf82eba9 100644
--- a/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
+++ b/drivers/staging/iio/trigger/iio-trig-bfin-timer.c
@@ -172,7 +172,6 @@ static int iio_bfin_tmr_get_number(int irq)
 }
 
 static const struct iio_trigger_ops iio_bfin_tmr_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = iio_bfin_tmr_set_state,
 };
 
-- 
2.13.0
