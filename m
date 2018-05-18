Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35469 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeERSVt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 May 2018 14:21:49 -0400
Date: Fri, 18 May 2018 20:21:44 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 04/12] staging: iio: ad2s1200: Setup spi before iio device
 register
Message-ID: <2f531545d91366136c7e421f0931637a45b15d51.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526667118.git.davidjulianveenstra@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The spi should be set up before the device is registered as an iio
device.

This patch moves the setup to before the device registration.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v4:
 - Introduced in this version.

 drivers/staging/iio/resolver/ad2s1200.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 068aa86e9c11..430cc62591fe 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -143,15 +143,16 @@ static int ad2s1200_probe(struct spi_device *spi)
 	indio_dev->num_channels = ARRAY_SIZE(ad2s1200_channels);
 	indio_dev->name = spi_get_device_id(spi)->name;
 
-	ret = devm_iio_device_register(&spi->dev, indio_dev);
-	if (ret)
-		return ret;
-
 	spi->max_speed_hz = AD2S1200_HZ;
 	spi->mode = SPI_MODE_3;
-	spi_setup(spi);
+	ret = spi_setup(spi);
+
+	if (ret < 0) {
+		dev_err(&spi->dev, "spi_setup failed!\n");
+		return ret;
+	}
 
-	return 0;
+	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
 static const struct spi_device_id ad2s1200_id[] = {
-- 
2.17.0

