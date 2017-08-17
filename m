Return-Path: <SRS0=wvzB=7T=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 17 Aug 2017 16:21:34 +0200
Message-Id: <cover.1502979014.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/6] iio: accel: kxcjk1003: support Kionix KXTF9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

This series adds support for KXTF9 accelerometer. It is mostly compatible
to KXCJK, but replaces motion direction interrupt with tap detection
(not supported in this implementation, yet).

First 4 patches are refactorings with no outside-visible effects. 
Patch 5 changes sysfs attribute name of sampling_frequency_avail
to match sampling_frequency attribute it describes.

Michał Mirosław (6):
  iio: accel: kxcjk1003: refactor ODR setting
  iio: accel: kxcjk1013: extract report_motion_event() from interrupt
    handler
  iio: accel: kxcjk1013: rename registers for KXTF9 compatibility
  iio: accel: kxcjk1013: make sysfs/sampling_frequency_avail dynamic
  iio: accel: kxcjk1013: make sampling_frequency_avail per-type
  iio: accel: kxcjk1013: add support for KXTF9

 drivers/iio/accel/Kconfig      |   4 +-
 drivers/iio/accel/kxcjk-1013.c | 448 +++++++++++++++++++++++++----------------
 2 files changed, 276 insertions(+), 176 deletions(-)

-- 
2.11.0
