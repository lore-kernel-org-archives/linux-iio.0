Return-Path: <SRS0=Kv0d=LU=chromium.org=mka@kernel.org>
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
Subject: [PATCH v2 3/3] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date: Thu,  6 Sep 2018 14:04:54 -0700
Message-Id: <20180906210454.247219-4-mka@chromium.org>
In-Reply-To: <20180906210454.247219-1-mka@chromium.org>
References: <20180906210454.247219-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Add a channel node for the die temperature to the ADC.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
--
Changes in v2:
- none
---
 arch/arm64/boot/dts/qcom/pm8998.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 41593ebbea2c..d18d4f260fbe 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -19,6 +19,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
+
+			die-temp {
+				reg = <ADC5_DIE_TEMP>;
+				label = "die_temp";
+			};
 		};
 
 		pm8998_gpio: gpios@c000 {
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
