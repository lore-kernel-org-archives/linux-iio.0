Return-Path: <stefan@agner.ch>
From: Stefan Agner <stefan@agner.ch>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	robh+dt@kernel.org,
	pawel.moll@arm.com,
	mark.rutland@arm.com,
	ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org,
	B38611@freescale.com,
	maitysanchayan@gmail.com,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Agner <stefan@agner.ch>
Subject: [PATCH v2 0/3] iio: adc: vf610: respect ADC clocking limitations
Date: Mon, 16 Mar 2015 16:10:11 +0100
Message-Id: <1426518614-20201-1-git-send-email-stefan@agner.ch>
List-ID: <linux-iio@vger.kernel.org>

Respect ADC clocking limitations. The current clock settings lead
to bogous reading on a 500MHz clocked Vybrid SoC's. Additionally,
also implement a sysfs-property to configure the conversion mode
available in this ADC peripherial.

Changes since v1:
- Use ext_info for conversion mode

Stefan Agner (3):
  iio: adc: vf610: use ADC clock within specification
  iio: adc: vf610: implement configurable conversion modes
  ARM: dts: add property for maximum ADC clock frequencies

 .../devicetree/bindings/iio/adc/vf610-adc.txt      |   9 +
 arch/arm/boot/dts/vfxxx.dtsi                       |   4 +
 drivers/iio/adc/vf610_adc.c                        | 225 +++++++++++++++------
 3 files changed, 172 insertions(+), 66 deletions(-)

-- 
2.3.3
