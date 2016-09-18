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
Subject: [PATCH v2] stagging:iio:ad9834: add devicetree property support
Date: Sun, 18 Sep 2016 10:52:02 +0200
Message-Id: <20160918085202.14740-1-gwenhael.goavec-merou@trabucayre.com>
List-ID: <linux-iio@vger.kernel.org>

ad9834 driver needs some default properties. Currently these parameters are
provided through platform_data.
This patch adds a function to create this pdata based on device-tree node.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>
---
Changes v1 -> v2:
	- use clock bindings for input clock (Lars-Peter Clausen)
	- provides a default value for freq0/1 and phase0/1 (Lars-Peter Clausen)
---
 drivers/staging/iio/frequency/ad9834.c | 71 +++++++++++++++++++++++++++++++++-
 drivers/staging/iio/frequency/ad9834.h |  1 +
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 6366216..24a3e84 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -18,6 +18,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <asm/div64.h>
+#include <linux/clk.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -316,24 +317,76 @@ static const struct iio_info ad9833_info = {
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
+	pdata->freq0 = 134000;
+	of_property_read_u32(np, "freq0", &pdata->freq0);
+
+	pdata->freq1 = 134000;
+	of_property_read_u32(np, "freq1", &pdata->freq1);
+
+	pdata->phase0 = 0;
+	of_property_read_u16(np, "phase0", &pdata->phase0);
+
+	pdata->phase1 = 0;
+	of_property_read_u16(np, "phase1", &pdata->phase1);
+
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
 	struct ad9834_state *st;
 	struct iio_dev *indio_dev;
 	struct regulator *reg;
+	struct clk *clk = NULL;
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
 	}
 
+	if (!pdata->mclk) {
+		clk = devm_clk_get(&spi->dev, NULL);
+		if (IS_ERR(clk))
+			return -EPROBE_DEFER;
+
+		ret = clk_prepare_enable(clk);
+		if (ret < 0)
+			return ret;
+	}
+
 	reg = devm_regulator_get(&spi->dev, "vcc");
 	if (!IS_ERR(reg)) {
 		ret = regulator_enable(reg);
 		if (ret)
-			return ret;
+			goto error_disable_clk;
 	}
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -343,7 +396,14 @@ static int ad9834_probe(struct spi_device *spi)
 	}
 	spi_set_drvdata(spi, indio_dev);
 	st = iio_priv(indio_dev);
-	st->mclk = pdata->mclk;
+
+	if (clk) {
+		st->clk = clk;
+		st->mclk = clk_get_rate(clk);
+	} else {
+		st->mclk = pdata->mclk;
+	}
+
 	st->spi = spi;
 	st->devid = spi_get_device_id(spi)->driver_data;
 	st->reg = reg;
@@ -418,6 +478,9 @@ static int ad9834_probe(struct spi_device *spi)
 error_disable_reg:
 	if (!IS_ERR(reg))
 		regulator_disable(reg);
+error_disable_clk:
+	if (clk)
+		clk_disable_unprepare(clk);
 
 	return ret;
 }
@@ -428,6 +491,10 @@ static int ad9834_remove(struct spi_device *spi)
 	struct ad9834_state *st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
+
+	if (st->clk)
+		clk_disable_unprepare(st->clk);
+
 	if (!IS_ERR(st->reg))
 		regulator_disable(st->reg);
 
diff --git a/drivers/staging/iio/frequency/ad9834.h b/drivers/staging/iio/frequency/ad9834.h
index 40fdd5d..fd9cccf 100644
--- a/drivers/staging/iio/frequency/ad9834.h
+++ b/drivers/staging/iio/frequency/ad9834.h
@@ -53,6 +53,7 @@
 struct ad9834_state {
 	struct spi_device		*spi;
 	struct regulator		*reg;
+	struct clk				*clk;
 	unsigned int			mclk;
 	unsigned short			control;
 	unsigned short			devid;
-- 
2.9.3
