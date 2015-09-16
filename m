Return-Path: <shraddha.6596@gmail.com>
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Cc: linux-iio@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH] Staging: iio: cdc: Remove unused macro
Date: Wed, 16 Sep 2015 18:14:13 +0530
Message-Id: <1442407453-6030-1-git-send-email-shraddha.6596@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove the macro since it's not used anywhere throughout the kernel

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 10fa372..f5a807c 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -43,7 +43,6 @@
 #define AD7746_REG_CAP_GAINH		15
 #define AD7746_REG_CAP_GAINL		16
 #define AD7746_REG_VOLT_GAINH		17
-#define AD7746_REG_VOLT_GAINL		18
 
 /* Status Register Bit Designations (AD7746_REG_STATUS) */
 #define AD7746_STATUS_EXCERR		BIT(3)
-- 
2.1.4
