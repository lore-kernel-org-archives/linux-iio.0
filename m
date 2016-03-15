Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:34359 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680AbcCPJiH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Mar 2016 05:38:07 -0400
From: David Wu <david.wu@rock-chips.com>
To: jic23@kernel.org, heiko@sntech.de
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	huangtao@rock-chips.com, xjq@rock-chips.com, zyw@rock-chips.com,
	cf@rock-chips.com, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.wu@rock-chips.com
Subject: [PATCH] iio: adc: rockchip_saradc: add saradc support for rk3399
Date: Wed, 16 Mar 2016 01:44:15 +0800
Message-Id: <1458063855-4154-1-git-send-email-david.wu@rock-chips.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The ADC is a 6-channel signal-ended 10-bit Successive
Approximation Register (SAR) A/D Converter.

Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../devicetree/bindings/iio/adc/rockchip-saradc.txt   |  6 +++++-
 drivers/iio/adc/rockchip_saradc.c                     | 19 +++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
index a9a5fe1..bf99e2f 100644
--- a/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/rockchip-saradc.txt
@@ -1,7 +1,11 @@
 Rockchip Successive Approximation Register (SAR) A/D Converter bindings
 
 Required properties:
-- compatible: Should be "rockchip,saradc" or "rockchip,rk3066-tsadc"
+- compatible: should be "rockchip,<name>-saradc" or "rockchip,rk3066-tsadc"
+   - "rockchip,saradc": for rk3188, rk3288
+   - "rockchip,rk3066-tsadc": for rk3036
+   - "rockchip,rk3399-saradc": for rk3399
+
 - reg: physical base address of the controller and length of memory mapped
        region.
 - interrupts: The interrupt number to the cpu. The interrupt specifier format
diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 9c311c1..f9ad6c2 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -159,6 +159,22 @@ static const struct rockchip_saradc_data rk3066_tsadc_data = {
 	.clk_rate = 50000,
 };
 
+static const struct iio_chan_spec rockchip_rk3399_saradc_iio_channels[] = {
+	ADC_CHANNEL(0, "adc0"),
+	ADC_CHANNEL(1, "adc1"),
+	ADC_CHANNEL(2, "adc2"),
+	ADC_CHANNEL(3, "adc3"),
+	ADC_CHANNEL(4, "adc4"),
+	ADC_CHANNEL(5, "adc5"),
+};
+
+static const struct rockchip_saradc_data rk3399_saradc_data = {
+	.num_bits = 10,
+	.channels = rockchip_rk3399_saradc_iio_channels,
+	.num_channels = ARRAY_SIZE(rockchip_rk3399_saradc_iio_channels),
+	.clk_rate = 1000000,
+};
+
 static const struct of_device_id rockchip_saradc_match[] = {
 	{
 		.compatible = "rockchip,saradc",
@@ -166,6 +182,9 @@ static const struct of_device_id rockchip_saradc_match[] = {
 	}, {
 		.compatible = "rockchip,rk3066-tsadc",
 		.data = &rk3066_tsadc_data,
+	}, {
+		.compatible = "rockchip,rk3399-saradc",
+		.data = &rk3399_saradc_data,
 	},
 	{},
 };
-- 
1.9.1


