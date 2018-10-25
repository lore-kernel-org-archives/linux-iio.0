Return-Path: <SRS0=mkZ5=NF=emutex.com=dan@kernel.org>
From: Dan O'Donovan <dan@emutex.com>
To: linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	devicetree@vger.kernel.org,
	Carlos Iglesias <carlos.iglesias@emutex.com>,
	Nicola Lunghi <nicola.lunghi@emutex.com>,
	Javier Arteaga <javier@emutex.com>,
	Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 2/3] iio: adc128s052: add ACPI _HID AANT1280
Date: Thu, 25 Oct 2018 16:35:41 +0100
Message-Id: <1540481742-23596-3-git-send-email-dan@emutex.com>
In-Reply-To: <1540481742-23596-1-git-send-email-dan@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com>
 <1540481742-23596-1-git-send-email-dan@emutex.com>
List-ID: <linux-iio@vger.kernel.org>

From: Nicola Lunghi <nicola.lunghi@emutex.com>

ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
Squared board.

Add it to the driver.

Signed-off-by: Nicola Lunghi <nicola.lunghi@emutex.com>
[javier@emutex.com: fix up commit message and one checkpatch warning]
Signed-off-by: Javier Arteaga <javier@emutex.com>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/iio/adc/ti-adc128s052.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
index e6716c3..c2d1453 100644
--- a/drivers/iio/adc/ti-adc128s052.c
+++ b/drivers/iio/adc/ti-adc128s052.c
@@ -12,10 +12,12 @@
  * published by the Free Software Foundation.
  */
 
+#include <linux/acpi.h>
 #include <linux/err.h>
 #include <linux/spi/spi.h>
 #include <linux/module.h>
 #include <linux/iio/iio.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 
 struct adc128_configuration {
@@ -135,10 +137,15 @@ static const struct iio_info adc128_info = {
 static int adc128_probe(struct spi_device *spi)
 {
 	struct iio_dev *indio_dev;
+	unsigned int config;
 	struct adc128 *adc;
-	int config = spi_get_device_id(spi)->driver_data;
 	int ret;
 
+	if (dev_fwnode(&spi->dev))
+		config = (unsigned long) device_get_match_data(&spi->dev);
+	else
+		config = spi_get_device_id(spi)->driver_data;
+
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
 	if (!indio_dev)
 		return -ENOMEM;
@@ -207,10 +214,19 @@ static const struct spi_device_id adc128_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, adc128_id);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id adc128_acpi_match[] = {
+	{ "AANT1280", 2 }, /* ADC124S021 compatible ACPI ID */
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, adc128_acpi_match);
+#endif
+
 static struct spi_driver adc128_driver = {
 	.driver = {
 		.name = "adc128s052",
 		.of_match_table = of_match_ptr(adc128_of_match),
+		.acpi_match_table = ACPI_PTR(adc128_acpi_match),
 	},
 	.probe = adc128_probe,
 	.remove = adc128_remove,
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.
