Return-Path: <gwenhael.goavec-merou@trabucayre.com>
From: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Paul Cercueil <paul.cercueil@analog.com>,
	devel@driverdev.osuosl.org,
	Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
Subject: [PATCH] stagging:iio:ad9834: add devicetree property support
Date: Sun, 11 Sep 2016 12:52:29 +0200
Message-Id: <20160911105229.25791-1-gwenhael.goavec-merou@trabucayre.com>
List-ID: <linux-iio@vger.kernel.org>

ad9834 driver needs some default properties. Currently these parameters are
provided through platform_data.
This patch adds a function to create this pdata based on device-tree node.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
---
 drivers/staging/iio/frequency/ad9834.c | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 6366216..6cec154 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -316,6 +316,39 @@ static const struct iio_info ad9833_info = {
 	.driver_module = THIS_MODULE,
 };
 
+#if defined(CONFIG_OF)
+static struct ad9834_platform_data *ad9834_parse_dt(struct spi_device *spi)
+{
+	struct ad9834_platform_data *pdata;
+	struct device_node *np = spi->dev.of_node;
+
+	pdata = devm_kzalloc(&spi->dev, sizeof(*pdata), GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	if (of_property_read_u32(np, "mclk", &pdata->mclk))
+		return ERR_PTR(-ENODEV);
+	if (of_property_read_u32(np, "freq0", &pdata->freq0))
+		return ERR_PTR(-ENODEV);
+	if (of_property_read_u32(np, "freq1", &pdata->freq1))
+		return ERR_PTR(-ENODEV);
+	if (of_property_read_u16(np, "phase0", &pdata->phase0))
+		return ERR_PTR(-ENODEV);
+	if (of_property_read_u16(np, "phase1", &pdata->phase1))
+		return ERR_PTR(-ENODEV);
+	pdata->en_div2 = of_property_read_bool(np, "en_div2");
+	pdata->en_signbit_msb_out = of_property_read_bool(np,
+					"en_signbit_msb_out");
+
+	return pdata;
+}
+#else
+static struct ad9834_platform_data *ad9834_parse_dt(struct spi_device *spi)
+{
+	return NULL;
+}
+#endif
+
 static int ad9834_probe(struct spi_device *spi)
 {
 	struct ad9834_platform_data *pdata = dev_get_platdata(&spi->dev);
@@ -324,6 +357,12 @@ static int ad9834_probe(struct spi_device *spi)
 	struct regulator *reg;
 	int ret;
 
+	if (!pdata && spi->dev.of_node) {
+		pdata = ad9834_parse_dt(spi);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
 	if (!pdata) {
 		dev_dbg(&spi->dev, "no platform data?\n");
 		return -ENODEV;
-- 
2.9.3
