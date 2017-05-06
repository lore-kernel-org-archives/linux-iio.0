Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36488 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbdEFNuB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 6 May 2017 09:50:01 -0400
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, thomas.langer@intel.com,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v4 2/3] dt-bindings: iio: adc: add Meson8 and Meson8b support
Date: Sat,  6 May 2017 15:49:28 +0200
Message-Id: <20170506134929.31190-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170506134929.31190-1-martin.blumenstingl@googlemail.com>
References: <20170506134929.31190-1-martin.blumenstingl@googlemail.com>
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

