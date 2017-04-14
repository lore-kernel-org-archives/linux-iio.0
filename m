Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56935 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751896AbdDNP7u (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 Apr 2017 11:59:50 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Subject: [PULL] 5th set of IIO fixes for the 4.11 cycle.
Message-ID: <1dbc0f18-d35b-2ee4-aeb5-db765388579e@kernel.org>
Date: Fri, 14 Apr 2017 16:59:48 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit a6d361404d81a03107a3475876afc22e1b84d5de:

  Merge tag 'iio-fixes-for-4.11d' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2017-04-03 15:28:14 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.11e

for you to fetch changes up to ed3730c435f1a9f9559ed7762035d22d8a95adfe:

  IIO: bmp280-core.c: fix error in humidity calculation (2017-04-14 16:54:49 +0100)

----------------------------------------------------------------
Fifth set of IIO fixes for the 4.11 cycle.

As these are rather late in the cycle, they may sneak over into 4.12.
There is a fix for a regression caused by another fix (hid sensors
hardware seems to vary a lot in how various corner cases are handled).

* ad7303
  - fix channel description. Numeric values were being passed as characters
  presumably leading to garbage from the userspace interface.
* as3935
  - the write data macro was wrong so fix it.
* bmp280
  - incorrect handling of negative values as being unsigned broke humidity
  calculation.
* hid-sensor
  - Restore the poll and hysteresis values after resume as some hardware
  doesn't do it.
* stm32-trigger
  - buglet in reading the sampling frequency

----------------------------------------------------------------
Andreas Klinger (1):
      IIO: bmp280-core.c: fix error in humidity calculation

Fabrice Gasnier (1):
      iio: stm32 trigger: fix sampling_frequency read

Matt Ranostay (1):
      iio: proximity: as3935: fix as3935_write

Pavel Roskin (1):
      iio: dac: ad7303: fix channel description

Srinivas Pandruvada (1):
      iio: hid-sensor: Store restore poll and hysteresis on S3

 .../iio/common/hid-sensors/hid-sensor-attributes.c | 26 ++++++++++++++++++++--
 .../iio/common/hid-sensors/hid-sensor-trigger.c    | 20 ++++++++++++++---
 drivers/iio/dac/ad7303.c                           |  6 ++---
 drivers/iio/pressure/bmp280-core.c                 | 11 ++++-----
 drivers/iio/proximity/as3935.c                     |  3 +--
 drivers/iio/trigger/stm32-timer-trigger.c          |  6 ++---
 include/linux/hid-sensor-hub.h                     |  2 ++
 7 files changed, 56 insertions(+), 18 deletions(-)
