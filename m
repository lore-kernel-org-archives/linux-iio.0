Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH 0/5] stk3310 fixes and cleanup
Date: Sat,  4 Jul 2015 17:56:56 +0200
Message-Id: <cover.1436024257.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

This patch series is based on top of Tiberiu Breanas patch [1]
"[PATCH v2] iio: light: STK3310: un-invert proximity values", although the
first patch fixing REGMAP_I2C dependeny can be applied independently.

[1]https://marc.info/?l=linux-iio&m=143575387110520

Hartmut Knaack (5):
  iio:light:stk3310: Fix REGMAP_I2C dependency
  iio:light:stk3310: make endianness independent of host
  iio:light:stk3310: add more error handling
  iio:light:stk3310: use correct names and type for state
  iio:light:stk3310: adjust indentation

 drivers/iio/light/Kconfig   |  1 +
 drivers/iio/light/stk3310.c | 88 ++++++++++++++++++++++++++++++---------------
 2 files changed, 61 insertions(+), 28 deletions(-)

-- 
2.3.6
