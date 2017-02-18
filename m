Return-Path: <SRS0=4enr=Z7=gmail.com=karniksayli1995@kernel.org>
Date: Sun, 19 Feb 2017 01:51:39 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/3] staging: iio: ad7152: Use GENMASK() macro for left shifts
Message-ID: <92240a3dca0138880fe47a7df0a5e6df869c8199.1487448326.git.karniksayli1995@gmail.com>
References: <cover.1487448326.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487448326.git.karniksayli1995@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Use GENMASK() macro for left shifting integers.
Done using coccinelle:
@@ int a,b; @@

-(a << b)
+GENMASK(a, b)

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 0c97d5a..988b89b 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -48,27 +48,27 @@
 
 /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
 #define AD7152_SETUP_CAPDIFF		BIT(5)
-#define AD7152_SETUP_RANGE_2pF		(0 << 6)
+#define AD7152_SETUP_RANGE_2pF		GENMASK(0, 6)
 #define AD7152_SETUP_RANGE_0_5pF	BIT(6)
-#define AD7152_SETUP_RANGE_1pF		(2 << 6)
-#define AD7152_SETUP_RANGE_4pF		(3 << 6)
+#define AD7152_SETUP_RANGE_1pF		GENMASK(2, 6)
+#define AD7152_SETUP_RANGE_4pF		GENMASK(3, 6)
 #define AD7152_SETUP_RANGE(x)		((x) << 6)
 
 /* Config Register Bit Designations (AD7152_REG_CFG) */
 #define AD7152_CONF_CH2EN		BIT(3)
 #define AD7152_CONF_CH1EN		BIT(4)
-#define AD7152_CONF_MODE_IDLE		(0 << 0)
+#define AD7152_CONF_MODE_IDLE		GENMASK(0, 0)
 #define AD7152_CONF_MODE_CONT_CONV	BIT(0)
-#define AD7152_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7152_CONF_MODE_OFFS_CAL	(5 << 0)
-#define AD7152_CONF_MODE_GAIN_CAL	(6 << 0)
+#define AD7152_CONF_MODE_SINGLE_CONV	GENMASK(2, 0)
+#define AD7152_CONF_MODE_OFFS_CAL	GENMASK(5, 0)
+#define AD7152_CONF_MODE_GAIN_CAL	GENMASK(6, 0)
 
 /* Capdac Register Bit Designations (AD7152_REG_CAPDAC_XXX) */
 #define AD7152_CAPDAC_DACEN		BIT(7)
 #define AD7152_CAPDAC_DACP(x)		((x) & 0x1F)
 
 /* CFG2 Register Bit Designations (AD7152_REG_CFG2) */
-#define AD7152_CFG2_OSR(x)		(((x) & 0x3) << 4)
+#define AD7152_CFG2_OSR(x)		GENMASK(((x) & 0x3), 4)
 
 enum {
 	AD7152_DATA,
-- 
2.7.4
