Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] iio:ad7793: Fix ad7785 product ID
Date: Mon, 12 Oct 2015 14:56:28 +0200
Message-Id: <1444654588-25350-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

While the datasheet for the AD7785 lists 0xXB as the product ID the actual
product ID is 0xX3.

Fix the product ID otherwise the driver will reject the device due to non
matching IDs.

Fixes: e786cc26dcc5 ("staging:iio:ad7793: Implement stricter id checking")
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b84922a..710aee8 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -101,7 +101,7 @@
 #define AD7795_CH_AIN1M_AIN1M	8 /* AIN1(-) - AIN1(-) */
 
 /* ID Register Bit Designations (AD7793_REG_ID) */
-#define AD7785_ID		0xB
+#define AD7785_ID		0x3
 #define AD7792_ID		0xA
 #define AD7793_ID		0xB
 #define AD7794_ID		0xF
-- 
2.1.4
