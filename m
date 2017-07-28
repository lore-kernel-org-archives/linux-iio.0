Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:45408 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752730AbdG1WUW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 28 Jul 2017 18:20:22 -0400
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, David Lechner <david@lechnology.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/2] iio: adc: ti-ads7950: Allow to use on ACPI platforms
Date: Sat, 29 Jul 2017 01:20:14 +0300
Message-Id: <20170728222015.43574-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
References: <20170728222015.43574-1-andriy.shevchenko@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ACPI enabled platforms do not have a mean of regulators. Instead we use
hard coded voltage value for reference pin. When value is 0 (default) we
fall back to request a regulator.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads7950.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 16a06633332c..ab669af291b7 100644
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
@@ -411,6 +423,10 @@ static int ti_ads7950_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->scan_single_msg,
 					st->scan_single_xfer, 3);
 
+	/* Use hard coded value for reference voltage in ACPI case */
+	if (ACPI_COMPANION(&spi->dev))
+		st->vref_mv = TI_ADS7950_VA_MV_ACPI_DEFAULT;
+
 	st->reg = devm_regulator_get(&spi->dev, "vref");
 	if (IS_ERR(st->reg)) {
 		dev_err(&spi->dev, "Failed get get regulator \"vref\"\n");
-- 
2.13.2

