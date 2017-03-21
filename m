Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40809 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933227AbdCUTeg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Mar 2017 15:34:36 -0400
To: Greg KH <gregkh@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] Third set of IIO fixes for the 4.11 cycle.
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f66d4045-58df-ef11-587a-9834904d38cc@kernel.org>
Date: Tue, 21 Mar 2017 19:25:46 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 2d62e0768d3c28536d4cfe4c40ba1e5e8e442a93:

  Merge tag 'kvm-4.11-2' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2017-03-04 11:36:19 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.11c

for you to fetch changes up to 6985bd5e21901c2d2bfc924b114887e20c002901:

  iio: imu: st_lsm6dsx: fix FIFO_CTRL2 overwrite during watermark configuration (2017-03-19 10:44:42 +0000)

----------------------------------------------------------------
Thirds set of IIO fixes for the 4.11 cycle.

* core
  - iio sw-device - ensure configfs is enabled both when building as module
  and built in.
* ak8974
  - drop incorrect __exit markup on remove.
* hid-sensor-trigger
  - code reorganise to avoid losing settings if a power cycle occurs during S3.
* lsm6dsx
  - fix incorrect overwrite of parts of FIFO_CTRL2 register during watermark
  configuration.
* ti-am335x
  - fix a hard to hit bug when reenabling from a fifo overrun by waiting for
  current cycle to finish.

----------------------------------------------------------------
Dmitry Torokhov (1):
      iio: magnetometer: ak8974: remove incorrect __exit markups

Lars-Peter Clausen (1):
      iio: sw-device: Fix config group initialization

Lorenzo Bianconi (1):
      iio: imu: st_lsm6dsx: fix FIFO_CTRL2 overwrite during watermark configuration

Michael Engl (1):
      iio: adc: ti_am335x_adc: fix fifo overrun recovery

Song Hongyan (1):
      iio: hid-sensor-trigger: Change get poll value function order to avoid sensor properties losing after resume from S3

 drivers/iio/adc/ti_am335x_adc.c                     | 13 ++++++++++++-
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c |  6 +++---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c      |  4 ++--
 drivers/iio/magnetometer/ak8974.c                   |  4 ++--
 include/linux/iio/sw_device.h                       |  2 +-
 5 files changed, 20 insertions(+), 9 deletions(-)
