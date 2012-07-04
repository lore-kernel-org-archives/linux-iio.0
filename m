Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-143.synserver.de ([212.40.185.143]:1085 "EHLO
	smtp-out-143.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754862Ab2GDQFu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 4 Jul 2012 12:05:50 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] staging:iio:ad799x: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:26 +0200
Message-Id: <1341418173-3217-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x_core.c |    5 +++--
 drivers/staging/iio/adc/ad799x_ring.c |    2 --
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index 2d4bda9..9900507 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -350,10 +350,10 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 
 	ret = ad799x_i2c_read8(st, AD7998_ALERT_STAT_REG, &status);
 	if (ret)
-		return ret;
+		goto done;
 
 	if (!status)
-		return -EIO;
+		goto done;
 
 	ad799x_i2c_write8(st, AD7998_ALERT_STAT_REG, AD7998_ALERT_STAT_CLEAR);
 
@@ -372,6 +372,7 @@ static irqreturn_t ad799x_event_handler(int irq, void *private)
 				       iio_get_time_ns());
 	}
 
+done:
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/staging/iio/adc/ad799x_ring.c b/drivers/staging/iio/adc/ad799x_ring.c
index 0882c9e..858a685 100644
--- a/drivers/staging/iio/adc/ad799x_ring.c
+++ b/drivers/staging/iio/adc/ad799x_ring.c
@@ -81,8 +81,6 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	ring->access->store_to(indio_dev->buffer, rxbuf, time_ns);
 done:
 	kfree(rxbuf);
-	if (b_sent < 0)
-		return b_sent;
 out:
 	iio_trigger_notify_done(indio_dev->trig);
 
-- 
1.7.10

