Return-Path: <SRS0=iAnx=IF=gmail.com=davidjulianveenstra@kernel.org>
Date: Fri, 18 May 2018 20:21:23 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 02/12] staging: iio: ad2s1200: Remove unneeded
 initializations
Message-ID: <b241956721e6f6df3234c42306935cb0aaaefc00.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526667118.git.davidjulianveenstra@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Remove 2 initializations which are unneeded, because the
initialized values are never used.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v4:
 - Introduced in this version.

 drivers/staging/iio/resolver/ad2s1200.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index df3b34200a89..9bdcf0c86217 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -47,7 +47,7 @@ static int ad2s1200_read_raw(struct iio_dev *indio_dev,
 			     long m)
 {
 	struct ad2s1200_state *st = iio_priv(indio_dev);
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&st->lock);
 	gpio_set_value(st->sample, 0);
@@ -105,7 +105,7 @@ static int ad2s1200_probe(struct spi_device *spi)
 	unsigned short *pins = spi->dev.platform_data;
 	struct ad2s1200_state *st;
 	struct iio_dev *indio_dev;
-	int pn, ret = 0;
+	int pn, ret;
 
 	for (pn = 0; pn < AD2S1200_PN; pn++) {
 		ret = devm_gpio_request_one(&spi->dev, pins[pn], GPIOF_DIR_OUT,
-- 
2.17.0
