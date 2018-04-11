Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0122.outbound.protection.outlook.com ([104.47.0.122]:10112
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752806AbeDKOQa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 11 Apr 2018 10:16:30 -0400
From: Peter Rosin <peda@axentia.se>
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
Date: Wed, 11 Apr 2018 16:15:55 +0200
Message-Id: <20180411141555.15044-3-peda@axentia.se>
In-Reply-To: <20180411141555.15044-1-peda@axentia.se>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a current sense amplifier from Analog Devices.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/afe/Kconfig              |  3 +-
 drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
index 642ce4eb12a6..0e10fe8f459a 100644
--- a/drivers/iio/afe/Kconfig
+++ b/drivers/iio/afe/Kconfig
@@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
 	depends on OF || COMPILE_TEST
 	help
 	  Say yes here to build support for the IIO unit converter
-	  that handles voltage dividers and current sense shunts.
+	  that handles voltage dividers, current sense shunts and
+	  the LT6106 Current Sense Amplifier from Analog Devices.
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called iio-unit-converter.
diff --git a/drivers/iio/afe/iio-unit-converter.c b/drivers/iio/afe/iio-unit-converter.c
index fc50290d7e5e..4b0ae5ab9c2d 100644
--- a/drivers/iio/afe/iio-unit-converter.c
+++ b/drivers/iio/afe/iio-unit-converter.c
@@ -144,6 +144,53 @@ static int unit_converter_configure_channel(struct device *dev,
 	return 0;
 }
 
+static int unit_converter_adi_lt6106_props(struct device *dev,
+					   struct unit_converter *uc)
+{
+	u32 sense;
+	u32 rin;
+	u32 rout;
+	u32 factor;
+	int ret;
+
+	ret = device_property_read_u32(dev, "sense-resistor-micro-ohms",
+				       &sense);
+	if (ret) {
+		dev_err(dev, "failed to read the sense resistance: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "input-resistor-ohms", &rin);
+	if (ret) {
+		dev_err(dev, "failed to read the input resistance: %d\n", ret);
+		return ret;
+	}
+
+	ret = device_property_read_u32(dev, "output-resistor-ohms", &rout);
+	if (ret) {
+		dev_err(dev, "failed to read the output resistance: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Calculate the scaling factor, rin / (rout * sense), while trying
+	 * to keep the fraction from overflowing.
+	 */
+	factor = gcd(sense, 1000000);
+	uc->numerator = 1000000 / factor;
+	uc->denominator = sense / factor;
+
+	factor = gcd(uc->numerator, rout);
+	uc->numerator /= factor;
+	uc->denominator *= rout / factor;
+
+	factor = gcd(uc->denominator, rin);
+	uc->numerator *= rin / factor;
+	uc->denominator /= factor;
+
+	return 0;
+}
+
 static int unit_converter_current_sense_shunt_props(struct device *dev,
 						    struct unit_converter *uc)
 {
@@ -175,11 +222,16 @@ static int unit_converter_voltage_divider_props(struct device *dev,
 }
 
 enum unit_converter_variant {
+	ADI_LT6106,
 	CURRENT_SENSE_SHUNT,
 	VOLTAGE_DIVIDER,
 };
 
 static const struct unit_converter_cfg unit_converter_cfg[] = {
+	[ADI_LT6106] = {
+		.type = IIO_CURRENT,
+		.props = unit_converter_adi_lt6106_props,
+	},
 	[CURRENT_SENSE_SHUNT] = {
 		.type = IIO_CURRENT,
 		.props = unit_converter_current_sense_shunt_props,
@@ -191,6 +243,8 @@ static const struct unit_converter_cfg unit_converter_cfg[] = {
 };
 
 static const struct of_device_id unit_converter_match[] = {
+	{ .compatible = "adi,lt6106",
+	  .data = &unit_converter_cfg[ADI_LT6106], },
 	{ .compatible = "current-sense-shunt",
 	  .data = &unit_converter_cfg[CURRENT_SENSE_SHUNT], },
 	{ .compatible = "voltage-divider",
-- 
2.11.0

