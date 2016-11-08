Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.133]:49650 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751134AbcKHOJx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 8 Nov 2016 09:09:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: ad9832: allocate data before using
Date: Tue,  8 Nov 2016 15:00:49 +0100
Message-Id: <20161108140115.2250646-1-arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The regulator changes assigned data to an uninitialized pointer:

drivers/staging/iio/frequency/ad9832.c: In function 'ad9832_probe':
drivers/staging/iio/frequency/ad9832.c:214:11: error: 'st' may be used uninitialized in this function [-Werror=maybe-uninitialized]

This moves the allocation of the 'st' structure before its first
use, as it should have been.

Fixes: 43a07e48af44 ("staging: iio: ad9832: clean-up regulator 'reg'")
Fixes: a98461d79ba5 ("staging: iio: ad9832: add DVDD regulator")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/staging/iio/frequency/ad9832.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 639047fade30..a5b2f068168d 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -211,6 +211,13 @@ static int ad9832_probe(struct spi_device *spi)
 		return -ENODEV;
 	}
 
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	spi_set_drvdata(spi, indio_dev);
+	st = iio_priv(indio_dev);
+
 	st->avdd = devm_regulator_get(&spi->dev, "avdd");
 	if (IS_ERR(st->avdd))
 		return PTR_ERR(st->avdd);
@@ -233,13 +240,6 @@ static int ad9832_probe(struct spi_device *spi)
 		goto error_disable_avdd;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
-	if (!indio_dev) {
-		ret = -ENOMEM;
-		goto error_disable_dvdd;
-	}
-	spi_set_drvdata(spi, indio_dev);
-	st = iio_priv(indio_dev);
 	st->mclk = pdata->mclk;
 	st->spi = spi;
 
-- 
2.9.0

