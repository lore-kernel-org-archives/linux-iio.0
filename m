Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 77/99] staging:iio:adc:ad7150 fix event codes.
Date: Wed,  4 May 2011 12:58:49 +0100
Message-Id: <1304510351-10922-78-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

I won't guarantee I got these right, but they are certainly closer than
the abuse of buffer event codes that was perviously in here.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7150.c |   31 +++++++++++++++++++------------
 1 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index cbd1f96..e23bb99 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -642,11 +642,6 @@ static const struct attribute_group ad7150_attribute_group = {
  * threshold events
  */
 
-#define IIO_EVENT_CODE_CH1_HIGH    IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_CH1_LOW     IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_CH2_HIGH    IIO_BUFFER_EVENT_CODE(2)
-#define IIO_EVENT_CODE_CH2_LOW     IIO_BUFFER_EVENT_CODE(3)
-
 static irqreturn_t ad7150_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -658,21 +653,33 @@ static irqreturn_t ad7150_event_handler(int irq, void *private)
 
 	if ((int_status & AD7150_STATUS_OUT1) && !(chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev, 0,
-				IIO_EVENT_CODE_CH1_HIGH,
+			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
 				timestamp);
 	else if ((!(int_status & AD7150_STATUS_OUT1)) && (chip->old_state & AD7150_STATUS_OUT1))
 		iio_push_event(indio_dev, 0,
-				IIO_EVENT_CODE_CH1_LOW,
-				timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
 
 	if ((int_status & AD7150_STATUS_OUT2) && !(chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev, 0,
-				IIO_EVENT_CODE_CH2_HIGH,
-				timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+						    1,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
 	else if ((!(int_status & AD7150_STATUS_OUT2)) && (chip->old_state & AD7150_STATUS_OUT2))
 		iio_push_event(indio_dev, 0,
-				IIO_EVENT_CODE_CH2_LOW,
-				timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_EV_CLASS_IN,
+						    1,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
 	return IRQ_HANDLED;
 }
 
-- 
1.7.3.4
