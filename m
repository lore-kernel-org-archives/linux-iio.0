Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <Lars-Peter.Clausen@analog.com>,
	<dan.carpenter@oracle.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH RESEND V2 2/4] iio: frequency: adf4350: cast value to unsigned to make code checkers happy
Date: Mon, 3 Jun 2013 15:30:47 +0200
Message-ID: <1370266249-26338-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
References: <1370266249-26338-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 include/linux/iio/frequency/adf4350.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/frequency/adf4350.h b/include/linux/iio/frequency/adf4350.h
index be91f34..ffd8c8f 100644
--- a/include/linux/iio/frequency/adf4350.h
+++ b/include/linux/iio/frequency/adf4350.h
@@ -1,7 +1,7 @@
 /*
  * ADF4350/ADF4351 SPI PLL driver
  *
- * Copyright 2012 Analog Devices Inc.
+ * Copyright 2012-2013 Analog Devices Inc.
  *
  * Licensed under the GPL-2.
  */
@@ -41,7 +41,7 @@
 #define ADF4350_REG2_RDIV2_EN			(1 << 24)
 #define ADF4350_REG2_RMULT2_EN			(1 << 25)
 #define ADF4350_REG2_MUXOUT(x)			((x) << 26)
-#define ADF4350_REG2_NOISE_MODE(x)		((x) << 29)
+#define ADF4350_REG2_NOISE_MODE(x)		(((unsigned)(x)) << 29)
 #define ADF4350_MUXOUT_THREESTATE		0
 #define ADF4350_MUXOUT_DVDD			1
 #define ADF4350_MUXOUT_GND			2
-- 
1.7.9.5
