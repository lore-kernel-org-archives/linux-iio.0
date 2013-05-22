Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58876 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab3EVVIh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:08:37 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>, "Patil Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/7] input/ti_am_335x_tsc: remove the else case
Date: Wed, 22 May 2013 23:08:11 +0200
Message-Id: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The DT support added in ("input: touchscreen: am335x: Add DT support")
added an else case which shifts the code to the righ for no reaseon.
This patch simply removes the pointless else case and shifts the code
back to the left.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/input/touchscreen/ti_am335x_tsc.c |   63 +++++++++++++----------------
 1 file changed, 28 insertions(+), 35 deletions(-)

diff --git a/drivers/input/touchscreen/ti_am335x_tsc.c b/drivers/input/touchscreen/ti_am335x_tsc.c
index 4fcf72f..20f4505 100644
--- a/drivers/input/touchscreen/ti_am335x_tsc.c
+++ b/drivers/input/touchscreen/ti_am335x_tsc.c
@@ -396,41 +396,34 @@ static int titsc_parse_dt(struct ti_tscadc_dev *tscadc_dev,
 
 	if (!node)
 		return -EINVAL;
-	else {
-		node = of_get_child_by_name(node, "tsc");
-		if (!node)
-			return -EINVAL;
-		else {
-			err = of_property_read_u32(node, "ti,wires", &val32);
-			if (err < 0)
-				goto error_ret;
-			else
-				ts_dev->wires = val32;
-
-			err = of_property_read_u32(node,
-					"ti,x-plate-resistance", &val32);
-			if (err < 0)
-				goto error_ret;
-			else
-				ts_dev->x_plate_resistance = val32;
-
-			err = of_property_read_u32(node,
-					"ti,steps-to-configure", &val32);
-			if (err < 0)
-				goto error_ret;
-			else
-				ts_dev->steps_to_configure = val32;
-
-			err = of_property_read_u32_array(node, "ti,wire-config",
-					wires_conf, ARRAY_SIZE(wires_conf));
-			if (err < 0)
-				goto error_ret;
-			else {
-				for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
-					ts_dev->config_inp[i] = wires_conf[i];
-			}
-		}
-	}
+
+	node = of_get_child_by_name(node, "tsc");
+	if (!node)
+		return -EINVAL;
+	err = of_property_read_u32(node, "ti,wires", &val32);
+	if (err < 0)
+		goto error_ret;
+	ts_dev->wires = val32;
+
+	err = of_property_read_u32(node,
+			"ti,x-plate-resistance", &val32);
+	if (err < 0)
+		goto error_ret;
+	ts_dev->x_plate_resistance = val32;
+
+	err = of_property_read_u32(node,
+			"ti,steps-to-configure", &val32);
+	if (err < 0)
+		goto error_ret;
+	ts_dev->steps_to_configure = val32;
+
+	err = of_property_read_u32_array(node, "ti,wire-config",
+			wires_conf, ARRAY_SIZE(wires_conf));
+	if (err < 0)
+		goto error_ret;
+
+	for (i = 0; i < ARRAY_SIZE(wires_conf); i++)
+		ts_dev->config_inp[i] = wires_conf[i];
 	return 0;
 
 error_ret:
-- 
1.7.10.4

