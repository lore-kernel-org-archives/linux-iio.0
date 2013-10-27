Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55562 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab3J0SHz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2013 14:07:55 -0400
Message-ID: <526D64B8.6060703@kernel.org>
Date: Sun, 27 Oct 2013 19:08:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL]  IIO new drivers, features and cleanups for 3.13 - set 5
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 207287595bb2e9070d45780382f115fcd42e893d:

  staging: rtl8187se: checkpatch cleanups (2013-10-19 14:55:44 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.13e

for you to fetch changes up to e0203255415844d73b5f4bec9bc72903c8e49d8d:

  iio: light: vcnl4000: Remove redundant code (2013-10-24 14:48:14 +0100)

----------------------------------------------------------------
Fifth round of IIO new drivers, cleanups and functionality for the 3.13 cycle.

New Driver
* Freescale mag3110 magnetometer driver.

New functionality
* Add LPS001WP support to the ST pressure driver.
* Allow the max1363 driver to use only smbus functions for 8 bit devices. This
  allows the driver to be used when more extensive i2c support is not
  available.

Cleanups
* Fix incorrect description of unit conversions in ak8975.
* Switch to pr_err in industrialio-core.c instead of direct printk calls.
* Some simple redundant error handling removal patches.
* Trivial warning suppression by adding brackets to a sizeof call.
* Drop redundant of_match_ptr casts in drivers that are dependent on
  OF supporting being present.  The only purpose of the of_match_ptr
  wrapper was to make stubbing out of the relevant structures trivial.

Fixes
* Make MXS_LRADC depend on INPUT to avoid compile failures. This fixes an
  issue introduced in the previous pull in this cycle.

----------------------------------------------------------------
Denis CIOCCA (1):
      iio:pressure: Adds LPS001WP support also on spi interface and Kconfig fix

Peter Meerwald (2):
      iio: Correct description how to convert microtesla to gauss
      iio: Add Freescale mag3110 magnetometer driver

Randy Dunlap (1):
      staging/iio/adc: MXS_LRADC depends on INPUT

Sachin Kamat (12):
      iio: adc: twl6030-gpadc: Remove redundant of_match_ptr
      iio: adc: nau7802: Remove redundant of_match_ptr
      iio: adc: ti_am335x_adc: Remove redundant of_match_ptr
      iio: core: Use pr_err instead of printk
      iio: core: Add misssing braces
      iio: accel: kxsd9: Remove redundant variable
      iio: adc: twl6030-gpadc: Remove redundant code
      iio: dac: ad5421: Remove redundant code
      iio: dac: ad5755: Remove redundant code
      iio: dac: max517: Remove redundant variable
      iio: dac: mcp4725: Remove redundant code
      iio: light: vcnl4000: Remove redundant code

Vivien Didelot (1):
      iio:adc:max1363 support SMBus for 8-bit devices

 drivers/iio/accel/kxsd9.c              |   7 +-
 drivers/iio/adc/max1363.c              |  76 +++++--
 drivers/iio/adc/nau7802.c              |   2 +-
 drivers/iio/adc/ti_am335x_adc.c        |   2 +-
 drivers/iio/adc/twl6030-gpadc.c        |   6 +-
 drivers/iio/dac/ad5421.c               |   8 +-
 drivers/iio/dac/ad5755.c               |   8 +-
 drivers/iio/dac/max517.c               |   9 +-
 drivers/iio/dac/mcp4725.c              |   8 +-
 drivers/iio/industrialio-core.c        |  13 +-
 drivers/iio/light/vcnl4000.c           |   6 +-
 drivers/iio/magnetometer/Kconfig       |  10 +
 drivers/iio/magnetometer/Makefile      |   1 +
 drivers/iio/magnetometer/ak8975.c      |   2 +-
 drivers/iio/magnetometer/mag3110.c     | 401 +++++++++++++++++++++++++++++++++
 drivers/iio/pressure/Kconfig           |   2 +-
 drivers/iio/pressure/st_pressure_spi.c |   1 +
 drivers/staging/iio/adc/Kconfig        |   1 +
 18 files changed, 489 insertions(+), 74 deletions(-)
 create mode 100644 drivers/iio/magnetometer/mag3110.c
