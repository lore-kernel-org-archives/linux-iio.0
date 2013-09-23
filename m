Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51053 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752298Ab3IWOgw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 10:36:52 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
	marex@denx.de, fabio.estevam@freescale.com, jic23@cam.ac.uk,
	linux-input@vger.kernel.org
Subject: [PATCH 2/9] Staging/iio/adc/touchscreen/MXS: distinguish i.MX23's and i.MX28's LRADC
Date: Mon, 23 Sep 2013 16:36:31 +0200
Message-Id: <1379946998-23041-3-git-send-email-jbe@pengutronix.de>
In-Reply-To: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
References: <1379946998-23041-1-git-send-email-jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The LRADC units in i.MX23 and i.MX28 differ and we need to distinguish both
SoC variants in order to make the touchscreen work on i.MX23

Signed-off-by: Juergen Beisert <jbe@pengutronix.de>
CC: linux-arm-kernel@lists.infradead.org
CC: linux-input@vger.kernel.org
CC: devel@driverdev.osuosl.org
CC: Marek Vasut <marex@denx.de>
CC: Fabio Estevam <fabio.estevam@freescale.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/adc/mxs-lradc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 00b61ac..3abc91f 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -177,6 +177,8 @@ struct mxs_lradc {
 
 	struct input_dev	*ts_input;
 	struct work_struct	ts_work;
+
+	enum mxs_lradc_id	soc;
 };
 
 #define	LRADC_CTRL0				0x00
@@ -923,6 +925,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	}
 
 	lradc = iio_priv(iio);
+	lradc->soc = (enum mxs_lradc_id)of_id->data;
 
 	/* Grab the memory area */
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.8.4.rc3

