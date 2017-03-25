Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34572 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbdCYQ3z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Mar 2017 12:29:55 -0400
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] Documentation: dt-bindings: add a Meson8b compatible to the SAR ADC
Date: Sat, 25 Mar 2017 17:29:37 +0100
Message-Id: <20170325162938.28659-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
References: <20170325162938.28659-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Amlogic Meson SAR ADC driver can be used on Meson8b as well
(probably on earlier SoC generations as well, but I don't have any
hardware available for testing that).
Add a separate compatible for Meson8b because it does not need any of
the BL30 magic (unlike the GX SoCs).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index f9e3ff2c656e..84a931a0ff1f 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -2,6 +2,7 @@
 
 Required properties:
 - compatible:	depending on the SoC this should be one of:
+			- "amlogic,meson8b-saradc" for Meson8b
 			- "amlogic,meson-gxbb-saradc" for GXBB
 			- "amlogic,meson-gxl-saradc" for GXL
 			- "amlogic,meson-gxm-saradc" for GXM
-- 
2.12.1

