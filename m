Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:47302 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbeCZJC0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Mar 2018 05:02:26 -0400
From: Yixun Lan <yixun.lan@amlogic.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
CC: Xingyu Chen <xingyu.chen@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Yixun Lan <yixun.lan@amlogic.com>, <linux-iio@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] iio: adc: meson-axg: add saradc driver
Date: Mon, 26 Mar 2018 16:46:29 +0800
Message-ID: <20180326084629.100070-4-yixun.lan@amlogic.com>
In-Reply-To: <20180326084629.100070-1-yixun.lan@amlogic.com>
References: <20180326084629.100070-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add the SAR ADC driver for the Amlogic Meson-AXG SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
---
 drivers/iio/adc/meson_saradc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 799ed929ab99..a5d481a2b4ef 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -935,6 +935,11 @@ static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
 	.name = "meson-gxm-saradc",
 };
 
+static const struct meson_sar_adc_data meson_sar_adc_axg_data = {
+	.param = &meson_sar_adc_gxl_param,
+	.name = "meson-axg-saradc",
+};
+
 static const struct of_device_id meson_sar_adc_of_match[] = {
 	{
 		.compatible = "amlogic,meson8-saradc",
@@ -953,6 +958,9 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 	}, {
 		.compatible = "amlogic,meson-gxm-saradc",
 		.data = &meson_sar_adc_gxm_data,
+	}, {
+		.compatible = "amlogic,meson-axg-saradc",
+		.data = &meson_sar_adc_axg_data,
 	},
 	{},
 };
-- 
2.15.1

