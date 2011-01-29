Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.work-microwave.de ([62.245.205.51]:47822 "EHLO
	work-microwave.de" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753285Ab1A2P1Y (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 29 Jan 2011 10:27:24 -0500
From: stigge@antcom.de
To: linux-iio@vger.kernel.org, greg@kroah.com
Cc: Roland Stigge <stigge@antcom.de>
Subject: [PATCH] ad7476_core.c: Fixed i2c -> spi documentation typo
Date: Sat, 29 Jan 2011 16:27:17 +0100
Message-Id: <1296314837-28136-1-git-send-email-stigge@antcom.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ad7476_core.c: Fixed i2c -> spi documentation typo

Minor documentation fix in comment

Signed-off-by: Roland Stigge <stigge@antcom.de>

diff --git a/drivers/staging/iio/adc/ad7476_core.c b/drivers/staging/iio/adc/ad7476_core.c
index deb68c8..4708b8e 100644
--- a/drivers/staging/iio/adc/ad7476_core.c
+++ b/drivers/staging/iio/adc/ad7476_core.c
@@ -190,7 +190,7 @@ static int __devinit ad7476_probe(struct spi_device *spi)
 		goto error_disable_reg;
 	}
 
-	/* Estabilish that the iio_dev is a child of the i2c device */
+	/* Establish that the iio_dev is a child of the spi device */
 	st->indio_dev->dev.parent = &spi->dev;
 	st->indio_dev->attrs = &ad7476_attribute_group;
 	st->indio_dev->dev_data = (void *)(st);
