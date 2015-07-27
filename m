Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:50707 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546AbbG0WjP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 27 Jul 2015 18:39:15 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH v2 1/8] iio:adc:berlin2-adc: Fix register definition
Date: Tue, 28 Jul 2015 00:38:57 +0200
Message-Id: <b29e36386c3542057638334db8049cc64486157f.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438035998.git.knaack.h@gmx.de>
References: <cover.1438035998.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Active channel number is stored in BERLIN2_SM_CTRL as value, instead of a
bit map.
The masks for channel interrupts and data ready are a 16 bits wide bit
map each, instead of just 4 bits.

Also correct the data mask for the temperature sensor, which was
Reported-by: Antoine Tenart <antoine.tenart@free-electrons.com>

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/adc/berlin2-adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index aecc9ad995ad..26fa6e6cb624 100644
--- a/drivers/iio/adc/berlin2-adc.c
+++ b/drivers/iio/adc/berlin2-adc.c
@@ -26,7 +26,7 @@
 #define BERLIN2_SM_CTRL				0x14
 #define  BERLIN2_SM_CTRL_SM_SOC_INT		BIT(1)
 #define  BERLIN2_SM_CTRL_SOC_SM_INT		BIT(2)
-#define  BERLIN2_SM_CTRL_ADC_SEL(x)		(BIT(x) << 5)	/* 0-15 */
+#define  BERLIN2_SM_CTRL_ADC_SEL(x)		((x) << 5)	/* 0-15 */
 #define  BERLIN2_SM_CTRL_ADC_SEL_MASK		(0xf << 5)
 #define  BERLIN2_SM_CTRL_ADC_POWER		BIT(9)
 #define  BERLIN2_SM_CTRL_ADC_CLKSEL_DIV2	(0x0 << 10)
@@ -53,14 +53,14 @@
 #define  BERLIN2_SM_ADC_MASK			0x3ff
 #define BERLIN2_SM_ADC_STATUS			0x1c
 #define  BERLIN2_SM_ADC_STATUS_DATA_RDY(x)	BIT(x)		/* 0-15 */
-#define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	0xf
+#define  BERLIN2_SM_ADC_STATUS_DATA_RDY_MASK	GENMASK(15, 0)
 #define  BERLIN2_SM_ADC_STATUS_INT_EN(x)	(BIT(x) << 16)	/* 0-15 */
-#define  BERLIN2_SM_ADC_STATUS_INT_EN_MASK	(0xf << 16)
+#define  BERLIN2_SM_ADC_STATUS_INT_EN_MASK	GENMASK(31, 16)
 #define BERLIN2_SM_TSEN_STATUS			0x24
 #define  BERLIN2_SM_TSEN_STATUS_DATA_RDY	BIT(0)
 #define  BERLIN2_SM_TSEN_STATUS_INT_EN		BIT(1)
 #define BERLIN2_SM_TSEN_DATA			0x28
-#define  BERLIN2_SM_TSEN_MASK			0xfff
+#define  BERLIN2_SM_TSEN_MASK			GENMASK(9, 0)
 #define BERLIN2_SM_TSEN_CTRL			0x74
 #define  BERLIN2_SM_TSEN_CTRL_START		BIT(8)
 #define  BERLIN2_SM_TSEN_CTRL_SETTLING_4	(0x0 << 21)	/* 4 us */
-- 
2.4.6

