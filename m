Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.134]:51508 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755084AbcLNJ7s (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 14 Dec 2016 04:59:48 -0500
Date: Wed, 14 Dec 2016 10:59:13 +0100
From: Andreas Klinger <ak@it-klinger.de>
To: devicetree@vger.kernel.org, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, ak@it-klinger.de
Subject: [PATCH v2 0/2] iio: adc: hx711: Add IIO driver for AVIA HX711 ADC
Message-ID: <20161214095913.GA26500@andreas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds IIO driver support for the AVIA HX711 ADC which is 
mostly used in weighting cells.

The first patch adds the new DT binding for which a new vendor avia
was also added.

The second patch is the simple IIO driver implemented as ADC.
The protocol is specific to this device and implemented using GPIO's.
Documentation of the chip can be found here:

https://cdn.sparkfun.com/datasheets/Sensors/ForceFlex/hx711_english.pdf

Changes:
Lots of updates thanks to Peters review.

* Patch 1: "iio: adc: hx711: Add DT binding for avia,hx711"
  - typo
  - removed unneded section

* Patch 2: "iio: adc: hx711: Add IIO driver for AVIA HX711"
  - updated help text in Kconfig
  - removed dead code
  - removed unused power management
  - reduced channel spec to what is actually used
  - added error handling in case reset of chip not possible

Andreas Klinger (2):
  iio: adc: hx711: Add DT binding for avia,hx711
  iio: adc: hx711: Add IIO driver for AVIA HX711

 .../devicetree/bindings/iio/adc/avia-hx711.txt     |  21 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/iio/adc/Kconfig                            |  18 ++
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/hx711.c                            | 231 +++++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/avia-hx711.txt
 create mode 100644 drivers/iio/adc/hx711.c

-- 
2.1.4

