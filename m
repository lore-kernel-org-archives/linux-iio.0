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
Subject: [PATCH v2 0/3] arm64: dts: qcom: pm8998: Add ADC node and die temperature channel
Date: Thu,  6 Sep 2018 14:04:51 -0700
Message-Id: <20180906210454.247219-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

This series adds the DT node for the QCOM SPMI PMIC5 ADC and a channel
for the die temperature.

The die temperature is going to be used by the temperature alarm driver
(https://lore.kernel.org/patchwork/project/lkml/list/?series=361416).

My understanding is that some of the ADC channels are/can be universally
useful on devices with a pm8998, while the use of others is device specific
(e.g. AMUX). Siddartha / QCA folks, are there other generally useful ADC
channels that should be added here?

The driver for the QCOM SPMI PMIC5 ADC landed in the 'testing' branch of the
'iio' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=e13d757279bbc59776c8435fb94e54b5a58bdd0b

Matthias Kaehlcke (3):
  dt-bindings: iio: vadc: Fix documentation of 'reg'
  arm64: dts: qcom: pm8998: Add adc node
  arm64: dts: qcom: pm8998: Add die temperature channel node to the ADC

 .../bindings/iio/adc/qcom,spmi-vadc.txt         |  4 ++--
 arch/arm64/boot/dts/qcom/pm8998.dtsi            | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

-- 
2.19.0.rc2.392.g5ba43deb5a-goog
