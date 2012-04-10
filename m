Return-Path: <jic23@hermes.cam.ac.uk>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/14] staging:iio:accel:lis3l02dq unwind use of IIO_CHAN macro.
Date: Tue, 10 Apr 2012 21:21:42 +0100
Message-Id: <1334089310-22576-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1334089310-22576-1-git-send-email-jic23@kernel.org>
References: <1334089310-22576-1-git-send-email-jic23@kernel.org>
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This macro is being removed to simplify ongoing maintenance
so we need to unwind and remaining users.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/lis3l02dq_core.c |   25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

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
1.7.9.4
