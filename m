Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:45886 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754335AbdA0I6C (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Jan 2017 03:58:02 -0500
From: Quentin Schulz <quentin.schulz@free-electrons.com>
To: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org,
        sre@kernel.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
Subject: [PATCH v2 19/25] iio: adc: axp20x_adc: map battery IIO channels
Date: Fri, 27 Jan 2017 09:54:52 +0100
Message-Id: <20170127085458.18270-20-quentin.schulz@free-electrons.com>
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This maps the IIO channels batt_v, batt_chrg_i and batt_dischrg_i
(respectively exposing the current charging and discharging currents and
current voltage measures of the battery power supply) to the battery
power supply driver.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 drivers/iio/adc/axp20x_adc.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 14f4ec0..64c7c75 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -112,6 +112,34 @@ static struct iio_map axp20x_maps[] = {
 		.consumer_dev_name = "axp20x-ac-power-supply",
 		.consumer_channel = "acin_i",
 		.adc_channel_label = "acin_i",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_v",
+		.adc_channel_label = "batt_v",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_chrg_i",
+		.adc_channel_label = "batt_chrg_i",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_dischrg_i",
+		.adc_channel_label = "batt_dischrg_i",
+	}, { /* sentinel */ }
+};
+
+static struct iio_map axp22x_maps[] = {
+	{
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_v",
+		.adc_channel_label = "batt_v",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_chrg_i",
+		.adc_channel_label = "batt_chrg_i",
+	}, {
+		.consumer_dev_name = "axp20x-battery-power-supply",
+		.consumer_channel = "batt_dischrg_i",
+		.adc_channel_label = "batt_dischrg_i",
 	}, { /* sentinel */ }
 };
 
@@ -479,6 +507,7 @@ static const struct axp_data axp22x_data = {
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp22x_adc_rate,
 	.adc_en2 = false,
+	.maps = axp22x_maps,
 };
 
 static const struct of_device_id axp20x_adc_of_match[] = {
-- 
2.9.3

