Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58891 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319Ab3EVVIi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 22 May 2013 17:08:38 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Felipe Balbi <balbi@ti.com>, "Patil Rachna" <rachna@ti.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/7] iio/ti_am335x_adc: remove the else case
Date: Wed, 22 May 2013 23:08:14 +0200
Message-Id: <1369256897-25984-4-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
References: <1369256897-25984-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The DT support added in ("iio: adc: am335x: Add DT support")
added an else case which shifts the code to the righ for no reaseon.
This patch simply removes the pointless else case and shifts the code
back to the left.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/adc/ti_am335x_adc.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index f258eb0..ac78672 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -214,14 +214,11 @@ static int tiadc_probe(struct platform_device *pdev)
 		node = of_get_child_by_name(node, "adc");
 		if (!node)
 			return  -EINVAL;
-		else {
-			err = of_property_read_u32(node,
-					"ti,adc-channels", &val32);
-			if (err < 0)
-				goto err_free_device;
-			else
-				adc_dev->channels = val32;
-		}
+		err = of_property_read_u32(node,
+				"ti,adc-channels", &val32);
+		if (err < 0)
+			goto err_free_device;
+		adc_dev->channels = val32;
 	}
 
 	indio_dev->dev.parent = &pdev->dev;
-- 
1.7.10.4

