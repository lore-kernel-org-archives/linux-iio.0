Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 02/11] staging:iio:adt7310: Do not return error code in interrupt handler
Date: Wed,  4 Jul 2012 18:09:24 +0200
Message-Id: <1341418173-3217-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1341418173-3217-1-git-send-email-lars@metafoo.de>
References: <1341418173-3217-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The interrupt handler should only ever return one of the three irqreturn_t
constants and not an error code. Also make sure to always call
iio_trigger_notify_done before leaving the trigger handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/adt7310.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index e5f1ed7..e05bc30d 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -397,7 +397,7 @@ static irqreturn_t adt7310_event_handler(int irq, void *private)
 
 	ret = adt7310_spi_read_byte(chip, ADT7310_STATUS, &status);
 	if (ret)
-		return ret;
+		goto done;
 
 	if (status & ADT7310_STAT_T_HIGH)
 		iio_push_event(indio_dev,
@@ -417,6 +417,8 @@ static irqreturn_t adt7310_event_handler(int irq, void *private)
 						    IIO_EV_TYPE_THRESH,
 						    IIO_EV_DIR_RISING),
 			timestamp);
+
+done:
 	return IRQ_HANDLED;
 }
 
-- 
1.7.10
