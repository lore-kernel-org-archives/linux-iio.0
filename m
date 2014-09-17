Return-Path: <maitysanchayan@gmail.com>
From: Sanchayan Maity <maitysanchayan@gmail.com>
To: shawn.guo@freescale.com
Cc: stefan@agner.ch,
	B38611@freescale.com,
	linux@arm.linux.org.uk,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	Sanchayan Maity <maitysanchayan@gmail.com>
Subject: [PATCH 0/2] Add ADC support for Colibri VF61 and implement temperature sensor for vf610-adc
Date: Wed, 17 Sep 2014 13:53:15 +0530
Message-Id: <cover.1410873422.git.maitysanchayan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Add ADC nodes for Colibri VF61 modules.

Vybrid ADC module includes a temperature sensor which
is connected to channel number 26. This patch adds
support for the sensor. The raw value is read and the
temperature calculated in degree Celsius which is
returned using the IIO_CHAN_INFO_PROCESSED option.

Sanchayan Maity (2):
  ARM: dts: vf610-colibri: Add ADC support
  ARM: imx: vf610-adc: Add temperature sensor support

 arch/arm/boot/dts/vf610-colibri.dtsi |   10 ++++++++++
 drivers/iio/adc/vf610_adc.c          |   34 +++++++++++++++++++++++++++++++---
 2 files changed, 41 insertions(+), 3 deletions(-)

-- 
1.7.9.5
