Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35728 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303Ab3CBQRn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Mar 2013 11:17:43 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 46/67] staging:iio:accel:lis3l02dq move to info_mask_(shared_by_type/separate)
Date: Sat,  2 Mar 2013 16:17:03 +0000
Message-Id: <1362241044-3534-47-git-send-email-jic23@kernel.org>
In-Reply-To: <1362241044-3534-1-git-send-email-jic23@kernel.org>
References: <1362241044-3534-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The original info_mask is going away in favour of the broken out versions.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/lis3l02dq_core.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index 0e01930..1bfe5d8 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -501,12 +501,6 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 	return IRQ_HANDLED;
 }
 
-#define LIS3L02DQ_INFO_MASK				\
-	(IIO_CHAN_INFO_RAW_SEPARATE_BIT |		\
-	 IIO_CHAN_INFO_SCALE_SHARED_BIT |		\
-	 IIO_CHAN_INFO_CALIBSCALE_SEPARATE_BIT |	\
-	 IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT)
-
 #define LIS3L02DQ_EVENT_MASK					\
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
 	 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
@@ -516,7 +510,10 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 		.type = IIO_ACCEL,				\
 		.modified = 1,					\
 		.channel2 = mod,				\
-		.info_mask =  LIS3L02DQ_INFO_MASK,		\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
+			BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
+			BIT(IIO_CHAN_INFO_CALIBBIAS),		\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
 		.address = index,				\
 		.scan_index = index,				\
 		.scan_type = {					\
-- 
1.8.1.4

