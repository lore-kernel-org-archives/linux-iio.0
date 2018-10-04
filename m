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
Subject: [PATCH v5 0/2] arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC
Date: Wed,  3 Oct 2018 17:14:30 -0700
Message-Id: <20181004001432.21218-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This series adds a channel for the die temperature to the QCOM SPMI
PMIC5 ADC. It also fixes an example in the DT documentation.

The die temperature is going to be used by the temperature alarm driver
(https://lore.kernel.org/patchwork/project/lkml/list/?series=361416).

The former name of the series was "arm64: dts: qcom: pm8998: Add ADC
node and die temperature channel"
(https://patchwork.kernel.org/project/linux-arm-msm/list/?series=17165),
2 of the 3 patches of this series already landed in Andy's tree, hence
the new name.

Matthias Kaehlcke (2):
  dt-bindings: iio: vadc: Update example to include unit address for
    node 'usb-id-nopull'
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 Documentation/devicetree/bindings/iio/adc/qcom,spmi-vadc.txt | 2 +-
 arch/arm64/boot/dts/qcom/pm8998.dtsi                         | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.19.0.605.g01d371f741-goog
