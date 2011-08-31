Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 03/12] iio: ad7291: Fix AD7291_T_SENSE_MASK
Date: Wed, 31 Aug 2011 12:57:31 +0200
Message-ID: <1314788260-5791-3-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
References: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

AD7291_T_SENSE_MASK must set bit-7.
Change definition style.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index d47df4a..dda6bcb 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -37,30 +37,30 @@
 #define AD7291_T_AVERAGE		3
 #define AD7291_VOLTAGE_LIMIT_BASE	4
 #define AD7291_VOLTAGE_LIMIT_COUNT	8
-#define AD7291_T_SENSE_HIGH		0x1c
-#define AD7291_T_SENSE_LOW		0x1d
-#define AD7291_T_SENSE_HYST		0x1e
-#define AD7291_VOLTAGE_ALERT_STATUS	0x1f
+#define AD7291_T_SENSE_HIGH		0x1C
+#define AD7291_T_SENSE_LOW		0x1D
+#define AD7291_T_SENSE_HYST		0x1E
+#define AD7291_VOLTAGE_ALERT_STATUS	0x1F
 #define AD7291_T_ALERT_STATUS		0x20
 
 /*
  * AD7291 command
  */
-#define AD7291_AUTOCYCLE		0x1
-#define AD7291_RESET			0x2
-#define AD7291_ALERT_CLEAR		0x4
-#define AD7291_ALERT_POLARITY		0x8
-#define AD7291_EXT_REF			0x10
-#define AD7291_NOISE_DELAY		0x20
-#define AD7291_T_SENSE_MASK		0x40
-#define AD7291_VOLTAGE_MASK		0xff00
+#define AD7291_AUTOCYCLE		(1 << 0)
+#define AD7291_RESET			(1 << 1)
+#define AD7291_ALERT_CLEAR		(1 << 2)
+#define AD7291_ALERT_POLARITY		(1 << 3)
+#define AD7291_EXT_REF			(1 << 4)
+#define AD7291_NOISE_DELAY		(1 << 5)
+#define AD7291_T_SENSE_MASK		(1 << 7)
+#define AD7291_VOLTAGE_MASK		0xFF00
 #define AD7291_VOLTAGE_OFFSET		0x8
 
 /*
  * AD7291 value masks
  */
-#define AD7291_CHANNEL_MASK		0xf000
-#define AD7291_VALUE_MASK		0xfff
+#define AD7291_CHANNEL_MASK		0xF000
+#define AD7291_VALUE_MASK		0xFFF
 #define AD7291_T_VALUE_SIGN		0x400
 #define AD7291_T_VALUE_FLOAT_OFFSET	2
 #define AD7291_T_VALUE_FLOAT_MASK	0x2
-- 
1.7.0.4
