Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37067 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab3IIIDc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Sep 2013 04:03:32 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk
Subject: [PATCH 1/5] Staging/iio/adc/touchscreen/MXS: distinguish i.MX23's and i.MX28's LRADC
Date: Mon,  9 Sep 2013 10:03:17 +0200
Message-Id: <1378713801-1182-2-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1378713801-1182-1-git-send-email-jbe@pengutronix.de>
References: <1378713801-1182-1-git-send-email-jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The LRADC units in i.MX23 and i.MX28 differ and we need to distinguish both
SoC variants in order to make the touchscreen work on i.MX23

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/mxs-lradc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index a08c173..dffca90 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -174,6 +174,8 @@ struct mxs_lradc {
 
 	struct input_dev	*ts_input;
 	struct work_struct	ts_work;
+
+	enum mxs_lradc_id	soc;
 };
 
 #define	LRADC_CTRL0				0x00
@@ -920,6 +922,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	}
 
 	lradc = iio_priv(iio);
+	lradc->soc = (enum mxs_lradc_id)of_id->data;
 
 	/* Grab the memory area */
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.4.rc3

