Return-Path: <SRS0=JcgW=EL=electromag.com.au=preid@kernel.org>
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  robh+dt@kernel.org, mark.rutland@arm.com, Michael.Hennerich@analog.com,
  preid@electromag.com.au, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org, alexandru.ardelean@analog.com
Subject: [PATCH v2 0/2] iio: ad5272: Add support for Analog Devices digital potentiometers
Date: Tue, 16 Jan 2018 17:48:58 +0800
Message-Id: <1516096140-88161-1-git-send-email-preid@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

Add documentation and driver for the Analog Devices 5272.

Driver currently doesn't support programing the RDAC position to 
non-volatile memory. 

Changes from v1:
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
