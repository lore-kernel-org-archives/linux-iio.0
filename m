Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732849AbeKVGUL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Nov 2018 01:20:11 -0500
Date: Wed, 21 Nov 2018 19:44:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Subject: [PULL] First set of IIO fixes for 4.20
Message-ID: <20181121194428.4ef99077@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 310c7585e8300ddc46211df0757c11e4299ec482:

  Merge tag 'nfsd-4.20' of git://linux-nfs.org/~bfields/linux (2018-10-30 13:03:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.20a

for you to fetch changes up to 0145b50566e7de5637e80ecba96c7f0e6fff1aad:

  iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for signed numbers (2018-11-16 11:42:12 +0000)

----------------------------------------------------------------
First set of IIO fixes for the 4.20 cycle.

* st_magn
  - Avoid an ordering issue that lead to large numbers of unhandled
    interrupts whilst enabling buffered capture.
* hid-sensors
  - Fix a long running problem with signed values reading wrong from
    sysfs on these sensors.   It appears people were only using the
    buffered interface.  These typically occur in laptops so chances
    are everyone was using the sensor-proxy which will use the buffered
    interface by default.

----------------------------------------------------------------
Hans de Goede (1):
      iio/hid-sensors: Fix IIO_CHAN_INFO_RAW returning wrong values for signed numbers

Martin Kelly (1):
      iio:st_magn: Fix enable device after trigger

 drivers/hid/hid-sensor-custom.c                  |  2 +-
 drivers/hid/hid-sensor-hub.c                     | 13 ++++++++++---
 drivers/iio/accel/hid-sensor-accel-3d.c          |  5 ++++-
 drivers/iio/gyro/hid-sensor-gyro-3d.c            |  5 ++++-
 drivers/iio/humidity/hid-sensor-humidity.c       |  3 ++-
 drivers/iio/light/hid-sensor-als.c               |  8 +++++---
 drivers/iio/light/hid-sensor-prox.c              |  8 +++++---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c    |  8 +++++---
 drivers/iio/magnetometer/st_magn_buffer.c        | 12 +++---------
 drivers/iio/orientation/hid-sensor-incl-3d.c     |  8 +++++---
 drivers/iio/pressure/hid-sensor-press.c          |  8 +++++---
 drivers/iio/temperature/hid-sensor-temperature.c |  3 ++-
 drivers/rtc/rtc-hid-sensor-time.c                |  2 +-
 include/linux/hid-sensor-hub.h                   |  4 +++-
 14 files changed, 55 insertions(+), 34 deletions(-)
