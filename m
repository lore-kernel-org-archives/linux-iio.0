Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35166 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756085Ab3FEQZN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Jun 2013 12:25:13 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	"Patil, Rachna" <rachna@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/22] iio/ti_am335x_adc: Add DT support
Date: Wed,  5 Jun 2013 18:24:41 +0200
Message-Id: <1370449495-29981-9-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Patil, Rachna" <rachna@ti.com>

Add DT support for client ADC driver.

[ panto@antoniou-consulting.com : use of_get_child_by_name
	instead of of_find_node_by_name ]

Acked-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Patil, Rachna <rachna@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
[bigeasy: shift the code to the left, fix clean up on
          of_get_child_by_name() failer]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 543b9c4..95bcd56 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -22,6 +22,8 @@
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/iio/iio.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
 
 #include <linux/mfd/ti_am335x_tscadc.h>
 #include <linux/platform_data/ti_am335x_adc.h>
@@ -152,11 +154,12 @@ static int tiadc_probe(struct platform_device *pdev)
 	struct iio_dev		*indio_dev;
 	struct tiadc_device	*adc_dev;
 	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
-	struct mfd_tscadc_board	*pdata;
+	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
+	struct device_node	*node = tscadc_dev->dev->of_node;
 	int			err;
+	u32			val32;
 
-	pdata = tscadc_dev->dev->platform_data;
-	if (!pdata || !pdata->adc_init) {
+	if (!pdata && !node) {
 		dev_err(&pdev->dev, "Could not find platform data\n");
 		return -EINVAL;
 	}
@@ -170,7 +173,21 @@ static int tiadc_probe(struct platform_device *pdev)
 	adc_dev = iio_priv(indio_dev);
 
 	adc_dev->mfd_tscadc = tscadc_dev;
-	adc_dev->channels = pdata->adc_init->adc_channels;
+
+	if (pdata)
+		adc_dev->channels = pdata->adc_init->adc_channels;
+	else {
+		node = of_get_child_by_name(node, "adc");
+		if (!node) {
+			err = -EINVAL;
+			goto err_free_device;
+		}
+		err = of_property_read_u32(node,
+				"ti,adc-channels", &val32);
+		if (err < 0)
+			goto err_free_device;
+		adc_dev->channels = val32;
+	}
 
 	indio_dev->dev.parent = &pdev->dev;
 	indio_dev->name = dev_name(&pdev->dev);
-- 
1.7.10.4

