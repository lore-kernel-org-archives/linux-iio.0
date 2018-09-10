Return-Path: <SRS0=YpYK=LY=chromium.org=mka@kernel.org>
From: Matthias Kaehlcke <mka@chromium.org>
To: Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/3] dt-bindings: iio: vadc: Fix documentation of 'reg'
Date: Mon, 10 Sep 2018 09:02:59 -0700
Message-Id: <20180910160301.237538-2-mka@chromium.org>
In-Reply-To: <20180910160301.237538-1-mka@chromium.org>
References: <20180910160301.237538-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The documentation of Qualcomm's SPMI PMIC voltage ADC claims that the
'reg' property consists of two values, the SPMI address and the length
of the controller's registers. However the SPMI bus to which it is added
specifies "#size-cells = <0>;". Remove the controller register length
from the documentation of the field and the example.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---
Changes in v3:
- fixed separator in commit message
- removed duplicate 'Signed-off-by' tag

Changes in v2:
- none
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index 0fb46137f936..d0c188e5c922 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -13,7 +13,7 @@ VADC node:
 - reg:
     Usage: required
     Value type: <prop-encoded-array>
-    Definition: VADC base address and length in the SPMI PMIC register map.
+    Definition: VADC base address in the SPMI PMIC register map.
 
 - #address-cells:
     Usage: required
@@ -104,7 +104,7 @@ Example:
 	/* VADC node */
 	pmic_vadc: vadc@3100 {
 		compatible = "qcom,spmi-vadc";
-		reg = <0x3100 0x100>;
+		reg = <0x3100>;
 		interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
