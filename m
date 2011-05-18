Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54116 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933248Ab1ERNkI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:08 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 086/111] staging:iio:adc:adt7310 replace abuse of buffer events.
Date: Wed, 18 May 2011 14:42:16 +0100
Message-Id: <1305726161-5606-87-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/adt7310.c |   24 +++++++++++-------------
 1 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/adc/adt7310.c b/drivers/staging/iio/adc/adt7310.c
index 2ade485..e405fc3 100644
--- a/drivers/staging/iio/adc/adt7310.c
+++ b/drivers/staging/iio/adc/adt7310.c
@@ -387,14 +387,6 @@ static const struct attribute_group adt7310_attribute_group = {
 	.attrs = adt7310_attributes,
 };
 
-/*
- * temperature bound events
- */
-
-#define IIO_EVENT_CODE_ADT7310_ABOVE_ALARM    IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_ADT7310_BELLOW_ALARM   IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_ADT7310_ABOVE_CRIT     IIO_BUFFER_EVENT_CODE(2)
-
 static irqreturn_t adt7310_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
@@ -409,15 +401,21 @@ static irqreturn_t adt7310_event_handler(int irq, void *private)
 
 	if (status & ADT7310_STAT_T_HIGH)
 		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_ADT7310_ABOVE_ALARM,
-			timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       timestamp);
 	if (status & ADT7310_STAT_T_LOW)
 		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_ADT7310_BELLOW_ALARM,
-			timestamp);
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_FALLING),
+			       timestamp);
 	if (status & ADT7310_STAT_T_CRIT)
 		iio_push_event(indio_dev, 0,
-			IIO_EVENT_CODE_ADT7310_ABOVE_CRIT,
+			       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
 			timestamp);
 	return IRQ_HANDLED;
 }
-- 
1.7.3.4

