Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35059 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754180AbbIHMcu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 8 Sep 2015 08:32:50 -0400
Received: by pacfv12 with SMTP id fv12so126261619pac.2
        for <linux-iio@vger.kernel.org>; Tue, 08 Sep 2015 05:32:50 -0700 (PDT)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>
Cc: Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH] Staging: iio: addac: adt7316.c : Prefer using BIT macro
Date: Tue,  8 Sep 2015 18:02:32 +0530
Message-Id: <1441715552-7705-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro
as it's extensively used by other function in this driver.

This was done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 5b11b42..a1dd745 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -1756,43 +1756,43 @@ static irqreturn_t adt7316_event_handler(int irq, void *private)
 			stat1 &= 0x1F;
 
 		time = iio_get_time_ns();
-		if (stat1 & (1 << 0))
+		if (stat1 & BIT(0))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
 				       time);
-		if (stat1 & (1 << 1))
+		if (stat1 & BIT(1))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
 				       time);
-		if (stat1 & (1 << 2))
+		if (stat1 & BIT(2))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_RISING),
 				       time);
-		if (stat1 & (1 << 3))
+		if (stat1 & BIT(3))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_FALLING),
 				       time);
-		if (stat1 & (1 << 5))
+		if (stat1 & BIT(5))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 1,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
-		if (stat1 & (1 << 6))
+		if (stat1 & BIT(6))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 2,
 							    IIO_EV_TYPE_THRESH,
 							    IIO_EV_DIR_EITHER),
 				       time);
-		if (stat1 & (1 << 7))
+		if (stat1 & BIT(7))
 			iio_push_event(indio_dev,
 				       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 3,
 							    IIO_EV_TYPE_THRESH,
-- 
2.1.4

