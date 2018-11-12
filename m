Return-Path: <SRS0=anu/=NX=chromium.org=mka@kernel.org>
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
Subject: [PATCH v6 0/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date: Mon, 12 Nov 2018 14:11:24 -0800
Message-Id: <20181112221126.27142-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This series adds a channel for the die temperature to the QCOM SPMI
PMIC5 ADC. It also fixes an example in the DT documentation.

Matthias Kaehlcke (2):
  dt-bindings: iio: vadc: Add unit address to ADC channel node in
    example
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../devicetree/bindings/iio/adc/qcom,spmi-vadc.txt          | 6 +++++-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                        | 5 +++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-- 
2.19.1.930.g4563a0d9d0-goog
