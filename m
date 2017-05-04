Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34364 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbdEDSCC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 14:02:02 -0400
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/3] dt-bindings: iio: adc: add Meson8 and Meson8b support
Date: Thu,  4 May 2017 20:01:35 +0200
Message-Id: <20170504180136.27025-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
References: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The Amlogic Meson SAR ADC driver can be used on Meson8 and Meson8b
(probably on earlier SoC generations as well, but I don't have any
hardware available for testing that).
Add a separate compatible for Meson8 and Meson8b because it does not
need any of the BL30 magic (unlike the GX SoCs).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index f9e3ff2c656e..08cee82e54c3 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -2,6 +2,8 @@
 
 Required properties:
 - compatible:	depending on the SoC this should be one of:
+			- "amlogic,meson8-saradc" for Meson8
+			- "amlogic,meson8b-saradc" for Meson8b
 			- "amlogic,meson-gxbb-saradc" for GXBB
 			- "amlogic,meson-gxl-saradc" for GXL
 			- "amlogic,meson-gxm-saradc" for GXM
-- 
2.12.2

