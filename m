Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:49778 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754702AbbG0WjR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:39:17 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 3/8] iio:adc:berlin2-adc: use GENMASK and BIT for masks
Date: Tue, 28 Jul 2015 00:38:59 +0200
Message-Id: <1e5a908f364c1fb18982be097ac83689820d64a8.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make use of GENMASK for consecutive bitmasks and BIT for single bitmasks.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index b31bcf4c7c90..ed31a0a8d78e 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -27,13 +27,13 @@
 #define  BERLIN2_SM_CTRL_SM_SOC_INT		BIT(1)
 #define  BERLIN2_SM_CTRL_SOC_SM_INT		BIT(2)
 #define  BERLIN2_SM_CTRL_ADC_SEL(x)		((x) << 5)	/* 0-15 */
-#define  BERLIN2_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
+#define  BERLIN2_SM_CTRL_ADC_SEL_MASK		GENMASK(8, 5)
 #define  BERLIN2_SM_CTRL_ADC_POWER		BIT(9)
 #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV2	(0x0 << 10)
 #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV3	(0x1 << 10)
 #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV4	(0x2 << 10)
 #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV8	(0x3 << 10)
-#define  BERLIN2_SM_CTRL_ADC_CLKSEL_MASK	(0x3 << 10)
+#define  BERLIN2_SM_CTRL_ADC_CLKSEL_MASK	GENMASK(11, 10)
 #define  BERLIN2_SM_CTRL_ADC_START		BIT(12)
 #define  BERLIN2_SM_CTRL_ADC_RESET		BIT(13)
 #define  BERLIN2_SM_CTRL_ADC_BANDGAP_RDY	BIT(14)
@@ -50,7 +50,7 @@
 #define  BERLIN2_SM_CTRL_TSEN_MODE_10_50	(0x1 << 22)	/* 10-50 C */
 #define  BERLIN2_SM_CTRL_TSEN_RESET		BIT(29)
 #define BERLIN2_SM_ADC_DATA			0x20
-#define  BERLIN2_SM_ADC_MASK			0x3ff
+#define  BERLIN2_SM_ADC_MASK			GENMASK(9, 0)
 #define BERLIN2_SM_ADC_STATUS			0x1c
 #define  BERLIN2_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
 #define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	GENMASK(15, 0)
@@ -65,9 +65,9 @@
 #define  BERLIN2_SM_TSEN_CTRL_START		BIT(8)
 #define  BERLIN2_SM_TSEN_CTRL_SETTLING_4	(0x0 << 21)	/* 4 us */
 #define  BERLIN2_SM_TSEN_CTRL_SETTLING_12	(0x1 << 21)	/* 12 us */
-#define  BERLIN2_SM_TSEN_CTRL_SETTLING_MASK	(0x1 << 21)
+#define  BERLIN2_SM_TSEN_CTRL_SETTLING_MASK	BIT(21)
 #define  BERLIN2_SM_TSEN_CTRL_TRIM(x)		((x) << 22)
-#define  BERLIN2_SM_TSEN_CTRL_TRIM_MASK		(0xf << 22)
+#define  BERLIN2_SM_TSEN_CTRL_TRIM_MASK		GENMASK(25, 22)
 
 struct berlin2_adc_priv {
 	struct regmap		*regmap;
-- 
2.4.6

