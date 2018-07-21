Return-Path: <SRS0=Uoy5=KF=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] dt-bindings: iio: adc: add Meson8m2 support
Date: Sat, 21 Jul 2018 21:40:48 +0200
Message-Id: <20180721194049.23265-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
References: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
List-ID: <linux-iio@vger.kernel.org>

The Amlogic Meson SAR ADC implementation on the Meson8m2 SoC is
identical to the Meson8b variant. Add a compatible string to indicate
that we support the SAR ADC on the Meson8m2 SoC.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 .../devicetree/bindings/iio/adc/amlogic,meson-saradc.txt         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
index d1acd5ea2737..54b823f3a453 100644
--- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.txt
@@ -4,6 +4,7 @@ Required properties:
 - compatible:	depending on the SoC this should be one of:
 			- "amlogic,meson8-saradc" for Meson8
 			- "amlogic,meson8b-saradc" for Meson8b
+			- "amlogic,meson8m2-saradc" for Meson8m2
 			- "amlogic,meson-gxbb-saradc" for GXBB
 			- "amlogic,meson-gxl-saradc" for GXL
 			- "amlogic,meson-gxm-saradc" for GXM
-- 
2.18.0
