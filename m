Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: arnd@arndb.de,
	Michael.Hennerich@analog.com,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 81/99] staging:iio:adc:adt7410 replace abuse of buffer events.
Date: Wed,  4 May 2011 12:58:53 +0100
Message-Id: <1304510351-10922-82-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
References: <1304510351-10922-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt7410.c |   26 ++++++++++++--------------
 1 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
index c102b42..85b5c1a 100644
--- a/drivers/staging/iio/adc/adt7410.c
+++ b/drivers/staging/iio/adc/adt7410.c
@@ -355,14 +355,6 @@ static const struct attribute_group adt7410_attribute_group = {
 	.attrs = adt7410_attributes,
 };
 
-/*
- * temperature bound events
- */
-
-#define IIO_EVENT_CODE_ADT7410_ABOVE_ALARM    IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_ADT7410_BELLOW_ALARM   IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_ADT7410_ABOVE_CRIT     IIO_BUFFER_EVENT_CODE(2)
-
 static irqreturn_t adt7410_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -375,16 +367,22 @@ static irqreturn_t adt7410_event_handler(int irq, void *private)
 
 	if (status & ADT7410_STAT_T_HIGH)
 		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_ADT7410_ABOVE_ALARM,
-			timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
 	if (status & ADT7410_STAT_T_LOW)
 		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_ADT7410_BELLOW_ALARM,
-			timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
 	if (status & ADT7410_STAT_T_CRIT)
 		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_ADT7410_ABOVE_CRIT,
-			timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
 
 	return IRQ_HANDLED;
 }
-- 
1.7.3.4
