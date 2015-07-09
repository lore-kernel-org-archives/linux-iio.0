Return-Path: <knaack.h@gmx.de>
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tiberiu Breana <tiberiu.a.breana@intel.com>
Subject: [PATCH v2 0/5] stk3310 fixes and cleanup
Date: Thu,  9 Jul 2015 23:51:28 +0200
Message-Id: <cover.1436398691.git.knaack.h@gmx.de>
List-ID: <linux-iio@vger.kernel.org>

Changes in V2:
  * move interrupt setup before device registration, as pointed out by
    Jonathan and confirmed by Tiberiu Breana
  * incooperate a check for negative-only values of the provided irq
    number, as requested by Tiberiu Breana

Hartmut Knaack (5):
  iio:light:stk3310: move device register to end of probe
  iio:light:stk3310: make endianness independent of host
  iio:light:stk3310: add more error handling
  iio:light:stk3310: use correct names and type for state
  iio:light:stk3310: adjust indentation

 drivers/iio/light/stk3310.c | 97 ++++++++++++++++++++++++++++++---------------
 1 file changed, 64 insertions(+), 33 deletions(-)

-- 
2.4.3
