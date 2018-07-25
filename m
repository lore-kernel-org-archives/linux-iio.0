Return-Path: <SRS0=alW1=KJ=tbs-biometrics.com=tomas.novotny@kernel.org>
From: Tomas Novotny <tomas.novotny@tbs-biometrics.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Tomas Novotny <tomas@novotny.cz>
Subject: [PATCH v3 0/4] iio: vcnl4000: add support for vcnl4200
Date: Wed, 25 Jul 2018 17:18:17 +0200
Message-Id: <20180725151821.17566-1-tomas.novotny@tbs-biometrics.com>
List-ID: <linux-iio@vger.kernel.org>

From: Tomas Novotny <tomas@novotny.cz>

VCNL4200 is another proximity and ambient light sensor from Vishay. I'm
adding support for that sensor to vcnl4000 driver, which currently supports
VCNL4000/10/20.

The VCNL4200 is a bit different from VCNL4000/10/20. Common things are:
- integrated proximity and ambient light sensor
- SMBus compatible I2C interface
- Vishay VCNL4xxx series...

Different things are:
- totally different register map
- 8-bit vs. 16-bit registers. The 16-bit values are in two 8-bit registers
  on VCNL4000. 16-bit value is in one register on VCNL4200.
- VCNL4000 has flags when the measurement is finished
- blocking read is implemented for vcnl4200 (there is no 'ready' flag, just
  interrupts)

It is tested on VCNL4020 and VCNL4200.

Changes in v3:
- improve commit message of 2/4 (clearly state that it is groundwork for
  another change)
- add vcnl4020 device id to the list of supported ids

Changes in v2:
- reading light and proximity values for vcnl4200 is blocking (if you
  request new value too early)
- patches 2 and 3 were added; original patch 2 is now patch 4
- vcnl4010 id is handled (patch 2)
- warn user on incorrect usage of vcnl40{0,1}0 id (patch 3)
- minor stuff (add parenthesis, switch instead of if, rename sensors to
  channels, fix return)

Tomas Novotny (4):
  iio: vcnl4000: make the driver extendable
  iio: vcnl4000: add VCNL4010 and VCNL4020 device id
  iio: vcnl4000: warn on incorrectly specified device id
  iio: vcnl4000: add support for VCNL4200

 drivers/iio/light/Kconfig    |   5 +-
 drivers/iio/light/vcnl4000.c | 220 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 197 insertions(+), 28 deletions(-)

-- 
2.12.3
