Return-Path: <SRS0=ngzp=NZ=gmail.com=nishadkamdar@kernel.org>
Date: Wed, 14 Nov 2018 23:16:14 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] staging: iio: ad7816: Add device tree table.
Message-ID: <d2df511b4a84b92925a39b5051932eef4426f18d.1542215638.git.nishadkamdar@gmail.com>
References: <cover.1542215638.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1542215638.git.nishadkamdar@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add device tree table for matching vendor ID.

Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index a2fead85cd46..925f7086bc07 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -422,6 +422,14 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	return 0;
 }
 
+static const struct of_device_id ad7816_of_match[] = {
+	{ .compatible = "adi,ad7816", },
+	{ .compatible = "adi,ad7817", },
+	{ .compatible = "adi,ad7818", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7816_of_match);
+
 static const struct spi_device_id ad7816_id[] = {
 	{ "ad7816", ID_AD7816 },
 	{ "ad7817", ID_AD7817 },
@@ -434,6 +442,7 @@ MODULE_DEVICE_TABLE(spi, ad7816_id);
 static struct spi_driver ad7816_driver = {
 	.driver = {
 		.name = "ad7816",
+		.of_match_table = of_match_ptr(ad7816_of_match),
 	},
 	.probe = ad7816_probe,
 	.id_table = ad7816_id,
-- 
2.17.1
