Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: [PATCH v2 0/7] cm3323 fixes and cleanups
Date: Thu, 18 Jun 2015 00:31:58 +0200
Message-Id: <cover.1434578207.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Some small fixes and cleanups.

Changes in V2:
  - apply the integration time bitmask right
  - fix order of GENMASK arguments as pointed out by Peter Meerwald

Hartmut Knaack (7):
  iio:light:cm3323: clear bitmask before set
  iio:light:Kconfig: fix typo in description
  iio:light:cm3323: pass up error value
  iio:light:cm3323: drop barely used variable
  iio:light:cm3323: replace unneeded variable
  iio:light:cm3323: make use of GENMASK
  iio:light:cm3323: add empty lines for code structure

 drivers/iio/light/Kconfig  |  2 +-
 drivers/iio/light/cm3323.c | 27 +++++++++++++++------------
 2 files changed, 16 insertions(+), 13 deletions(-)

-- 
2.3.6
