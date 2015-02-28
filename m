Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57937 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761AbbB1LX3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 28 Feb 2015 06:23:29 -0500
Message-ID: <54F1A530.1090108@kernel.org>
Date: Sat, 28 Feb 2015 11:23:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO fixes for 4.0 set 1
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 8ecb55b849b74dff026681b41266970072b207dd:

  Merge tag 'iio-fixes-for-3.19a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2015-01-08 17:59:04 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.0a

for you to fetch changes up to e01becbad300712a28f29b666e685536f45e83bc:

  IIO: si7020: Allocate correct amount of memory in devm_iio_device_alloc (2015-02-14 11:35:12 +0000)

----------------------------------------------------------------
First round of fixes for IIO in the 4.0 cycle. Note a followup
set dependent on patches in the recent merge windows will follow shortly.

* dht11 - fix a read off the end of an array, add some locking to prevent
          the read function being interrupted and make sure gpio/irq lines
	  are not enabled for irqs during output.
* iadc - timeout should be in jiffies not msecs
* mpu6050 - avoid a null id from ACPI emumeration being dereferenced.
* mxs-lradc - fix up some interaction issues between the touchscreen driver
              and iio driver.  Mostly about making sure that the adc driver
              only affects channels that are not being used for the
              touchscreen.
* ad2s1200 - sign extension fix for a result of c type promotion.
* adis16400 - sign extension fix for a result of c type promotion.
* mcp3422 - scale table was transposed.
* ad5686 - use _optional regulator get to avoid a dummy reg being allocate
           which would cause the driver to fail to initialize.
* gp2ap020a00f - select REGMAP_I2C
* si7020 - revert an incorrect cleanup up and then fix the issue that made
           that cleanup seem like a good idea.

----------------------------------------------------------------
Andrey Smirnov (1):
      IIO: si7020: Allocate correct amount of memory in devm_iio_device_alloc

Angelo Compagnucci (1):
      iio:adc:mcp3422 Fix incorrect scales table

Jonathan Cameron (1):
      Revert "iio:humidity:si7020: fix pointer to i2c client"

Kristina Martšenko (4):
      iio: mxs-lradc: separate touchscreen and buffer virtual channels
      iio: mxs-lradc: make ADC reads not disable touchscreen interrupts
      iio: mxs-lradc: make ADC reads not unschedule touchscreen conversions
      iio: mxs-lradc: only update the buffer when its conversions have finished

Nicholas Mc Guire (1):
      iio: iadc: wait_for_completion_timeout time in jiffies

Rasmus Villemoes (2):
      staging: iio: ad2s1200: Fix sign extension
      iio: imu: adis16400: Fix sign extension

Richard Weinberger (3):
      iio: dht11: Fix out-of-bounds read
      iio: dht11: Add locking
      iio: dht11: IRQ fixes

Roberta Dobrescu (1):
      iio: light: gp2ap020a00f: Select REGMAP_I2C

Srinivas Pandruvada (1):
      iio: imu: inv_mpu6050: Prevent dereferencing NULL

Stefan Wahren (1):
      iio: mxs-lradc: fix iio channel map regression

Urs Fässler (1):
      iio: ad5686: fix optional reference voltage declaration

 drivers/iio/adc/mcp3422.c                  |  17 +--
 drivers/iio/adc/qcom-spmi-iadc.c           |   3 +-
 drivers/iio/dac/ad5686.c                   |   2 +-
 drivers/iio/humidity/dht11.c               |  69 ++++++----
 drivers/iio/humidity/si7020.c              |   6 +-
 drivers/iio/imu/adis16400_core.c           |   3 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |   6 +-
 drivers/iio/light/Kconfig                  |   1 +
 drivers/staging/iio/adc/mxs-lradc.c        | 207 +++++++++++++++--------------
 drivers/staging/iio/resolver/ad2s1200.c    |   3 +-
 10 files changed, 166 insertions(+), 151 deletions(-)
