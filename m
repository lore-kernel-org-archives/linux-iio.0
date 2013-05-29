Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57936 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759706Ab3E2RKF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 May 2013 13:10:05 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	balbi@ti.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] input/ti_am335x_tsc: fold regbit_map() and simplfy
Date: Wed, 29 May 2013 19:09:54 +0200
Message-Id: <1369847397-27451-4-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If we put the values which are looked up by regbit_map() directly in the
config array then we can remove the function.
And now when I look at it I don't understand why the array has to have
two dimensions. One does it, too. And while at it, the description says
that AIN0 … AIN7 can be used so allow this.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   76 ++++++++---------------------
 1 file changed, 19 insertions(+), 57 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 7c97fc7..63cee57 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -37,15 +37,11 @@
 #define TSCADC_DELTA_X		15
 #define TSCADC_DELTA_Y		15
 
-/*
- * Refer to function regbit_map() to
- * map the values in the matrix.
- */
-static int config[4][4] = {
-		{1,	0,	1,	0},
-		{2,	3,	2,	3},
-		{4,	5,	4,	5},
-		{0,	6,	0,	6}
+static const int config_pins[] = {
+		XPP,
+		XNN,
+		YPP,
+		YNN,
 };
 
 struct titsc {
@@ -79,45 +75,11 @@ static void titsc_writel(struct titsc *tsc, unsigned int reg,
 	regmap_write(tsc->mfd_tscadc->regmap_tscadc, reg, val);
 }
 
-/*
- * Each of the analog lines are mapped
- * with one or two register bits,
- * which can be either pulled high/low
- * depending on the value to be read.
- */
-static int regbit_map(int val)
-{
-	int map_bits = 0;
-
-	switch (val) {
-	case 1:
-		map_bits = XPP;
-		break;
-	case 2:
-		map_bits = XNP;
-		break;
-	case 3:
-		map_bits = XNN;
-		break;
-	case 4:
-		map_bits = YPP;
-		break;
-	case 5:
-		map_bits = YPN;
-		break;
-	case 6:
-		map_bits = YNN;
-		break;
-	}
-
-	return map_bits;
-}
-
 static int titsc_config_wires(struct titsc *ts_dev)
 {
 	u32 analog_line[4];
 	u32 wire_order[4];
-	int i, temp_bits;
+	int i, bit_cfg;
 
 	for (i = 0; i < 4; i++) {
 		/*
@@ -126,9 +88,9 @@ static int titsc_config_wires(struct titsc *ts_dev)
 		 */
 		analog_line[i] = (ts_dev->config_inp[i] & 0xF0) >> 4;
 		wire_order[i] = ts_dev->config_inp[i] & 0x0F;
-		if (WARN_ON(analog_line[i] > 4))
+		if (WARN_ON(analog_line[i] > 7))
 				return -EINVAL;
-		if (WARN_ON(wire_order[i] > 4))
+		if (WARN_ON(wire_order[i] > ARRAY_SIZE(config_pins)))
 				return -EINVAL;
 	}
 
@@ -138,27 +100,27 @@ static int titsc_config_wires(struct titsc *ts_dev)
 
 		an_line = analog_line[i];
 		wi_order = wire_order[i];
-		temp_bits = config[an_line][wi_order];
-		if (temp_bits == 0)
+		bit_cfg = config_pins[wi_order];
+		if (bit_cfg == 0)
 			return -EINVAL;
-		switch (wire_order[i]) {
+		switch (wi_order) {
 		case 0:
-			ts_dev->bit_xp = regbit_map(temp_bits);
-			ts_dev->inp_xp = analog_line[i];
+			ts_dev->bit_xp = bit_cfg;
+			ts_dev->inp_xp = an_line;
 			break;
 
 		case 1:
-			ts_dev->bit_xn = regbit_map(temp_bits);
-			ts_dev->inp_xn = analog_line[i];
+			ts_dev->bit_xn = bit_cfg;
+			ts_dev->inp_xn = an_line;
 			break;
 
 		case 2:
-			ts_dev->bit_yp = regbit_map(temp_bits);
-			ts_dev->inp_yp = analog_line[i];
+			ts_dev->bit_yp = bit_cfg;
+			ts_dev->inp_yp = an_line;
 			break;
 		case 3:
-			ts_dev->bit_yn = regbit_map(temp_bits);
-			ts_dev->inp_yn = analog_line[i];
+			ts_dev->bit_yn = bit_cfg;
+			ts_dev->inp_yn = an_line;
 			break;
 		}
 	}
-- 
1.7.10.4

