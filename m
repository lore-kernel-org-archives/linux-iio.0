Return-Path: <SRS0=iAnx=IF=gmail.com=davidjulianveenstra@kernel.org>
Date: Fri, 18 May 2018 20:22:41 +0200
From: David Veenstra <davidjulianveenstra@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, pmeerw@pmeerw.net,
	robh+dt@kernel.org
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org
Subject: [PATCH v4 07/12] staging: iio: ad2s1200: Add dt table
Message-ID: <eb4fa431405d0d4e73889d440b3b1c95d5c47e54.1526667118.git.davidjulianveenstra@gmail.com>
References: <cover.1526667118.git.davidjulianveenstra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1526667118.git.davidjulianveenstra@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree table for matching with the vendor ID.

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
Changes in v4:
 - Introduced in this version.

 drivers/staging/iio/resolver/ad2s1200.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index 9a8aa2448897..67d9747f88a6 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -154,6 +154,13 @@ static int ad2s1200_probe(struct spi_device *spi)
 	return devm_iio_device_register(&spi->dev, indio_dev);
 }
 
+static const struct of_device_id ad2s1200_of_match[] = {
+	{ .compatible = "adi,ad2s1200", },
+	{ .compatible = "adi,ad2s1205", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad2s1200_of_match);
+
 static const struct spi_device_id ad2s1200_id[] = {
 	{ "ad2s1200" },
 	{ "ad2s1205" },
@@ -164,6 +171,7 @@ MODULE_DEVICE_TABLE(spi, ad2s1200_id);
 static struct spi_driver ad2s1200_driver = {
 	.driver = {
 		.name = DRV_NAME,
+		.of_match_table = of_match_ptr(ad2s1200_of_match),
 	},
 	.probe = ad2s1200_probe,
 	.id_table = ad2s1200_id,
-- 
2.17.0
