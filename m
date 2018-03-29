Return-Path: <SRS0=2H+Q=GT=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH v6 3/6] Staging: iio: adis16209: Add a blank line after return statements
Date: Thu, 29 Mar 2018 14:44:42 +0530
Message-Id: <517fdc2cff0ef238e74c2114fba1a73d2a40a999.1522306893.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add a blank line after return statements to improve the code
readability.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v6
  -Introduce this new patch in the series.

 drivers/staging/iio/accel/adis16209.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 8f4fa6b..ee7e87b 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -277,6 +277,7 @@ static int adis16209_probe(struct spi_device *spi)
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
+
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
@@ -290,6 +291,7 @@ static int adis16209_probe(struct spi_device *spi)
 	ret = adis_init(st, indio_dev, spi, &adis16209_data);
 	if (ret)
 		return ret;
+
 	ret = adis_setup_buffer_and_trigger(st, indio_dev, NULL);
 	if (ret)
 		return ret;
-- 
2.7.4
