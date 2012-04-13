Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60181 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934481Ab2DMJnH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:43:07 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/14] staging:iio:accel:lis3l02dq unwind use of IIO_CHAN macro.
Date: Fri, 13 Apr 2012 10:42:52 +0100
Message-Id: <1334310180-22170-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1334310180-22170-1-git-send-email-jic23@kernel.org>
References: <1334310180-22170-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/lis3l02dq_core.c b/drivers/staging/iio/accel/lis3l02dq_core.c
index bcf4712..0bb7c70 100644
--- a/drivers/staging/iio/accel/lis3l02dq_core.c
+++ b/drivers/staging/iio/accel/lis3l02dq_core.c
@@ -521,13 +521,26 @@ static irqreturn_t lis3l02dq_event_handler(int irq, void *private)
 	(IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) |	\
 	 IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
 
+#define LIS3L02DQ_CHAN(index, mod)				\
+	{							\
+		.type = IIO_ACCEL,				\
+		.modified = 1,					\
+		.channel2 = mod,				\
+		.info_mask =  LIS3L02DQ_INFO_MASK,		\
+		.address = index,				\
+		.scan_index = index,				\
+		.scan_type = {					\
+			.sign = 's',				\
+			.realbits = 12,				\
+			.storagebits = 16,			\
+		},						\
+		.event_mask = LIS3L02DQ_EVENT_MASK,		\
+	 }
+
 static struct iio_chan_spec lis3l02dq_channels[] = {
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_X, LIS3L02DQ_INFO_MASK,
-		 0, 0, IIO_ST('s', 12, 16, 0), LIS3L02DQ_EVENT_MASK),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Y, LIS3L02DQ_INFO_MASK,
-		 1, 1, IIO_ST('s', 12, 16, 0), LIS3L02DQ_EVENT_MASK),
-	IIO_CHAN(IIO_ACCEL, 1, 0, 0, NULL, 0, IIO_MOD_Z, LIS3L02DQ_INFO_MASK,
-		 2, 2, IIO_ST('s', 12, 16, 0), LIS3L02DQ_EVENT_MASK),
+	LIS3L02DQ_CHAN(0, IIO_MOD_X),
+	LIS3L02DQ_CHAN(1, IIO_MOD_Y),
+	LIS3L02DQ_CHAN(2, IIO_MOD_Z),
 	IIO_CHAN_SOFT_TIMESTAMP(3)
 };
 
-- 
1.7.0.4

