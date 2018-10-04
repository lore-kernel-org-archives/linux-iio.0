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
Subject: [PATCH v5 2/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date: Wed,  3 Oct 2018 17:14:32 -0700
Message-Id: <20181004001432.21218-3-mka@chromium.org>
In-Reply-To: <20181004001432.21218-1-mka@chromium.org>
References: <20181004001432.21218-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
Changes in v4:
- added unit address to 'die-temp' node
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 048f19fa0150..32b141637d13 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -75,6 +75,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
+
+			die-temp@ADC5_DIE_TEMP {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		rtc@6000 {
-- 
2.19.0.605.g01d371f741-goog
