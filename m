Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:52609 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757018AbaKSWUA (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Nov 2014 17:20:00 -0500
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>,
	=?UTF-8?q?Kristina=20Mart=C5=A1enko?=
	<kristina.martsenko@gmail.com>, linux-iio@vger.kernel.org
Subject: [PATCH] iio: mxs-lradc: check ranges of ts properties
Date: Wed, 19 Nov 2014 22:19:50 +0000
Message-Id: <1416435590-13999-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The devicetree binding for mxs-lradc defines ranges for the
touchscreen properties. In order to avoid unexpected behavior like
division by zero, we better check these ranges during probe and
abort in error case.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/staging/iio/adc/mxs-lradc.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 6757f10..57c3cf6 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -1500,16 +1500,36 @@ static int mxs_lradc_probe_touchscreen(struct mxs_lradc *lradc,
 	if (ret == 0)
 		lradc->over_sample_cnt = adapt;

+	if (!lradc->over_sample_cnt || lradc->over_sample_cnt > 0x1f) {
+		dev_err(lradc->dev, "Invalid sample count (%u)\n",
+				    lradc->over_sample_cnt);
+		return -EINVAL;
+	}
+
 	lradc->over_sample_delay = 2;
 	ret = of_property_read_u32(lradc_node, "fsl,ave-delay", &adapt);
 	if (ret == 0)
 		lradc->over_sample_delay = adapt;

+	if (!lradc->over_sample_delay ||
+	    lradc->over_sample_delay > LRADC_DELAY_DELAY_MASK) {
+		dev_err(lradc->dev, "Invalid sample delay (%u)\n",
+				    lradc->over_sample_delay);
+		return -EINVAL;
+	}
+
 	lradc->settling_delay = 10;
 	ret = of_property_read_u32(lradc_node, "fsl,settling", &adapt);
 	if (ret == 0)
 		lradc->settling_delay = adapt;

+	if (!lradc->settling_delay ||
+	    lradc->settling_delay > LRADC_DELAY_DELAY_MASK) {
+		dev_err(lradc->dev, "Invalid settling delay (%u)\n",
+				    lradc->settling_delay);
+		return -EINVAL;
+	}
+
 	return 0;
 }

--
1.7.9.5

