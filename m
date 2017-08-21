Return-Path: <SRS0=C9z+=7X=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Tue, 22 Aug 2017 00:03:29 +0200
Message-Id: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2 0/7] iio: accel: kxcjk1003: support Kionix KXTF9
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

This series adds support for KXTF9 accelerometer. It is mostly compatible
to KXCJK, but replaces motion direction interrupt with tap detection
(not supported in this implementation, yet).

First 5 patches are refactorings with no outside-visible effects.
Patch 6 fixes sysfs attribute name of sampling_frequency_avail
to match sampling_frequency attribute it describes.
Patch 7 finally adds support for KXTF9 accelerometers.

Michał Mirosław (7):
  iio: accel: kxcjk1003: refactor ODR setting
  iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit names
  iio: accel: kxcjk1013: extract report_motion_event() from interrupt
    handler
  iio: accel: kxcjk1013: rename motion direction bits
  iio: accel: kxcjk1013: make sysfs/sampling_frequency_avail dynamic
  iio: accel: kxcjk1013: make sampling_frequency_avail per-type
  iio: accel: kxcjk1013: add support for KXTF9

 drivers/iio/accel/Kconfig      |   4 +-
 drivers/iio/accel/kxcjk-1013.c | 366 ++++++++++++++++++++++++++---------------
 2 files changed, 235 insertions(+), 135 deletions(-)

-- 
2.11.0
