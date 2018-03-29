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
Subject: [PATCH v6 2/6] Staging: iio: adis16209: Prefer reverse christmas tree ordering
Date: Thu, 29 Mar 2018 14:43:23 +0530
Message-Id: <3f021293e6183f6fefb597a9a01b762b73d69bc3.1522306893.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1522306893.git.shreeya.patel23498@gmail.com>
References: <cover.1522306893.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Prefer reverse christmas tree ordering of declarations to
improve readability.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

Changes in v6
  -Introduce this new patch in the series.

 drivers/staging/iio/accel/adis16209.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 0e6366a..8f4fa6b 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -270,9 +270,9 @@ static const struct adis_data adis16209_data = {
 
 static int adis16209_probe(struct spi_device *spi)
 {
-	int ret;
-	struct adis *st;
 	struct iio_dev *indio_dev;
+	struct adis *st;
+	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
-- 
2.7.4
