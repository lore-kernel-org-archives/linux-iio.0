Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48416 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754068Ab3E0TMv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 27 May 2013 15:12:51 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 15/19] input/ti_am335x_tsc: tiny cleanup
Date: Mon, 27 May 2013 21:12:02 +0200
Message-Id: <1369681926-22185-16-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Things that can be done to done without using make up:
- reduce config_inp from 20 elements to 4
  The loop goes 0…3 so elements 4…19 remain unused.
- put the shift for analog_line into one line, since config_inp is u32 we
  don't need to worry about sign extension,
- check if he DT values are 0…3 as expected
- replace "err = -EINVAL; goto err" with "return -EINVAL;" as there is no
  cleanup and this is less code
- pull out "config[analog_line[i]][0…3];" from the switch case and use
  magic to the 0…3 correct.
- since we removed so much lines, spent a few to get
  "config[an_line][wi_order];" done.
- get rid of "val32, wires_conf" and assign the values directly. This is
  just init code but we can still save a few cycles.
- remove titsc_config_wires() from resume path. ->bit_yn & friends are only
  written once and not changed so as long as we assume that our DDR will
  have no biflips we can skip that.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |  124 ++++++++++++-----------------
 1 file changed, 51 insertions(+), 73 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 0dbf3df..96accaa 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -59,7 +59,7 @@ struct titsc {
 	unsigned int		bckup_y;
 	bool			pen_down;
 	int			steps_to_configure;
-	int			config_inp[20];
+	u32			config_inp[4];
 	int			bit_xp, bit_xn, bit_yp, bit_yn;
 	int			inp_xp, inp_xn, inp_yp, inp_yn;
 };
@@ -115,69 +115,54 @@ static int regbit_map(int val)
 
 static int titsc_config_wires(struct titsc *ts_dev)
 {
-	int		analog_line[10], wire_order[10];
-	int		i, temp_bits, err;
+	u32 analog_line[4];
+	u32 wire_order[4];
+	int i, temp_bits;
 
 	for (i = 0; i < 4; i++) {
 		/*
 		 * Get the order in which TSC wires are attached
 		 * w.r.t. each of the analog input lines on the EVM.
 		 */
-		analog_line[i] = ts_dev->config_inp[i] & 0xF0;
-		analog_line[i] = analog_line[i] >> 4;
-
+		analog_line[i] = (ts_dev->config_inp[i] & 0xF0) >> 4;
 		wire_order[i] = ts_dev->config_inp[i] & 0x0F;
+		if (WARN_ON(analog_line[i] > 4))
+				return -EINVAL;
+		if (WARN_ON(wire_order[i] > 4))
+				return -EINVAL;
 	}
 
 	for (i = 0; i < 4; i++) {
+		int an_line;
+		int wi_order;
+
+		an_line = analog_line[i];
+		wi_order = wire_order[i];
+		temp_bits = config[an_line][wi_order];
+		if (temp_bits == 0)
+			return -EINVAL;
 		switch (wire_order[i]) {
 		case 0:
-			temp_bits = config[analog_line[i]][0];
-			if (temp_bits == 0) {
-				err = -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_xp = regbit_map(temp_bits);
-				ts_dev->inp_xp = analog_line[i];
-				break;
-			}
+			ts_dev->bit_xp = regbit_map(temp_bits);
+			ts_dev->inp_xp = analog_line[i];
+			break;
+
 		case 1:
-			temp_bits = config[analog_line[i]][1];
-			if (temp_bits == 0) {
-				err = -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_xn = regbit_map(temp_bits);
-				ts_dev->inp_xn = analog_line[i];
-				break;
-			}
+			ts_dev->bit_xn = regbit_map(temp_bits);
+			ts_dev->inp_xn = analog_line[i];
+			break;
+
 		case 2:
-			temp_bits = config[analog_line[i]][2];
-			if (temp_bits == 0) {
-				err = -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_yp = regbit_map(temp_bits);
-				ts_dev->inp_yp = analog_line[i];
-				break;
-			}
+			ts_dev->bit_yp = regbit_map(temp_bits);
+			ts_dev->inp_yp = analog_line[i];
+			break;
 		case 3:
-			temp_bits = config[analog_line[i]][3];
-			if (temp_bits == 0) {
-				err = -EINVAL;
-				goto ret;
-			} else {
-				ts_dev->bit_yn = regbit_map(temp_bits);
-				ts_dev->inp_yn = analog_line[i];
-				break;
-			}
+			ts_dev->bit_yn = regbit_map(temp_bits);
+			ts_dev->inp_yn = analog_line[i];
+			break;
 		}
 	}
-
 	return 0;
-
-ret:
-	return err;
 }
 
 static void titsc_step_config(struct titsc *ts_dev)
@@ -319,7 +304,6 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 	unsigned int z1, z2, z;
 	unsigned int fsm;
 	unsigned int diffx = 0, diffy = 0;
-	int i;
 
 	status = titsc_readl(ts_dev, REG_IRQSTATUS);
 	if (status & IRQENB_FIFO0THRES) {
@@ -387,11 +371,10 @@ static irqreturn_t titsc_irq(int irq, void *dev)
 }
 
 static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
-					struct titsc *ts_dev)
+		struct titsc *ts_dev)
 {
 	struct device_node *node = tscadc_dev->dev->of_node;
-	int err, i;
-	u32 val32, wires_conf[4];
+	int err;
 
 	if (!node)
 		return -EINVAL;
@@ -399,34 +382,30 @@ static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
 	node = of_get_child_by_name(node, "tsc");
 	if (!node)
 		return -EINVAL;
-	err = of_property_read_u32(node, "ti,wires", &val32);
+	err = of_property_read_u32(node, "ti,wires", &ts_dev->wires);
 	if (err < 0)
-		goto error_ret;
-	ts_dev->wires = val32;
-
-	err = of_property_read_u32(node,
-			"ti,x-plate-resistance", &val32);
-	if (err < 0)
-		goto error_ret;
-	ts_dev->x_plate_resistance = val32;
+		return err;
+	switch (ts_dev->wires) {
+	case 4:
+	case 5:
+	case 8:
+		break;
+	default:
+		return -EINVAL;
+	}
 
-	err = of_property_read_u32(node,
-			"ti,steps-to-configure", &val32);
+	err = of_property_read_u32(node, "ti,x-plate-resistance",
+			&ts_dev->x_plate_resistance);
 	if (err < 0)
-		goto error_ret;
-	ts_dev->steps_to_configure = val32;
+		return err;
 
-	err = of_property_read_u32_array(node, "ti,wire-config",
-			wires_conf, ARRAY_SIZE(wires_conf));
+	err = of_property_read_u32(node, "ti,steps-to-configure",
+			&ts_dev->steps_to_configure);
 	if (err < 0)
-		goto error_ret;
+		return err;
 
-	for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
-		ts_dev->config_inp[i] = wires_conf[i];
-	return 0;
-
-error_ret:
-	return err;
+	return of_property_read_u32_array(node, "ti,wire-config",
+			ts_dev->config_inp, ARRAY_SIZE(ts_dev->config_inp));
 }
 
 /*
@@ -545,7 +524,6 @@ static int titsc_resume(struct device *dev)
 				0x00);
 		titsc_writel(ts_dev, REG_IRQCLR, IRQENB_HW_PEN);
 	}
-	titsc_config_wires(ts_dev);
 	titsc_step_config(ts_dev);
 	titsc_writel(ts_dev, REG_FIFO0THR,
 			ts_dev->steps_to_configure);
-- 
1.7.10.4

