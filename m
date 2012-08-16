Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34835 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933220Ab2HPUEL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 16 Aug 2012 16:04:11 -0400
Message-ID: <502D523A.6050408@kernel.org>
Date: Thu, 16 Aug 2012 21:04:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers and cleanups for 3.7 cycle
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 0959c63f11c3bbef0a7d6c5011be8d25503f547c:

  zsmalloc: collapse internal .h into .c (2012-08-13 19:34:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v3.7a

for you to fetch changes up to bc2c90c974a0ed390327bbd94f49269e9f24e280:

  IIO: Add basic MXS LRADC driver (2012-08-16 20:18:38 +0100)

----------------------------------------------------------------
First set of IIO rework and new drivers for 3.7 cycle.

New MXS adc driver form Marek Vasut with a minor addition
to the example code to support 4 byte reads.

First of I suspect many devm conversion patches form Julia Lawall
Some module_platform_driver uses that somehow got missed the
first time around.

Couple of other useful cleanups.

----------------------------------------------------------------
Devendra Naga (1):
      staging/iio: use module_platform_driver macro

Julia Lawall (1):
      drivers/iio/adc/at91_adc.c: use devm_ functions

Lars-Peter Clausen (2):
      staging:iio:adis16220: Use kobj_to_dev instead of open-coding it
      staging:iio: Constify static iio_chan_spec arrays

Marek Vasut (2):
      IIO: Add 4-byte unsigned reads into generic-buffer example
      IIO: Add basic MXS LRADC driver

 .../bindings/staging/iio/adc/mxs-lradc.txt         |  15 +
 drivers/iio/adc/at91_adc.c                         |  42 +-
 drivers/staging/iio/Documentation/generic_buffer.c |  10 +
 drivers/staging/iio/accel/adis16201_core.c         |   2 +-
 drivers/staging/iio/accel/adis16203_core.c         |   2 +-
 drivers/staging/iio/accel/adis16204_core.c         |   2 +-
 drivers/staging/iio/accel/adis16209_core.c         |   2 +-
 drivers/staging/iio/accel/adis16220_core.c         |   9 +-
 drivers/staging/iio/accel/adis16240_core.c         |   2 +-
 drivers/staging/iio/accel/kxsd9.c                  |   2 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |   2 +-
 drivers/staging/iio/accel/sca3000_core.c           |   2 +-
 drivers/staging/iio/adc/Kconfig                    |  12 +
 drivers/staging/iio/adc/Makefile                   |   1 +
 drivers/staging/iio/adc/ad7192.c                   |   2 +-
 drivers/staging/iio/adc/ad7298_core.c              |   2 +-
 drivers/staging/iio/adc/ad7606.h                   |   2 +-
 drivers/staging/iio/adc/ad7606_core.c              |   6 +-
 drivers/staging/iio/adc/lpc32xx_adc.c              |   2 +-
 drivers/staging/iio/adc/max1363.h                  |   2 +-
 drivers/staging/iio/adc/max1363_core.c             |  26 +-
 drivers/staging/iio/adc/mxs-lradc.c                | 590 +++++++++++++++++++++
 drivers/staging/iio/adc/spear_adc.c                |   2 +-
 drivers/staging/iio/iio_hwmon.c                    |  12 +-
 drivers/staging/iio/iio_simple_dummy.c             |   2 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c    |   2 +-
 drivers/staging/iio/imu/adis16400_core.c           |   6 +-
 drivers/staging/iio/meter/ade7758.h                |   2 +-
 drivers/staging/iio/meter/ade7758_core.c           |   2 +-
 drivers/staging/iio/resolver/ad2s1210.c            |   2 +-
 30 files changed, 678 insertions(+), 89 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/staging/iio/adc/mxs-lradc.txt
 create mode 100644 drivers/staging/iio/adc/mxs-lradc.c
