Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37456 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCRNe4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 18 Mar 2018 09:34:56 -0400
Received: by mail-wm0-f68.google.com with SMTP id 139so10833585wmn.2
        for <linux-iio@vger.kernel.org>; Sun, 18 Mar 2018 06:34:56 -0700 (PDT)
Date: Sun, 18 Mar 2018 14:34:53 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 03/11] staging: iio: ad2s1200: Add blank lines
Message-ID: <4f80f1c8873861180a51e3daaf9da9e01c1502f1.1521379685.git.davidjulianveenstra@gmail.com>
References: <cover.1521379685.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1521379685.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add blank lines to improve readability.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 94d0a66532fd..20df16b7852b 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -9,6 +9,7 @@
  * published by the Free Software Foundation.
  *
  */
+
 #include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -53,10 +54,12 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	gpio_set_value(st->sample, 0);
+
 	/* delay (6 * AD2S1200_TSCLK + 20) nano seconds */
 	udelay(1);
 	gpio_set_value(st->sample, 1);
 	gpio_set_value(st->rdvel, !!(chan->type == IIO_ANGL));
+
 	ret = spi_read(st->sdev, st->rx, 2);
 	if (ret < 0) {
 		mutex_unlock(&st->lock);
@@ -76,9 +79,11 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&st->lock);
 		return -EINVAL;
 	}
+
 	/* delay (2 * AD2S1200_TSCLK + 20) ns for sample pulse */
 	udelay(1);
 	mutex_unlock(&st->lock);
+
 	return IIO_VAL_INT;
 }
 
@@ -116,9 +121,11 @@ static int ad2s1200_probe(struct spi_device *spi)
 			return ret;
 		}
 	}
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
 	mutex_init(&st->lock);
-- 
2.16.2

