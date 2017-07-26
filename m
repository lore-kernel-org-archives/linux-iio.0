Return-Path: <SRS0=lo7y=65=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <david@lechnology.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] iio: adc: ti-ads7951: Allow to use on ACPI platforms
Date: Wed, 26 Jul 2017 18:59:08 +0300
Message-Id: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

ACPI enabled platforms do not have a mean of regulators. Instead we use
hard coded voltage value for reference pin. When value is 0 (default) we
fall back to request a regulator.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads7950.c | 51 ++++++++++++++++++++++++++++++--------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 16a06633332c..44d2a3692614 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -21,6 +21,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/acpi.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -37,6 +38,12 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
+/*
+ * In case of ACPI, we use the 5000 mV as default for the reference pin.
+ * Device tree users encode that via the vref-supply regulator.
+ */
+#define TI_ADS7950_VA_MV_ACPI_DEFAULT	5000
+
 #define TI_ADS7950_CR_MANUAL	BIT(12)
 #define TI_ADS7950_CR_WRITE	BIT(11)
 #define TI_ADS7950_CR_CHAN(ch)	((ch) << 7)
@@ -58,6 +65,7 @@ struct ti_ads7950_state {
 	struct spi_message	scan_single_msg;
 
 	struct regulator	*reg;
+	unsigned int		vref_mv;
 
 	unsigned int		settings;
 
@@ -305,11 +313,15 @@ static int ti_ads7950_get_range(struct ti_ads7950_state *st)
 {
 	int vref;
 
-	vref = regulator_get_voltage(st->reg);
-	if (vref < 0)
-		return vref;
+	if (st->vref_mv) {
+		vref = st->vref_mv;
+	} else {
+		vref = regulator_get_voltage(st->reg);
+		if (vref < 0)
+			return vref;
 
-	vref /= 1000;
+		vref /= 1000;
+	}
 
 	if (st->settings & TI_ADS7950_CR_RANGE_5V)
 		vref *= 2;
@@ -411,16 +423,20 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					st->scan_single_xfer, 3);
 
-	st->reg = devm_regulator_get(&spi->dev, "vref");
-	if (IS_ERR(st->reg)) {
-		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
-		return PTR_ERR(st->reg);
-	}
-
-	ret = regulator_enable(st->reg);
-	if (ret) {
-		dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
-		return ret;
+	if (ACPI_COMPANION(&spi->dev)) {
+		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
+	} else {
+		st->reg = devm_regulator_get(&spi->dev, "vref");
+		if (IS_ERR(st->reg)) {
+			dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
+			return PTR_ERR(st->reg);
+		}
+
+		ret = regulator_enable(st->reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed to enable regulator \"vref\"\n");
+			return ret;
+		}
 	}
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
@@ -441,7 +457,8 @@ static int ti_ads7950_probe(struct spi_device *spi)
 error_cleanup_ring:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_reg:
-	regulator_disable(st->reg);
+	if (!st->vref_mv)
+		regulator_disable(st->reg);
 
 	return ret;
 }
@@ -453,7 +470,9 @@ static int ti_ads7950_remove(struct spi_device *spi)
 
 	iio_device_unregister(indio_dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	regulator_disable(st->reg);
+
+	if (!st->vref_mv)
+		regulator_disable(st->reg);
 
 	return 0;
 }
-- 
2.13.2
