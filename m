Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-by2nam03on0065.outbound.protection.outlook.com ([104.47.42.65]:47744
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751624AbeAEPVk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 Jan 2018 10:21:40 -0500
Received: from NWD2HUBCAS8.ad.analog.com (nwd2hubcas8.ad.analog.com [10.64.69.108])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w05FLcgK019940
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK)
        for <linux-iio@vger.kernel.org>; Fri, 5 Jan 2018 07:21:38 -0800
From: <alexandru.ardelean@analog.com>
To: <linux-iio@vger.kernel.org>
CC: Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 1/2] staging: iio: adc: ad7192: add device-tree support to driver
Date: Fri, 5 Jan 2018 17:21:32 +0200
Message-ID: <20180105152133.9681-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Alexandru Ardelean <alexandru.ardelean@analog.com>

Admittedly, this will always use up to
sizeof(struct ad7192_platform_data) bytes (~12 bytes at most)
on the stack, during the probing of the device.

But this will maintain most of the other
init code unchanged.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/staging/iio/adc/ad7192.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index cadfb96734ed..fca988330588 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -610,18 +610,41 @@ static const struct iio_chan_spec ad7193_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(14),
 };
 
+static void ad7192_parse_dt(struct device_node *np,
+			    struct ad7192_platform_data *pdata)
+{
+	of_property_read_u16(np, "adi,reference-voltage-mv", &pdata->vref_mv);
+	of_property_read_u8(np, "adi,clock-source-select", &pdata->clock_source_sel);
+	of_property_read_u32(np, "adi,external-clock-Hz", &pdata->ext_clk_hz);
+	pdata->refin2_en = of_property_read_bool(np, "adi,refin2-pins-enable");
+	pdata->rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
+	pdata->sinc3_en = of_property_read_bool(np, "adi,sinc3-filter-enable");
+	pdata->chop_en = of_property_read_bool(np, "adi,chop-enable");
+	pdata->buf_en = of_property_read_bool(np, "adi,buffer-enable");
+	pdata->unipolar_en = of_property_read_bool(np, "adi,unipolar-enable");
+	pdata->burnout_curr_en = of_property_read_bool(np, "adi,burnout-currents-enable");
+}
+
 static int ad7192_probe(struct spi_device *spi)
 {
 	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
+	const struct device_node *of_node = dev_of_node(&spi->dev);
+	struct ad7192_platform_data lpdata;
 	struct ad7192_state *st;
 	struct iio_dev *indio_dev;
 	int ret, voltage_uv = 0;
 
-	if (!pdata) {
-		dev_err(&spi->dev, "no platform data?\n");
+	if (!pdata && !of_node) {
+		dev_err(&spi->dev, "no platform data or device tree configuration?\n");
 		return -ENODEV;
 	}
 
+	if (!pdata) {
+		memset(&lpdata, 0, sizeof(lpdata));
+		pdata = &lpdata;
+		ad7192_parse_dt(of_node, pdata);
+	}
+
 	if (!spi->irq) {
 		dev_err(&spi->dev, "no IRQ?\n");
 		return -ENODEV;
-- 
2.14.1

