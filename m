Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46954 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757119Ab3H2U3K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 29 Aug 2013 16:29:10 -0400
Message-ID: <521FBD27.8000501@kernel.org>
Date: Thu, 29 Aug 2013 22:29:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers and cleanups for 3.12 - set 3
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit c6b223b1899f97736b4bee5535ffc76e846c2bf2:

  staging: gdm724x: Remove version.h header inclusion in netlink_k.c (2013-08-27 22:53:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.12c

for you to fetch changes up to 9120c0bea999cc26c3493486828d34138a7ac901:

  iio: at91: Use different prescal, startup mask in MR for different IP (2013-08-29 21:49:28 +0100)

----------------------------------------------------------------
Third set of new drivers, cleanups and features for IIO in the 3.12 cycle.

New drivers

1) Bosh BMA180 accelerometer + a new sysfs abi element, power_mode to
   allow for device that trade off accuracy and power usage.

Cleanups

1) Another lot of devm_iio_device_alloc patches
2) An code ordering bug in the twl6030 driver introduced earlier in this
   cycle.

New features

1) at91 adc driver rework to support a wider range of parts and drop
   the necessity for some of the current device tree elements.  This is
   a precursor to introducing input support which is still under review.

----------------------------------------------------------------
Josh Wu (2):
      iio: at91: introduce the multiple compatible string for different IPs.
      iio: at91: Use different prescal, startup mask in MR for different IP

Oleksandr Kravchenko (2):
      staging: iio: Documentation sysfs-bus-iio add power_mode
      iio: add Bosch BMA180 acceleration sensor driver

Sachin Kamat (11):
      staging: iio: adis16201: Use devm_iio_device_alloc
      staging: iio: adis16203: Use devm_iio_device_alloc
      staging: iio: adis16204: Use devm_iio_device_alloc
      staging: iio: adis16209: Use devm_iio_device_alloc
      staging: iio: adis16220: Use devm_iio_device_alloc
      staging: iio: adis16240: Use devm_iio_device_alloc
      staging: iio: lis3l02dq: Use devm_iio_device_alloc
      staging: iio: sca3000: Use devm_iio_device_alloc
      staging: iio: ad7150: Use devm_* APIs
      staging: iio: ad7152: Use devm_iio_device_alloc
      staging: iio: ad7746: Use devm_iio_device_alloc

Wei Yongjun (1):
      iio: adc: twl6030-gpadc: fix error return code in twl6030_gpadc_read_raw()

 Documentation/ABI/testing/sysfs-bus-iio            |  10 +
 .../devicetree/bindings/arm/atmel-adc.txt          |   7 +-
 .../devicetree/bindings/iio/accel/bma180.txt       |  24 +
 arch/arm/mach-at91/include/mach/at91_adc.h         |  16 +-
 drivers/iio/accel/Kconfig                          |  12 +
 drivers/iio/accel/Makefile                         |   1 +
 drivers/iio/accel/bma180.c                         | 676 +++++++++++++++++++++
 drivers/iio/adc/at91_adc.c                         |  90 +--
 drivers/iio/adc/twl6030-gpadc.c                    |   2 +-
 drivers/staging/iio/accel/adis16201_core.c         |  17 +-
 drivers/staging/iio/accel/adis16203_core.c         |  16 +-
 drivers/staging/iio/accel/adis16204_core.c         |  16 +-
 drivers/staging/iio/accel/adis16209_core.c         |  16 +-
 drivers/staging/iio/accel/adis16220_core.c         |  14 +-
 drivers/staging/iio/accel/adis16240_core.c         |  16 +-
 drivers/staging/iio/accel/lis3l02dq_core.c         |  15 +-
 drivers/staging/iio/accel/sca3000_core.c           |  15 +-
 drivers/staging/iio/cdc/ad7150.c                   |  36 +-
 drivers/staging/iio/cdc/ad7152.c                   |  16 +-
 drivers/staging/iio/cdc/ad7746.c                   |  18 +-
 include/linux/platform_data/at91_adc.h             |   4 +
 21 files changed, 849 insertions(+), 188 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/accel/bma180.txt
 create mode 100644 drivers/iio/accel/bma180.c
