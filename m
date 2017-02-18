Return-Path: <SRS0=4enr=Z7=gmail.com=karniksayli1995@kernel.org>
Date: Sun, 19 Feb 2017 01:50:32 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] staging: iio: ad7152: Use BIT() macro for left shifting 1
Message-ID: <2f967b89d81cadb4a96a3ce38e4bd5571fb2bd8c.1487448326.git.karniksayli1995@gmail.com>
References: <cover.1487448326.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487448326.git.karniksayli1995@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Replace left shifting on 1 with the BIT(x) macro as suggested by
checkpatch.pl.

Done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index b91b50f..0c97d5a 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -41,30 +41,30 @@
 #define AD7152_REG_CFG2			26
 
 /* Status Register Bit Designations (AD7152_REG_STATUS) */
-#define AD7152_STATUS_RDY1		(1 << 0)
-#define AD7152_STATUS_RDY2		(1 << 1)
-#define AD7152_STATUS_C1C2		(1 << 2)
-#define AD7152_STATUS_PWDN		(1 << 7)
+#define AD7152_STATUS_RDY1		BIT(0)
+#define AD7152_STATUS_RDY2		BIT(1)
+#define AD7152_STATUS_C1C2		BIT(2)
+#define AD7152_STATUS_PWDN		BIT(7)
 
 /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
-#define AD7152_SETUP_CAPDIFF		(1 << 5)
+#define AD7152_SETUP_CAPDIFF		BIT(5)
 #define AD7152_SETUP_RANGE_2pF		(0 << 6)
-#define AD7152_SETUP_RANGE_0_5pF	(1 << 6)
+#define AD7152_SETUP_RANGE_0_5pF	BIT(6)
 #define AD7152_SETUP_RANGE_1pF		(2 << 6)
 #define AD7152_SETUP_RANGE_4pF		(3 << 6)
 #define AD7152_SETUP_RANGE(x)		((x) << 6)
 
 /* Config Register Bit Designations (AD7152_REG_CFG) */
-#define AD7152_CONF_CH2EN		(1 << 3)
-#define AD7152_CONF_CH1EN		(1 << 4)
+#define AD7152_CONF_CH2EN		BIT(3)
+#define AD7152_CONF_CH1EN		BIT(4)
 #define AD7152_CONF_MODE_IDLE		(0 << 0)
-#define AD7152_CONF_MODE_CONT_CONV	(1 << 0)
+#define AD7152_CONF_MODE_CONT_CONV	BIT(0)
 #define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
 #define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
 #define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
 
 /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
-#define AD7152_CAPDAC_DACEN		(1 << 7)
+#define AD7152_CAPDAC_DACEN		BIT(7)
 #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
 
 /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-- 
2.7.4
