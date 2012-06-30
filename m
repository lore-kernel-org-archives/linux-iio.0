Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49119 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab2F3Mea (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 30 Jun 2012 08:34:30 -0400
Message-ID: <4FEEF254.4060501@kernel.org>
Date: Sat, 30 Jun 2012 13:34:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new stuff - staging-next with IIO fixes merged.
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

I'm afraid I'm not that familiar with the complexities
of pull requests.  What does one do as here if the patches
are dependent on fixes in a separate series?  I merged
in the fixes-togreg branch before applying these.

What is the standard way of handling this?

Thanks

Jonathan

The following changes since commit c1f1a9d48fd18cd380858637fda1c69732547e1f:

  Merge branch 'fixes-togreg' into togreg (2012-06-30 10:14:29 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg

for you to fetch changes up to cf82cb8128496955a38fa62e1819ceb1d596e2eb:

  IIO: Add a modifier for x^2+y^2+z^2 (2012-06-30 10:15:28 +0100)

----------------------------------------------------------------
Jonathan Cameron (7):
      iio: Rename _st_ functions to loose the bit that meant the staging
version.
      staging:iio:accel drop sysfs interface for resetting devices.
      staging:iio:gyro:adis16260 drop sysfs interface for manual device
reset.
      staging:iio:imu:adis16400 drop sysfs interface for manual device
reset.
      IIO: Add a modifier for sqrt(x^2+y^2)
      staging:iio:accel:adis16204 support the rss channel via chan spec.
      IIO: Add a modifier for x^2+y^2+z^2

Lars-Peter Clausen (2):
      iio:adc: Add AD7265/AD7266 support
      iio:dac:ad5064: Add support for the ad5629r and ad5669r

 drivers/iio/adc/Kconfig                    |  10 +
 drivers/iio/adc/Makefile                   |   1 +
 drivers/iio/adc/ad7266.c                   | 536
+++++++++++++++++++++++++++++
 drivers/iio/dac/Kconfig                    |   8 +-
 drivers/iio/dac/ad5064.c                   | 200 +++++++++--
 drivers/iio/industrialio-core.c            |   2 +
 drivers/iio/inkern.c                       |  33 +-
 drivers/staging/iio/accel/adis16201_core.c |  27 --
 drivers/staging/iio/accel/adis16203_core.c |  28 --
 drivers/staging/iio/accel/adis16204_core.c |  99 ++----
 drivers/staging/iio/accel/adis16209_core.c |  29 --
 drivers/staging/iio/accel/adis16220_core.c |  24 --
 drivers/staging/iio/accel/adis16240_core.c |  20 --
 drivers/staging/iio/gyro/adis16260_core.c  |  19 -
 drivers/staging/iio/iio_hwmon.c            |  12 +-
 drivers/staging/iio/imu/adis16400_core.c   |  22 --
 include/linux/iio/consumer.h               |  34 +-
 include/linux/iio/types.h                  |   2 +
 include/linux/platform_data/ad7266.h       |  54 +++
 19 files changed, 843 insertions(+), 317 deletions(-)
 create mode 100644 drivers/iio/adc/ad7266.c
 create mode 100644 include/linux/platform_data/ad7266.h
