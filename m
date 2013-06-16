Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58738 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755320Ab3FPQ5T (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Jun 2013 12:57:19 -0400
Message-ID: <51BDEE69.2030001@kernel.org>
Date: Sun, 16 Jun 2013 17:57:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO cleanups, new stuff and staging graduations (IIO set 3
 for the 3.11 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 5f43264c5320624f3b458c5794f37220c4fc2934:

  staging/lustre/lnet: fix build error on i386 (2013-06-08 22:21:01 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.11c

for you to fetch changes up to 1df9d1d4a1cb666042c3217aef6a6dc38eed1de0:

  staging:iio:ad7291: Rework regulator handling (2013-06-14 21:55:17 +0100)

----------------------------------------------------------------
Third round of IIO new stuff, cleanups and staging graduations for the 3.11
cycle.

1) Add clock consumer support and device tree bindings to adf4350.
   The clock consumer part depends on a not so optional 'optional'
   implementation of clock_round_rate which is not present for pxa27x.
   It will be shortly and as no one actually uses this chip with that
   sub arch as far as we know, no need to delay the inclusion in the
   meantime. See
   http://lkml.indiana.edu/hypermail/linux/kernel/1306.1/00023.html
   for the brief discussion.  This may be the first non soc specific driver
   that makes use of that function.

2) AD7303 DAC new driver.

3) ADIS16130 minor fixes and improvements plus move out of staging.

4) AD7291 improvements to bring it inline with more recent drivers.

5) Update to the sysfs ABI doc to fix some out of date paths.

----------------------------------------------------------------
Alexandre Relange (1):
      iio: ABI doc: update scan_elements sysfs paths

Lars-Peter Clausen (12):
      iio:dac: Add support for the AD7303
      staging:iio:adis16130: Remove unused includes
      staging:iio:adis16130: Fix sample reading
      staging:iio:adis16130: Report scale and offset
      staging:iio:adis16130: Move out of staging
      staging:iio:ad7291: Use IIO_VAL_FRACTIONAL_LOG2
      staging:iio:ad7291: Remove userspace reset
      staging:iio:ad7291: Remove unnecessary dev_info() from probe()
      staging:iio:ad7291: Simplify threshold register lookup
      staging:iio:ad7291: Use i2c_smbus_{read,write}_word_swapped instead of open-coding it
      staging:iio:ad7291: Use sign_extend32 instead of open-coding it
      staging:iio:ad7291: Rework regulator handling

Michael Hennerich (2):
      iio: frequency: adf4350: Add support for clock consumer framework
      iio: frequency: adf4350: Add support for dt bindings

 Documentation/ABI/testing/sysfs-bus-iio            |  90 +++---
 .../devicetree/bindings/iio/dac/ad7303.txt         |  23 ++
 .../devicetree/bindings/iio/frequency/adf4350.txt  |  86 ++++++
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad7303.c                           | 315 +++++++++++++++++++++
 drivers/iio/frequency/adf4350.c                    | 186 +++++++++++-
 drivers/iio/gyro/Kconfig                           |   7 +
 drivers/iio/gyro/Makefile                          |   1 +
 .../gyro/adis16130_core.c => iio/gyro/adis16130.c} |  65 +++--
 drivers/staging/iio/adc/ad7291.c                   | 217 +++++---------
 drivers/staging/iio/adc/ad7291.h                   |  12 +
 drivers/staging/iio/gyro/Kconfig                   |   7 -
 drivers/staging/iio/gyro/Makefile                  |   3 -
 include/linux/platform_data/ad7303.h               |  21 ++
 15 files changed, 820 insertions(+), 224 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ad7303.txt
 create mode 100644 Documentation/devicetree/bindings/iio/frequency/adf4350.txt
 create mode 100644 drivers/iio/dac/ad7303.c
 rename drivers/{staging/iio/gyro/adis16130_core.c => iio/gyro/adis16130.c} (77%)
 create mode 100644 drivers/staging/iio/adc/ad7291.h
 create mode 100644 include/linux/platform_data/ad7303.h
