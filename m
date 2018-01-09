Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45713 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbeAIJfC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Jan 2018 04:35:02 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, linux-sunxi@googlegroups.com,
        Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v2 03/16] iio: adc: axp20x_adc: make it possible to probe from DT
Date: Tue,  9 Jan 2018 10:33:34 +0100
Message-Id: <5cf35ebd799555aca6201b86d635656266eda40c.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To prepare for a future patch that will add a DT node for the ADC, make
axp20x_adc able to probe from DT and get the per-variant data from
of_device_id.data since platform_device_id.driver_data won't be set when
probing by DT.

Leave the ability to probe via platform for driver compatibility with
old DTs.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 drivers/iio/adc/axp20x_adc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 3fc1b06..f8c4c62 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -515,6 +515,13 @@ static const struct axp_data axp22x_data = {
 	.maps = axp22x_maps,
 };
 
+static const struct of_device_id axp20x_adc_of_match[] = {
+	{ .compatible = "x-powers,axp20x-adc", .data = (void *)&axp20x_data, },
+	{ .compatible = "x-powers,axp22x-adc", .data = (void *)&axp22x_data, },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
+
 static const struct platform_device_id axp20x_adc_id_match[] = {
 	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
 	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
@@ -543,7 +550,16 @@ static int axp20x_probe(struct platform_device *pdev)
 	indio_dev->dev.of_node = pdev->dev.of_node;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	info->data = (struct axp_data *)platform_get_device_id(pdev)->driver_data;
+	if (!pdev->dev.of_node) {
+		const struct platform_device_id *tmp;
+
+		tmp = platform_get_device_id(pdev);
+		info->data = (struct axp_data *)tmp->driver_data;
+	} else {
+		struct device *dev = &pdev->dev;
+
+		info->data = (struct axp_data *)of_device_get_match_data(dev);
+	}
 
 	indio_dev->name = platform_get_device_id(pdev)->name;
 	indio_dev->info = info->data->iio_info;
@@ -606,6 +622,7 @@ static int axp20x_remove(struct platform_device *pdev)
 static struct platform_driver axp20x_adc_driver = {
 	.driver = {
 		.name = "axp20x-adc",
+		.of_match_table = of_match_ptr(axp20x_adc_of_match),
 	},
 	.id_table = axp20x_adc_id_match,
 	.probe = axp20x_probe,
-- 
git-series 0.9.1
