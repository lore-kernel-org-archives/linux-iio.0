Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57250 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030416Ab2K3Nam (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Nov 2012 08:30:42 -0500
Message-ID: <50B8B500.6040802@kernel.org>
Date: Fri, 30 Nov 2012 13:30:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new drivers and fixes (IIO set 6 for the 3.8
 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e143ef8f297d980037149fe2dc62af72621a0f5e:

  staging: gdm72xx: unlock on error in init_usb() (2012-11-29 18:16:15 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.8f

for you to fetch changes up to 583f2deb9349eb55d913eb92a31273f3907d72ea:

  iio: imu: adis16480: remove duplicated include from adis16480.c (2012-11-30 13:11:46 +0000)

----------------------------------------------------------------
6th set of IIO new driver support, clean up and fixes for the 3.8 cycle
(possibly wait until 3.9 cycle given timing).

Here we have
* the cleanup and move out of staging of ad7793.
* addition support for additional parts to ad7793.
* a basic new driver for TI ADC081C021/027
* 4 little fixes for the recent addition of ad16136 and ad16480.

So some nice work with nothing controversial or anything that
will effect stuff outside the drivers in question.

----------------------------------------------------------------
Dan Carpenter (2):
      iio:gyro: adis16136: divide by zero in write_frequency()
      iio:imu: adis16480: show_firmware() buffer too small

Lars-Peter Clausen (11):
      staging:iio:ad7793: Fix VDD monitor scale
      staging:iio:ad7793: Fix temperature scale
      staging:iio:ad7793: Use usleep_range instead of msleep
      staging:iio:ad7793: Use kstrtol instead of strict_strtol
      staging:iio:ad7793: Rework platform data
      staging:iio:ad7793: Rework regulator handling
      staging:iio:ad7793: Move register definitions from header to source
      staging:iio:ad7793: Implement stricter id checking
      staging:iio: Move ad7793 driver out of staging
      iio:ad7793: Add support for the ad7798 and ad7799
      iio:ad7793: Add support for the ad7796 and ad7797

Thierry Reding (1):
      iio: adc: Add Texas Instruments ADC081C021/027 support

Wei Yongjun (2):
      iio: gyro: adis16136: remove duplicated include from adis16136.c
      iio: imu: adis16480: remove duplicated include from adis16480.c

 drivers/iio/adc/Kconfig                |  22 ++
 drivers/iio/adc/Makefile               |   3 +
 drivers/{staging => }/iio/adc/ad7793.c | 384 +++++++++++++++++++++++++++++----
 drivers/iio/adc/ti-adc081c.c           | 161 ++++++++++++++
 drivers/iio/gyro/adis16136.c           |   5 +-
 drivers/iio/imu/adis16480.c            |   5 +-
 drivers/staging/iio/adc/Kconfig        |  12 --
 drivers/staging/iio/adc/Makefile       |   1 -
 drivers/staging/iio/adc/ad7793.h       | 115 ----------
 include/linux/platform_data/ad7793.h   | 112 ++++++++++
 10 files changed, 649 insertions(+), 171 deletions(-)
 rename drivers/{staging => }/iio/adc/ad7793.c (50%)
 create mode 100644 drivers/iio/adc/ti-adc081c.c
 delete mode 100644 drivers/staging/iio/adc/ad7793.h
 create mode 100644 include/linux/platform_data/ad7793.h
