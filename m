Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:39012 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758352Ab2I2AHr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Sep 2012 20:07:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>, 21cnbao@gmail.com
Subject: [PATCH] staging iio: use iio_trigger_generic_data_rdy_poll() in accel/adis16209 driver
Date: Sat, 29 Sep 2012 02:07:42 +0200
Message-Id: <1348877262-8593-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: 21cnbao@gmail.com
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

