Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0078.outbound.protection.outlook.com ([104.47.37.78]:51936
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754831AbeAJLaj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jan 2018 06:30:39 -0500
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC: <devicetree@vger.kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] staging: iio: adc: ad7192: add device-tree support to driver
Date: Wed, 10 Jan 2018 13:29:55 +0200
Message-ID: <20180110112956.23931-2-alexandru.ardelean@analog.com>
In-Reply-To: <20180110112956.23931-1-alexandru.ardelean@analog.com>
References: <20180110112956.23931-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

Adds device-tree support to the ad7192 driver.
This change re-uses the "ad7192_platform_data" struct,
and populates it with fields defined in the device-tree.

Re-using the platform_data struct adds a minimal
change to the driver, and keeps the possibility
of defining a platform_data struct.

A provided "ad7192_platform_data" struct is preferred
over the device-tree to reduce impact for users when
using the newer driver.

This will add up to sizeof(struct ad7192_platform_data) bytes
(~12 bytes) on the stack during the probing of the device.
But it is a bit less error-proner than using alloc & free
during the probe call.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 50 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 7bc04101d133..d8cfdf18933b 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -625,18 +625,63 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static int ad7192_parse_dt(struct device *dev, struct device_node *np,
+			   struct ad7192_platform_data *pdata)
+{
+	int ret;
+
+	ret = of_property_read_u8(np, "adi,clock-source-select",
+				  &pdata->clock_source_sel);
+	if (ret < 0) {
+		pdata->clock_source_sel = AD7192_CLK_INT;
+		dev_info(dev, "No clock source specified. Using int clock\n");
+	}
+
+	if (pdata->clock_source_sel == AD7192_CLK_EXT_MCLK2) {
+		ret = of_property_read_u32(np, "adi,external-clock-Hz",
+					   &pdata->ext_clk_hz);
+		if (ret < 0 ||
+		    !ad7192_valid_external_frequency(&pdata->ext_clk_hz)) {
+			dev_err(dev, "Invalid or no freq for ext clock\n");
+			return -EINVAL;
+		}
+	}
+
+	pdata->refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
+	pdata->sinc3_en = of_property_read_bool(np, "adi,sinc3-filter-enable");
+	pdata->chop_en = of_property_read_bool(np, "adi,chop-enable");
+	pdata->buf_en = of_property_read_bool(np, "adi,buffer-enable");
+	pdata->unipolar_en = of_property_read_bool(np, "adi,unipolar-enable");
+	pdata->rej60_en =
+		of_property_read_bool(np, "adi,rejection-60-Hz-enable");
+	pdata->burnout_curr_en =
+		of_property_read_bool(np, "adi,burnout-currents-enable");
+
+	return 0;
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
+	struct device_node *of_node = dev_of_node(&spi->dev);
+	struct ad7192_platform_data lpdata;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform data?\n");
+	if (!pdata && !of_node) {
+		dev_err(&spi->dev, "no platform data or device tree config\n");
 		return -ENODEV;
 	}
 
+	if (!pdata) {
+		memset(&lpdata, 0, sizeof(lpdata));
+		ret = ad7192_parse_dt(&spi->dev, of_node, &lpdata);
+		if (ret)
+			return ret;
+		pdata = &lpdata;
+	}
+
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ?\n");
 		return -ENODEV;
@@ -682,6 +727,7 @@ static int ad7192_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, indio_dev);
 	st->devid = spi_get_device_id(spi)->driver_data;
 	indio_dev->dev.parent = &spi->dev;
+	indio_dev->dev.of_node = of_node;
 	indio_dev->name = spi_get_device_id(spi)->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-- 
2.14.1

