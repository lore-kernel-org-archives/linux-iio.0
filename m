Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35288 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010Ab3FEQ2L (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:28:11 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: =?UTF-8?q?=5BPATCH=2018/22=5D=20input/ti=5Fam335x=5Fadc=3A=20use=20only=20FIFO0=20and=20clean=20up=20a=20little?=
Date: Wed,  5 Jun 2013 18:24:51 +0200
Message-Id: <1370449495-29981-19-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The driver programs a threshold of "coordiante_readouts" say 5. The
REG_FIFO0THR registers says it should it be programmed to "threshold
minus one". The driver does not expect just 5 coordinates but 5 * 2 + 2.
Multiplied by two because 5 for X and 5 for Y and plus 2 because we have
two Z.
The whole thing kind of works because It reads the 5 coordinates for X
and Y from FIFO0 and FIFO1 and the last element in each FIFO is ignored
within the loop and read later.
Nothing guaranties that FIFO1 is ready by the time it is read. In fact I
could see that that FIFO1 reaturns for Y channels 8,9, 10, 12, 6 and for
Y channel 7 for Z. The problem is that channel 7 and channel 12 got
somehow mixed up.
The other Problem is that FIFO1 is also used by the IIO part leading to
wrong results if both (tsc & adc) are used.

The patch tries to clean up the whole thing a little:
- Remove the +1 and -1 in REG_STEPCONFIG, REG_STEPDELAY and its counter
  part in the for loop. This is just confusing.

- Use only FIFO0 in TSC. The fifo has space for 64 entries so should be
  fine.

- Read the whole FIFO in one function and check the channel.

- in case we dawdle around, make sure we only read a multiple of our
  coordinate set. On the second interrupt we will cleanup the remaining
  enties.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c           |    2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c |   78 +++++++++++++++--------------
 include/linux/mfd/ti_am335x_tscadc.h      |    4 +-
 3 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 38f2415..031f8e5 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -76,7 +76,7 @@ static void tiadc_step_config(struct tiadc_device *adc_dev)
 
 	stepconfig = STEPCONFIG_AVG_16 | STEPCONFIG_FIFO1;
 
-	for (i = (steps + 1); i <= TOTAL_STEPS; i++) {
+	for (i = steps; i < TOTAL_STEPS; i++) {
 		tiadc_writel(adc_dev, REG_STEPCONFIG(i),
 				stepconfig | STEPCONFIG_INP(channels));
 		tiadc_writel(adc_dev, REG_STEPDELAY(i),
diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 7a76b14..fa9692c 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -120,11 +120,9 @@ static int titsc_config_wires(struct titsc *ts_dev)
 static void titsc_step_config(struct titsc *ts_dev)
 {
 	unsigned int	config;
-	unsigned int	stepenable = 0;
-	int i, total_steps;
-
-	/* Configure the Step registers */
-	total_steps = 2 * ts_dev->coordiante_readouts;
+	int i;
+	int end_step;
+	u32 stepenable;
 
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_xp;
@@ -142,7 +140,9 @@ static void titsc_step_config(struct titsc *ts_dev)
 		break;
 	}
 
-	for (i = 1; i <= ts_dev->coordiante_readouts; i++) {
+	/* 1 … coordiante_readouts is for X */
+	end_step = ts_dev->coordiante_readouts;
+	for (i = 0; i < end_step; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
@@ -150,7 +150,7 @@ static void titsc_step_config(struct titsc *ts_dev)
 	config = 0;
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_yn |
-			STEPCONFIG_INM_ADCREFM | STEPCONFIG_FIFO1;
+			STEPCONFIG_INM_ADCREFM;
 	switch (ts_dev->wires) {
 	case 4:
 		config |= ts_dev->bit_yp | STEPCONFIG_INP(ts_dev->inp_xp);
@@ -164,12 +164,13 @@ static void titsc_step_config(struct titsc *ts_dev)
 		break;
 	}
 
-	for (i = (ts_dev->coordiante_readouts + 1); i <= total_steps; i++) {
+	/* coordiante_readouts … coordiante_readouts * 2 is for Y */
+	end_step = ts_dev->coordiante_readouts * 2;
+	for (i = ts_dev->coordiante_readouts; i < end_step; i++) {
 		titsc_writel(ts_dev, REG_STEPCONFIG(i), config);
 		titsc_writel(ts_dev, REG_STEPDELAY(i), STEPCONFIG_OPENDLY);
 	}
 
-	config = 0;
 	/* Charge step configuration */
 	config = ts_dev->bit_xp | ts_dev->bit_yn |
 			STEPCHARGE_RFP_XPUL | STEPCHARGE_RFM_XNUR |
@@ -178,35 +179,39 @@ static void titsc_step_config(struct titsc *ts_dev)
 	titsc_writel(ts_dev, REG_CHARGECONFIG, config);
 	titsc_writel(ts_dev, REG_CHARGEDELAY, CHARGEDLY_OPENDLY);
 
-	config = 0;
-	/* Configure to calculate pressure */
+	/* coordiante_readouts * 2 … coordiante_readouts * 2 + 2 is for Z */
 	config = STEPCONFIG_MODE_HWSYNC |
 			STEPCONFIG_AVG_16 | ts_dev->bit_yp |
 			ts_dev->bit_xn | STEPCONFIG_INM_ADCREFM |
 			STEPCONFIG_INP(ts_dev->inp_xp);
-	titsc_writel(ts_dev, REG_STEPCONFIG(total_steps + 1), config);
-	titsc_writel(ts_dev, REG_STEPDELAY(total_steps + 1),
+	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
+	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
 
-	config |= STEPCONFIG_INP(ts_dev->inp_yn) | STEPCONFIG_FIFO1;
-	titsc_writel(ts_dev, REG_STEPCONFIG(total_steps + 2), config);
-	titsc_writel(ts_dev, REG_STEPDELAY(total_steps + 2),
+	end_step++;
+	config |= STEPCONFIG_INP(ts_dev->inp_yn);
+	titsc_writel(ts_dev, REG_STEPCONFIG(end_step), config);
+	titsc_writel(ts_dev, REG_STEPDELAY(end_step),
 			STEPCONFIG_OPENDLY);
 
 	/* The steps1 … end and bit 0 for TS_Charge */
-	stepenable = (1 << (total_steps + 2)) - 1;
+	stepenable = (1 << (end_step + 2)) - 1;
 	am335x_tsc_se_set(ts_dev->mfd_tscadc, stepenable);
 }
 
 static void titsc_read_coordinates(struct titsc *ts_dev,
-				    unsigned int *x, unsigned int *y)
+		u32 *x, u32 *y, u32 *z1, u32 *z2)
 {
 	unsigned int fifocount = titsc_readl(ts_dev, REG_FIFO0CNT);
 	unsigned int prev_val_x = ~0, prev_val_y = ~0;
 	unsigned int prev_diff_x = ~0, prev_diff_y = ~0;
 	unsigned int read, diff;
 	unsigned int i, channel;
+	unsigned int creads = ts_dev->coordiante_readouts;
 
+	*z1 = *z2 = 0;
+	if (fifocount % (creads * 2 + 2))
+		fifocount -= fifocount % (creads * 2 + 2);
 	/*
 	 * Delta filter is used to remove large variations in sampled
 	 * values from ADC. The filter tries to predict where the next
@@ -215,32 +220,32 @@ static void titsc_read_coordinates(struct titsc *ts_dev,
 	 * algorithm compares the difference with that of a present value,
 	 * if true the value is reported to the sub system.
 	 */
-	for (i = 0; i < fifocount - 1; i++) {
+	for (i = 0; i < fifocount; i++) {
 		read = titsc_readl(ts_dev, REG_FIFO0);
-		channel = read & 0xf0000;
-		channel = channel >> 0x10;
-		if ((channel >= 0) && (channel < ts_dev->coordiante_readouts)) {
-			read &= 0xfff;
+
+		channel = (read & 0xf0000) >> 16;
+		read &= 0xfff;
+		if (channel < creads) {
 			diff = abs(read - prev_val_x);
 			if (diff < prev_diff_x) {
 				prev_diff_x = diff;
 				*x = read;
 			}
 			prev_val_x = read;
-		}
 
-		read = titsc_readl(ts_dev, REG_FIFO1);
-		channel = read & 0xf0000;
-		channel = channel >> 0x10;
-		if ((channel >= ts_dev->coordiante_readouts) &&
-			(channel < (2 * ts_dev->coordiante_readouts - 1))) {
-			read &= 0xfff;
+		} else if (channel < creads * 2) {
 			diff = abs(read - prev_val_y);
 			if (diff < prev_diff_y) {
 				prev_diff_y = diff;
 				*y = read;
 			}
 			prev_val_y = read;
+
+		} else if (channel < creads * 2 + 1) {
+			*z1 = read;
+
+		} else if (channel < creads * 2 + 2) {
+			*z2 = read;
 		}
 	}
 }
@@ -256,10 +261,8 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
-		titsc_read_coordinates(ts_dev, &x, &y);
 
-		z1 = titsc_readl(ts_dev, REG_FIFO0) & 0xfff;
-		z2 = titsc_readl(ts_dev, REG_FIFO1) & 0xfff;
+		titsc_read_coordinates(ts_dev, &x, &y, &z1, &z2);
 
 		if (ts_dev->pen_down && z1 != 0 && z2 != 0) {
 			/*
@@ -267,10 +270,10 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 			 * Resistance(touch) = x plate resistance *
 			 * x postion/4096 * ((z2 / z1) - 1)
 			 */
-			z = z2 - z1;
+			z = z1 - z2;
 			z *= x;
 			z *= ts_dev->x_plate_resistance;
-			z /= z1;
+			z /= z2;
 			z = (z + 2047) >> 12;
 
 			if (z <= MAX_12BIT) {
@@ -395,7 +398,8 @@ static int titsc_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 	titsc_step_config(ts_dev);
-	titsc_writel(ts_dev, REG_FIFO0THR, ts_dev->coordiante_readouts);
+	titsc_writel(ts_dev, REG_FIFO0THR,
+			ts_dev->coordiante_readouts * 2 + 2 - 1);
 
 	input_dev->name = "ti-tsc";
 	input_dev->dev.parent = &pdev->dev;
@@ -472,7 +476,7 @@ static int titsc_resume(struct device *dev)
 	}
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
-			ts_dev->coordiante_readouts);
+			ts_dev->coordiante_readouts * 2 + 2 - 1);
 	return 0;
 }
 
diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
index cd8686b..fe6223c 100644
--- a/include/linux/mfd/ti_am335x_tscadc.h
+++ b/include/linux/mfd/ti_am335x_tscadc.h
@@ -30,8 +30,8 @@
 #define REG_IDLECONFIG		0x058
 #define REG_CHARGECONFIG	0x05C
 #define REG_CHARGEDELAY		0x060
-#define REG_STEPCONFIG(n)	(0x64 + ((n - 1) * 8))
-#define REG_STEPDELAY(n)	(0x68 + ((n - 1) * 8))
+#define REG_STEPCONFIG(n)	(0x64 + ((n) * 8))
+#define REG_STEPDELAY(n)	(0x68 + ((n) * 8))
 #define REG_FIFO0CNT		0xE4
 #define REG_FIFO0THR		0xE8
 #define REG_FIFO1CNT		0xF0
-- 
1.7.10.4

