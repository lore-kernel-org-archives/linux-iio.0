Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45836 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab3CEU76 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Mar 2013 15:59:58 -0500
Message-ID: <51365CCB.9020105@kernel.org>
Date: Tue, 05 Mar 2013 20:59:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 3.9 post merge window
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 76426daf50d5df38893cc189e9ccd026093debc8:

  staging/zcache: Fix/improve zcache writeback code, tie to a config option (2013-02-11 14:58:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.9a

for you to fetch changes up to 852afe99fc1c2d2b1376e49f128a3b929e811f2d:

  iio:common:st_sensors fixed all warning messages about uninitialized variables (2013-03-05 18:14:13 +0000)

----------------------------------------------------------------
First round of iio fixes post the 3.9 merge window.

1) Some little fixes for the ad5064 dac driver.
2) A build warning 'fix' for a false positive in st_sensors
3) A couple of missing dependencies on IIO_BUFFER.

So nothing major and these mostly showed the advantages of the randconfig
builds various people have performed.

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:common:st_sensors fixed all warning messages about uninitialized variables

Guenter Roeck (2):
      iio/imu: inv_mpu6050 depends on IIO_BUFFER
      iio: Fix build error seen if IIO_TRIGGER is defined but IIO_BUFFER is not

Lars-Peter Clausen (3):
      iio:ad5064: Fix address of the second channel for ad5065/ad5045/ad5025
      iio:ad5064: Fix off by one in DAC value range check
      iio:ad5064: Initialize register cache correctly

 drivers/iio/common/st_sensors/st_sensors_core.c |  9 ++--
 drivers/iio/dac/ad5064.c                        | 64 +++++++++++++++----------
 drivers/iio/imu/inv_mpu6050/Kconfig             |  1 +
 include/linux/iio/common/st_sensors.h           |  9 ++--
 4 files changed, 49 insertions(+), 34 deletions(-)
