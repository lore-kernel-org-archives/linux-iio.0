Return-Path: <SRS0=wkc1=E7=novotny.cz=tomas@kernel.org>
From: Tomas Novotny <tomas@novotny.cz>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 0/2] iio: vcnl4000: add support for vcnl4200
Date: Mon,  5 Feb 2018 19:04:22 +0100
Message-Id: <20180205180424.30725-1-tomas@novotny.cz>
List-ID: <linux-iio@vger.kernel.org>

VCNL4200 is another proximity and ambient light sensor from Vishay. I'm
adding support for that sensor to vcnl4000 driver, which currently supports
VCNL4000/10/20.

The VCNL4200 is a bit different from VCNL4000/10/20. Common things are:
- integrated proximity and ambient light sensor
- SMBus compatible I2C interface
- Vishay VCNL4xxx series...

Different things are:
- totally different register map
- 8-bit vs. 16-bit registers. The 16-bit values are in two 8-bit registers on
  VCNL4000. 16-bit value is in one register on VCNL4200.
- VCNL4000 has flags when the measurement is finished

The first patch generalizes the driver to support differencies. The second
patch adds the support for VCNL4200.

It is tested on VCNL4020 and VCNL4200.

Tomas Novotny (2):
  iio: vcnl4000: make the driver extendable
  iio: vcnl4000: add support for VCNL4200

 drivers/iio/light/Kconfig    |   5 +-
 drivers/iio/light/vcnl4000.c | 158 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 140 insertions(+), 23 deletions(-)

-- 
2.12.3
