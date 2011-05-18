Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 085/111] staging:iio:adc:ad7291 remove abuse of buffer events and replace with something almost sane
Date: Wed, 18 May 2011 14:42:15 +0100
Message-Id: <1305726161-5606-86-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This device has separate events for a sort of decaying average and for
the raw value.  We don't have a way of specifying this as yet.
For now I have both resulting in the same event code.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/ad7291.c |   58 +++++++++++++++++++++++++++----------
 1 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index 527311c..0e4c728 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -454,12 +454,6 @@ static const struct attribute_group ad7291_attribute_group = {
  * temperature bound events
  */
 
-#define IIO_EVENT_CODE_AD7291_T_SENSE_HIGH  IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_AD7291_T_SENSE_LOW   IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_AD7291_T_AVG_HIGH    IIO_BUFFER_EVENT_CODE(2)
-#define IIO_EVENT_CODE_AD7291_T_AVG_LOW     IIO_BUFFER_EVENT_CODE(3)
-#define IIO_EVENT_CODE_AD7291_VOLTAGE_BASE  IIO_BUFFER_EVENT_CODE(4)
-
 static irqreturn_t ad7291_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -484,18 +478,50 @@ static irqreturn_t ad7291_event_handler(int irq, void *private)
 	command = chip->command & ~AD7291_ALART_CLEAR;
 	ad7291_i2c_write(chip, AD7291_COMMAND, command);
 
-	for (i = 0; i < 4; i++) {
-		if (t_status & (1 << i))
-			iio_push_event(indio_dev, 0,
-				IIO_EVENT_CODE_AD7291_T_SENSE_HIGH + i,
-				timestamp);
-	}
-
-	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT*2; i++) {
+	if (t_status & (1 << 0))
+		iio_push_event(indio_dev, 0,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+	if (t_status & (1 << 1))
+		iio_push_event(indio_dev, 0,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+	if (t_status & (1 << 2))
+		iio_push_event(indio_dev, 0,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
+	if (t_status & (1 << 3))
+		iio_push_event(indio_dev, 0,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP,
+						    0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
+
+	for (i = 0; i < AD7291_VOLTAGE_LIMIT_COUNT*2; i += 2) {
 		if (v_status & (1 << i))
 			iio_push_event(indio_dev, 0,
-				IIO_EVENT_CODE_AD7291_VOLTAGE_BASE + i,
-				timestamp);
+				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+							    i/2,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
+				       timestamp);
+		if (v_status & (1 << (i + 1)))
+			iio_push_event(indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+							    i/2,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
+				       timestamp);
 	}
 
 	return IRQ_HANDLED;
-- 
1.7.3.4
