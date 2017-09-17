Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:59992
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751628AbdIQPBD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2017 11:01:03 -0400
Date: Sun, 17 Sep 2017 17:00:59 +0200
Message-Id: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v3 0/8] iio: accel: kxcjk1003: support Kionix KXTF9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This series adds support for KXTF9 accelerometer. It is mostly compatible
to KXCJK, but replaces motion direction interrupt with tap detection
(not supported in this implementation, yet).

First 4 patches are refactorings with no outside-visible effects.
Patch 5 fixes sysfs attribute name of sampling_frequency_avail
	to match sampling_frequency attribute it describes.
Patch 6 adds support for KXTF9 accelerometers.
Patch 7 drops -1013 suffix from driver name.

---
v3:
	- renamed samp_freq_avail[]
	- dropped direction bits rename
	- added driver rename
	- rebased against v4.14-rc1
v2:
	- removed register renaming
	- split report_motion_event() patch
---

Michał Mirosław (8):
  iio: accel: kxcjk1003: refactor ODR setting
  iio: accel: kxcjk1013: fix INT_CTRL/INT_SRC1 bit names
  iio: accel: kxcjk1013: extract report_motion_event() from interrupt
    handler
  iio: accel: kxcjk1013: make sysfs/sampling_frequency_avail dynamic
  iio: accel: kxcjk1013: make sampling_frequency_avail per-type
  iio: accel: kxcjk1013: add support for KXTF9
  iio: accel: kxcjk1013: remove unused platform data struct
  iio: accel: kxcjk1013: drop variation number from driver's name

 drivers/iio/accel/Kconfig            |    9 +-
 drivers/iio/accel/Makefile           |    2 +-
 drivers/iio/accel/kxcjk-1013.c       | 1426 --------------------------------
 drivers/iio/accel/kxcjk.c            | 1514 ++++++++++++++++++++++++++++++++++
 include/linux/iio/accel/kxcjk_1013.h |   22 -
 5 files changed, 1519 insertions(+), 1454 deletions(-)
 delete mode 100644 drivers/iio/accel/kxcjk-1013.c
 create mode 100644 drivers/iio/accel/kxcjk.c
 delete mode 100644 include/linux/iio/accel/kxcjk_1013.h

-- 
2.11.0

