Return-Path: <SRS0=aC7W=OD=usp.br=matheus.bernardino@kernel.org>
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexandru Ardelean <alexandru.ardelean@analog.com>,
	kernel-usp@googlegroups.com,
	victorcolombo@gmail.com
Subject: [PATCH v3 1/7] staging:iio:ad2s90: Add device tree support
Date: Fri, 23 Nov 2018 22:23:06 -0200
Message-Id: <20181124002312.6923-2-matheus.bernardino@usp.br>
In-Reply-To: <20181124002312.6923-1-matheus.bernardino@usp.br>
References: <20181124002312.6923-1-matheus.bernardino@usp.br>
List-ID: <linux-iio@vger.kernel.org>

This patch adds device tree support to ad2s90 with standard
device tree id table.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
Changes in v3:
 - Removed of_patch_ptr from of_match_table assignment

Changes in v2:
 - none

 drivers/staging/iio/resolver/ad2s90.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 3e257ac46f7a..fdae067ed866 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -107,6 +107,12 @@ static int ad2s90_probe(struct spi_device *spi)
 	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
 }
 
+static const struct of_device_id ad2s90_of_match[] = {
+	{ .compatible = "adi,ad2s90", },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad2s90_of_match);
+
 static const struct spi_device_id ad2s90_id[] = {
 	{ "ad2s90" },
 	{}
@@ -116,6 +122,7 @@ MODULE_DEVICE_TABLE(spi, ad2s90_id);
 static struct spi_driver ad2s90_driver = {
 	.driver = {
 		.name = "ad2s90",
+		.of_match_table = ad2s90_of_match,
 	},
 	.probe = ad2s90_probe,
 	.id_table = ad2s90_id,
-- 
2.18.0
