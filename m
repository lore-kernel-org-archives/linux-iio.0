Return-Path: <SRS0=xymz=X4=it-klinger.de=ak@kernel.org>
Date: Tue, 13 Dec 2016 19:01:16 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, ak@it-klinger.de
Subject: [PATCH 0/2] iio: adc: hx711: Add IIO driver for AVIA HX711 ADC
Message-ID: <20161213180116.GA3151@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

This series adds IIO driver support for the AVIA HX711 ADC which is 
mostly used in weighting cells.

The first patch adds the new DT binding for which a new vendor avia
was also added.

The second patch is the simple IIO driver implemented as ADC.
The protocol is specific to this device and implemented using GPIO's.
Documentation of the chip can be found here:

https://cdn.sparkfun.com/datasheets/Sensors/ForceFlex/hx711_english.pdf

Andreas Klinger (2):
  documented DT-binding avia,hx711
  added avia,hx711 driver

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  23 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/adc/Kconfig                            |  13 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/hx711.c                            | 269 +++++++++++++++++++++
 5 files changed, 307 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
 create mode 100644 drivers/iio/adc/hx711.c

-- 
2.1.4
