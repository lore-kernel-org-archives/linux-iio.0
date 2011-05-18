Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54121 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933250Ab1ERNkI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 18 May 2011 09:40:08 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 088/111] staging:iio:addac:adt7316 replace abuse of buffer events.
Date: Wed, 18 May 2011 14:42:18 +0100
Message-Id: <1305726161-5606-89-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
References: <1305726161-5606-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently squashed the fault condition from external
temperature sensor - lots of other issues to be fixed
with this driver which obeys almost no elements of the
abi.

V2: removed a couple of usused variables that sparse found.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/addac/adt7316.c |   82 ++++++++++++++++++++++-------------
 1 files changed, 52 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 24dd2d2..b71994e 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -462,7 +462,7 @@ static ssize_t adt7316_show_all_ad_channels(struct device *dev,
 
 	if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
 		return sprintf(buf, "0 - VDD\n1 - Internal Temperature\n"
-				"2 - External Temperature or AIN2\n"
+				"2 - External Temperature or AIN1\n"
 				"3 - AIN2\n4 - AIN3\n5 - AIN4\n");
 	else
 		return sprintf(buf, "0 - VDD\n1 - Internal Temperature\n"
@@ -1762,49 +1762,71 @@ static const struct attribute_group adt7516_attribute_group = {
 	.attrs = adt7516_attributes,
 };
 
-
-/*
- * temperature bound events
- */
-
-#define IIO_EVENT_CODE_ADT7316_IN_TEMP_HIGH   IIO_BUFFER_EVENT_CODE(0)
-#define IIO_EVENT_CODE_ADT7316_IN_TEMP_LOW    IIO_BUFFER_EVENT_CODE(1)
-#define IIO_EVENT_CODE_ADT7316_EX_TEMP_HIGH   IIO_BUFFER_EVENT_CODE(2)
-#define IIO_EVENT_CODE_ADT7316_EX_TEMP_LOW    IIO_BUFFER_EVENT_CODE(3)
-#define IIO_EVENT_CODE_ADT7316_EX_TEMP_FAULT  IIO_BUFFER_EVENT_CODE(4)
-#define IIO_EVENT_CODE_ADT7516_AIN1           IIO_BUFFER_EVENT_CODE(5)
-#define IIO_EVENT_CODE_ADT7516_AIN2           IIO_BUFFER_EVENT_CODE(6)
-#define IIO_EVENT_CODE_ADT7516_AIN3           IIO_BUFFER_EVENT_CODE(7)
-#define IIO_EVENT_CODE_ADT7516_AIN4           IIO_BUFFER_EVENT_CODE(8)
-#define IIO_EVENT_CODE_ADT7316_VDD            IIO_BUFFER_EVENT_CODE(9)
-
 static irqreturn_t adt7316_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
 	struct adt7316_chip_info *chip = iio_dev_get_devdata(indio_dev);
 	u8 stat1, stat2;
-	int i, ret, count;
+	int ret;
+	s64 time;
 
 	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT1, &stat1);
 	if (!ret) {
-		if ((chip->id & ID_FAMILY_MASK) == ID_ADT75XX)
-			count = 8;
-		else
-			count = 5;
+		if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
+			stat1 &= 0x1F;
 
-		for (i = 0; i < count; i++) {
-			if (stat1 & (1 << i))
-				iio_push_event(chip->indio_dev, 0,
-					IIO_EVENT_CODE_ADT7316_IN_TEMP_HIGH + i,
-					iio_get_time_ns());
+		time = iio_get_time_ns();
+		if (stat1 & (1 << 0))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
+				       time);
+		if (stat1 & (1 << 1))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
+				       time);
+		if (stat1 & (1 << 2))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
+				       time);
+		if (stat1 & (1 << 3))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 1,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING),
+				       time);
+		if (stat1 & (1 << 5))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN, 1,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_EITHER),
+				       time);
+		if (stat1 & (1 << 6))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN, 2,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_EITHER),
+				       time);
+		if (stat1 & (1 << 7))
+			iio_push_event(chip->indio_dev, 0,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN, 3,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_EITHER),
+				       time);
 		}
-	}
-
 	ret = chip->bus.read(chip->bus.client, ADT7316_INT_STAT2, &stat2);
 	if (!ret) {
 		if (stat2 & ADT7316_INT_MASK2_VDD)
 			iio_push_event(chip->indio_dev, 0,
-				IIO_EVENT_CODE_ADT7316_VDD,
+				       IIO_UNMOD_EVENT_CODE(IIO_IN,
+							    0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING),
 				       iio_get_time_ns());
 	}
 
-- 
1.7.3.4

