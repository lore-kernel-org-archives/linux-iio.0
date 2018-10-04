Return-Path: <SRS0=yMBO=MQ=chromium.org=mka@kernel.org>
From: Matthias Kaehlcke <mka@chromium.org>
To: Andy Gross <andy.gross@linaro.org>,
	David Brown <david.brown@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-arm-msm@vger.kernel.org,
	linux-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v5 1/2] dt-bindings: iio: vadc: Update example to include unit address for node 'usb-id-nopull'
Date: Wed,  3 Oct 2018 17:14:31 -0700
Message-Id: <20181004001432.21218-2-mka@chromium.org>
In-Reply-To: <20181004001432.21218-1-mka@chromium.org>
References: <20181004001432.21218-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The node has a reg property, therefore its name should include a unit
address.

Also change the name from 'usb_id_nopull' to 'usb-id-nopull' to follow
DT conventions.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
Changes in v4:
- patch added to the series
---
 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
index d0c188e5c922..ff7aa5038ba6 100644
--- a/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
+++ b/Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt
@@ -112,7 +112,7 @@ Example:
 		io-channel-ranges;
 
 		/* Channel node */
-		usb_id_nopull {
+		usb-id-nopull@VADC_LR_MUX10_USB_ID {
 			reg = <VADC_LR_MUX10_USB_ID>;
 			qcom,decimation = <512>;
 			qcom,ratiometric;
-- 
2.19.0.605.g01d371f741-goog
