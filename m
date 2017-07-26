Return-Path: <SRS0=lo7y=65=linux.intel.com=andriy.shevchenko@kernel.org>
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <david@lechnology.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] iio: adc: ti-ads7950: Add OF device ID table
Date: Wed, 26 Jul 2017 18:59:09 +0300
Message-Id: <20170726155909.14497-2-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
References: <20170726155909.14497-1-andriy.shevchenko@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
SPI device registered via OF will always match a legacy SPI device ID and
that the MODALIAS reported will always be of the form spi:<device>.

There is an ACPI method to enumerate such devices via specific ACPI ID
and use of compatible strings. It will not work for the drivers which
have no OF match ID table present.

Besides this could change in the future so the correct approach is to
have an OF device ID table if the devices are registered via OF.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/adc/ti-ads7950.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
index 44d2a3692614..c67f2725c2bb 100644
--- a/drivers/iio/adc/ti-ads7950.c
+++ b/drivers/iio/adc/ti-ads7950.c
@@ -494,9 +494,27 @@ static const struct spi_device_id ti_ads7950_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ti_ads7950_id);
 
+static const struct of_device_id ads7950_of_table[] = {
+	{ .compatible = "ti,ads7950", .data = &ti_ads7950_chip_info[TI_ADS7950] },
+	{ .compatible = "ti,ads7951", .data = &ti_ads7950_chip_info[TI_ADS7951] },
+	{ .compatible = "ti,ads7952", .data = &ti_ads7950_chip_info[TI_ADS7952] },
+	{ .compatible = "ti,ads7953", .data = &ti_ads7950_chip_info[TI_ADS7953] },
+	{ .compatible = "ti,ads7954", .data = &ti_ads7950_chip_info[TI_ADS7954] },
+	{ .compatible = "ti,ads7955", .data = &ti_ads7950_chip_info[TI_ADS7955] },
+	{ .compatible = "ti,ads7956", .data = &ti_ads7950_chip_info[TI_ADS7956] },
+	{ .compatible = "ti,ads7957", .data = &ti_ads7950_chip_info[TI_ADS7957] },
+	{ .compatible = "ti,ads7958", .data = &ti_ads7950_chip_info[TI_ADS7958] },
+	{ .compatible = "ti,ads7959", .data = &ti_ads7950_chip_info[TI_ADS7959] },
+	{ .compatible = "ti,ads7960", .data = &ti_ads7950_chip_info[TI_ADS7960] },
+	{ .compatible = "ti,ads7961", .data = &ti_ads7950_chip_info[TI_ADS7961] },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ads7950_of_table);
+
 static struct spi_driver ti_ads7950_driver = {
 	.driver = {
 		.name	= "ads7950",
+		.of_match_table = ads7950_of_table,
 	},
 	.probe		= ti_ads7950_probe,
 	.remove		= ti_ads7950_remove,
-- 
2.13.2
