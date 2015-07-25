Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:57487 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755132AbbGYWnk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 25 Jul 2015 18:43:40 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
Subject: [PATCH 1/8] iio:adc:berlin2-adc: Fix register definition
Date: Sun, 26 Jul 2015 00:43:19 +0200
Message-Id: <57c4e77919394abab3c4f93c84d469221ba081f4.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
In-Reply-To: <cover.1437862404.git.knaack.h@gmx.de>
References: <cover.1437862404.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Active channel number is stored in BERLIN2_SM_CTRL as value, instead of a
bit map.
The masks for channel interrupts and data ready are a 16 bits wide bit
map each, instead of just 4 bits.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
Driver analysis indicates that only one ADC channel can be sampled at a
time, and this channel number is stored in BERLIN2_SM_CTRL as a value,
instead of a bit map.
In register BERLIN2_SM_ADC_STATUS however, interrupts can be enabled for
each ADC channel, and data ready is indicated for each ADC channel,
too - in both cases as a bit map. Since there are 8 channels available,
both masks should be at least 8 bits wide. But as the comment indicates,
there are 16 bits for each mask.

 drivers/iio/adc/berlin2-adc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/berlin2-adc.c b/drivers/iio/adc/berlin2-adc.c
index aecc9ad995ad..97863d1ba79a 100644
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
@@ -53,9 +53,9 @@
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
-- 
2.4.3

