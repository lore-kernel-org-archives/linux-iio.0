Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] staging iio: use iio_trigger_generic_data_rdy_poll() in accel/adis16209,adis16240 driver
Date: Sat, 13 Oct 2012 10:06:34 +0200
Message-Id: <1350115595-7107-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
References: <1350115595-7107-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16209_trigger.c |   11 +----------
 drivers/staging/iio/accel/adis16240_trigger.c |   11 +----------
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_trigger.c b/drivers/staging/iio/accel/adis16209_trigger.c
index 2ad93dc..1122803 100644
--- a/drivers/staging/iio/accel/adis16209_trigger.c
+++ b/drivers/staging/iio/accel/adis16209_trigger.c
@@ -8,15 +8,6 @@
 #include "adis16209.h"
 
 /**
- * adis16209_data_rdy_trig_poll() the event handler for the data rdy trig
- **/
-static irqreturn_t adis16209_data_rdy_trig_poll(int irq, void *trig)
-{
-	iio_trigger_poll(trig, iio_get_time_ns());
-	return IRQ_HANDLED;
-}
-
-/**
  * adis16209_data_rdy_trigger_set_state() set datardy interrupt state
  **/
 static int adis16209_data_rdy_trigger_set_state(struct iio_trigger *trig,
@@ -45,7 +36,7 @@ int adis16209_probe_trigger(struct iio_dev *indio_dev)
 	}
 
 	ret = request_irq(st->us->irq,
-			  adis16209_data_rdy_trig_poll,
+			  iio_trigger_generic_data_rdy_poll,
 			  IRQF_TRIGGER_RISING,
 			  "adis16209",
 			  st->trig);
diff --git a/drivers/staging/iio/accel/adis16240_trigger.c b/drivers/staging/iio/accel/adis16240_trigger.c
index fa90a22..f3caf09 100644
--- a/drivers/staging/iio/accel/adis16240_trigger.c
+++ b/drivers/staging/iio/accel/adis16240_trigger.c
@@ -8,15 +8,6 @@
 #include "adis16240.h"
 
 /**
- * adis16240_data_rdy_trig_poll() the event handler for the data rdy trig
- **/
-static irqreturn_t adis16240_data_rdy_trig_poll(int irq, void *trig)
-{
-	iio_trigger_poll(trig, iio_get_time_ns());
-	return IRQ_HANDLED;
-}
-
-/**
  * adis16240_data_rdy_trigger_set_state() set datardy interrupt state
  **/
 static int adis16240_data_rdy_trigger_set_state(struct iio_trigger *trig,
@@ -45,7 +36,7 @@ int adis16240_probe_trigger(struct iio_dev *indio_dev)
 	}
 
 	ret = request_irq(st->us->irq,
-			  adis16240_data_rdy_trig_poll,
+			  iio_trigger_generic_data_rdy_poll,
 			  IRQF_TRIGGER_RISING,
 			  "adis16240",
 			  st->trig);
-- 
1.7.9.5
