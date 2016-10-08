Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35390 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756713AbcJHQje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:34 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 15/18] staging:iio:accel:sca3000 Tidy up probe order to avoid a race.
Date: Sat,  8 Oct 2016 17:39:15 +0100
Message-Id: <20161008163918.18758-16-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Previously the device was exposed to userspace and in kernel consumers
before the interrupts had been configured. As nothing stopped them being
enabled in the interval this could cause unhandled interrupts.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index dc1d2cf1558a..dd3759ea52a0 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -1439,9 +1439,6 @@ static int sca3000_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	sca3000_configure_ring(indio_dev);
-	ret = iio_device_register(indio_dev);
-	if (ret < 0)
-		return ret;
 
 	if (spi->irq) {
 		ret = request_threaded_irq(spi->irq,
@@ -1451,7 +1448,7 @@ static int sca3000_probe(struct spi_device *spi)
 					   "sca3000",
 					   indio_dev);
 		if (ret)
-			goto error_unregister_dev;
+			return ret;
 	}
 	indio_dev->setup_ops = &sca3000_ring_setup_ops;
 	ret = sca3000_clean_setup(st);
@@ -1462,13 +1459,12 @@ static int sca3000_probe(struct spi_device *spi)
 	if (ret)
 		goto error_free_irq;
 
-	return 0;
+	return iio_device_register(indio_dev);
 
 error_free_irq:
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
-error_unregister_dev:
-	iio_device_unregister(indio_dev);
+
 	return ret;
 }
 
@@ -1495,11 +1491,13 @@ static int sca3000_remove(struct spi_device *spi)
 	struct iio_dev *indio_dev = spi_get_drvdata(spi);
 	struct sca3000_state *st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
+
 	/* Must ensure no interrupts can be generated after this! */
 	sca3000_stop_all_interrupts(st);
 	if (spi->irq)
 		free_irq(spi->irq, indio_dev);
-	iio_device_unregister(indio_dev);
+
 	sca3000_unconfigure_ring(indio_dev);
 
 	return 0;
-- 
2.10.0

