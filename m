Return-Path: <SRS0=bMeI=3W=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>,
	George McCollister <george.mccollister@gmail.com>
Subject: [PATCH] iio: proximity: as3935: recalibrate RCO after resume
Date: Fri, 14 Apr 2017 16:38:19 -0700
Message-Id: <20170414233819.8259-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

According to the datasheet the RCO must be recalibrated
on every power-on-reset. Also remove mutex locking in the
calibration function since callers other than the probe
function (which doesn't need it) will have a lock.

Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
Cc: George McCollister <george.mccollister@gmail.com>
Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index ddf9bee89f77..d0f5e53aad59 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -269,8 +269,6 @@ static irqreturn_t as3935_interrupt_handler(int irq, void *private)
 
 static void calibrate_as3935(struct as3935_state *st)
 {
-	mutex_lock(&st->lock);
-
 	/* mask disturber interrupt bit */
 	as3935_write(st, AS3935_INT, BIT(5));
 
@@ -280,8 +278,6 @@ static void calibrate_as3935(struct as3935_state *st)
 
 	mdelay(2);
 	as3935_write(st, AS3935_TUNE_CAP, (st->tune_cap / TUNE_CAP_DIV));
-
-	mutex_unlock(&st->lock);
 }
 
 #ifdef CONFIG_PM_SLEEP
@@ -318,6 +314,8 @@ static int as3935_resume(struct device *dev)
 	val &= ~AS3935_AFE_PWR_BIT;
 	ret = as3935_write(st, AS3935_AFE_GAIN, val);
 
+	calibrate_as3935(st);
+
 err_resume:
 	mutex_unlock(&st->lock);
 
-- 
2.11.0
