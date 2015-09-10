Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:36743 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104AbbIJQdF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 12:33:05 -0400
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 6/6] Staging: comedi: Prefer using the BIT macro
Date: Thu, 10 Sep 2015 22:02:41 +0530
Message-Id: <1441902761-11190-3-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
References: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro

This was done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/comedi/drivers/mpc624.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/staging/comedi/drivers/mpc624.c b/drivers/staging/comedi/drivers/mpc624.c
index 0207b8e..8e92041 100644
--- a/drivers/staging/comedi/drivers/mpc624.c
+++ b/drivers/staging/comedi/drivers/mpc624.c
@@ -66,24 +66,24 @@ Configuration Options:
 #define MPC624_IRQ_MASK         6 /* IRQ masking enable/disable */
 
 /* Register bits' names */
-#define MPC624_ADBUSY           (1<<5)
-#define MPC624_ADSDO            (1<<4)
-#define MPC624_ADFO             (1<<3)
-#define MPC624_ADCS             (1<<2)
-#define MPC624_ADSCK            (1<<1)
-#define MPC624_ADSDI            (1<<0)
+#define MPC624_ADBUSY           BIT(5)
+#define MPC624_ADSDO            BIT(4)
+#define MPC624_ADFO             BIT(3)
+#define MPC624_ADCS             BIT(2)
+#define MPC624_ADSCK            BIT(1)
+#define MPC624_ADSDI            BIT(0)
 
 /* SDI Speed/Resolution Programming bits */
-#define MPC624_OSR4             (1<<31)
-#define MPC624_OSR3             (1<<30)
-#define MPC624_OSR2             (1<<29)
-#define MPC624_OSR1             (1<<28)
-#define MPC624_OSR0             (1<<27)
+#define MPC624_OSR4             BIT(31)
+#define MPC624_OSR3             BIT(30)
+#define MPC624_OSR2             BIT(29)
+#define MPC624_OSR1             BIT(28)
+#define MPC624_OSR0             BIT(27)
 
 /* 32-bit output value bits' names */
-#define MPC624_EOC_BIT          (1<<31)
-#define MPC624_DMY_BIT          (1<<30)
-#define MPC624_SGN_BIT          (1<<29)
+#define MPC624_EOC_BIT          BIT(31)
+#define MPC624_DMY_BIT          BIT(30)
+#define MPC624_SGN_BIT          BIT(29)
 
 /* Conversion speeds */
 /* OSR4 OSR3 OSR2 OSR1 OSR0  Conversion rate  RMS noise  ENOB^
@@ -189,7 +189,7 @@ static int mpc624_ai_rinsn(struct comedi_device *dev,
 			outb(0, dev->iobase + MPC624_ADC);
 			udelay(1);
 
-			if (data_out & (1 << 31)) { /*  the next bit is a 1 */
+			if (data_out & BIT(31)) { /*  the next bit is a 1 */
 				/*  Set the ADSDI line (send to MPC624) */
 				outb(MPC624_ADSDI, dev->iobase + MPC624_ADC);
 				udelay(1);
-- 
2.1.4

