Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37924 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbcBAUVy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Feb 2016 15:21:54 -0500
To: Greg KH <gregkh@linuxfoundation.org>
Subject: [PULL] Second set of IIO fixes for the 4.5 cycle - dependent on merge
 window patches.
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56AFBE60.7030509@kernel.org>
Date: Mon, 1 Feb 2016 20:21:52 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 02c34ccc1d2d528d2de2897881b97933363432b5:

  Merge tag 'iio-for-4.5c' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2015-12-26 17:05:25 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.5b

for you to fetch changes up to 17a2f46c3d8877fe2a0b6ff391d1df30e67892a6:

  iio: dht11: Use boottime (2016-02-01 20:16:13 +0000)

----------------------------------------------------------------
Second set of IIO fixes for the 4.5 cycle.  These ones are mostly
dependent on patches from the recent merge cycle.

* adc, imu and iio staging drivers
  - !HAS_IOMEM dependency fixes
* dht11
  - use boottime clock for time measurement to avoid incorrect measurements
   due to clock updates.
* lidar
  - correct a return value for short i2c transfers.

----------------------------------------------------------------
Abhilash Jindal (1):
      iio: dht11: Use boottime

Matt Ranostay (1):
      iio: proximity: lidar: correct return value

Richard Weinberger (3):
      iio: adc: Fix dependencies for !HAS_IOMEM archs
      staging: iio: Fix dependencies for !HAS_IOMEM archs
      iio: imu: Fix dependencies for !HAS_IOMEM archs

 drivers/iio/adc/Kconfig                           | 3 +++
 drivers/iio/humidity/dht11.c                      | 8 ++++----
 drivers/iio/imu/inv_mpu6050/Kconfig               | 2 +-
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
 drivers/staging/iio/adc/Kconfig                   | 1 +
 5 files changed, 10 insertions(+), 6 deletions(-)
