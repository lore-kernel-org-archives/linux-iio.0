Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33970 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753666AbbIJQa5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 12:30:57 -0400
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 1/6] Staging: iio: addac: Prefer using the BIT macro
Date: Thu, 10 Sep 2015 22:00:29 +0530
Message-Id: <1441902634-11129-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro.

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

