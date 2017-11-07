Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-sh2.amlogic.com ([58.32.228.45]:59327 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752699AbdKGO1O (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Nov 2017 09:27:14 -0500
From: Yixun Lan <yixun.lan@amlogic.com>
To: Jonathan Cameron <jic23@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, Kevin Hilman <khilman@baylibre.com>
CC: Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        "Yixun Lan" <yixun.lan@amlogic.com>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/4] dt-bindings: iio: adc: update the doc for SAR ADC
Date: Tue, 7 Nov 2017 22:10:20 +0800
Message-ID: <20171107141020.30419-1-yixun.lan@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Update the doc as the SAR ADC modules doesn't require "sana" clock.

Singed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index f413e82c8b83..1e6ee3deb4fa 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -15,7 +15,6 @@ Required properties:
 			- "clkin" for the reference clock (typically XTAL)
 			- "core" for the SAR ADC core clock
 		optional clocks:
-			- "sana" for the analog clock
 			- "adc_clk" for the ADC (sampling) clock
 			- "adc_sel" for the ADC (sampling) clock mux
 - vref-supply:	the regulator supply for the ADC reference voltage
-- 
2.14.1

