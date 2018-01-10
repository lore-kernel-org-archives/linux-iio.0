Return-Path: <SRS0=Sdo/=EF=electromag.com.au=preid@kernel.org>
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  robh+dt@kernel.org, mark.rutland@arm.com, Michael.Hennerich@analog.com,
  preid@electromag.com.au, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org
Subject: [PATCH 0/2] iio: ad5272: Add support for Analog Devices digital potentiometers
Date: Wed, 10 Jan 2018 14:17:29 +0800
Message-Id: <1515565051-72535-1-git-send-email-preid@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

Add documentation and driver for the Analog Devices 5272.

Driver currently doesn't support programing the RDAC position to 
non-volatile memory. 

Phil Reid (2):
  dt-bindings: ad5272: Add bindings for Analog Devices digital
    potentiometers
  iio: ad5272: Add support for Analog Devices digital potentiometers

 .../bindings/iio/potentiometer/ad5272.txt          |  27 +++
 drivers/iio/potentiometer/Kconfig                  |  10 +
 drivers/iio/potentiometer/Makefile                 |   1 +
 drivers/iio/potentiometer/ad5272.c                 | 219 +++++++++++++++++++++
 4 files changed, 257 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/ad5272.txt
 create mode 100644 drivers/iio/potentiometer/ad5272.c

-- 
1.8.3.1
