Return-Path: <SRS0=611I=FD=electromag.com.au=preid@kernel.org>
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  robh+dt@kernel.org, mark.rutland@arm.com, Michael.Hennerich@analog.com,
  preid@electromag.com.au, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org, martinbv@mothictech.com
Subject: [PATCH v5 0/2] iio: ad5272: Add support for Analog Devices digital potentiometers
Date: Fri,  9 Feb 2018 08:57:25 +0800
Message-Id: <1518137847-63381-1-git-send-email-preid@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

Add documentation and driver for the Analog Devices 5272.

Driver currently doesn't support programing the RDAC position to 
non-volatile memory. 

Changes from v4:
- Remove references to drie in bindings
- Fix C&P error in binding doc for reset input. 
- fix typo in comment of driver.

Changes from v3:
- move SPDX-License-Identifier to line 1
- add AD5274 to Kconfig description
- Add missing empty line before return

Changes from v2:
- docs: Fix polarity of reset-gpio example to match driver
- Use a cached aligned buffer for i2c
- remove old invalid comment from c&p

Changes from v1:
- Use spdx license id
- Use sizeof for i2c buffer lens
- Condense code a little when setting up i2c buf
- check val2 in raw write
- Add reset function. Perform a software reset if
  gpio reset pin is not defined
- remove THIS_MODULE assignment
- change of data to use index as per i2c device table


Phil Reid (2):
  dt-bindings: ad5272: Add bindings for Analog Devices digital
    potentiometers
  iio: ad5272: Add support for Analog Devices digital potentiometers

 .../bindings/iio/potentiometer/ad5272.txt          |  27 +++
 drivers/iio/potentiometer/Kconfig                  |  10 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ad5272.c                 | 227 +++++++++++++++++++++
 4 files changed, 265 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
 create mode 100644 drivers/iio/potentiometer/ad5272.c

-- 
1.8.3.1
