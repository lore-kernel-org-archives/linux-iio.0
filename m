Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38810 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751289AbeDTT34 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Apr 2018 15:29:56 -0400
Date: Fri, 20 Apr 2018 21:29:52 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de, jic23@kernel.org, pmeerw@pmeerw.net
Cc: robh+dt@kernel.org, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        daniel.baluta@nxp.com, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org
Subject: [PATCH v2 04/13] staging: iio: ad2s1200: Add blank lines
Message-ID: <399d2beff3981a7a0dd45af0d4277d1c9355b99e.1524247563.git.davidjulianveenstra@gmail.com>
References: <cover.1524247563.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1524247563.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add blank lines to improve readability.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/resolver/ad2s1200.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index b6c3a3c8f7fe..357fe3c382b3 100644
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
@@ -52,10 +53,12 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 
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
@@ -75,9 +78,11 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
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
 
@@ -115,9 +120,11 @@ static int ad2s1200_probe(struct spi_device *spi)
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

