Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34047 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788AbbGMUaz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 16:30:55 -0400
Message-ID: <55A41FFC.107@kernel.org>
Date: Mon, 13 Jul 2015 21:30:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] First set of IIO fixes for the 4.2 cycle
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit e5d732186270e0881f47d95610316c0614b21c3e:

  iio: adc: twl6030-gpadc: Fix modalias (2015-05-23 12:30:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.2a

for you to fetch changes up to b2b3c3dc6a7bef886850920f5f5dca041b443aa0:

  iio:adc:cc10001_adc: fix Kconfig dependency (2015-06-21 16:15:20 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 4.2 cycle.

* Fix a regression in hid sensors suspend time as a result of adding runtime
  pm.  The normal flow of waking up devices in order to go into suspend
  (given the devices are normally suspended when not reading) to a regression
  in suspend time on some laptops (reports of an additional 8 seconds).
  Fix this by checking to see if a user action resulting in the wake up, and
  make it a null operation if it didn't.  Note that for hid sensors, there is
  nothing useful to be done when moving into a full suspend from a runtime
  suspend so they might as well be left alone.
* rochip_saradc: fix some missing MODULE_* data including the licence so that
  the driver does not taint the kernel incorrectly and can build as a module.
* twl4030 - mark irq as oneshot as it always should have been.
* inv-mpu - write formats for attributes not specified, leading to miss
  interpretation of the gyro scale channel when written.
* Proximity ABI clarification.  This had snuck through as a mess.  Some
  drivers thought proximity went in one direction, some the other.  We went
  with the most common option, documented it and fixed up the drivers going
  the other way.  Fix for sx9500 included in this set.
* ad624r - fix a wrong shift in the output data.
* at91_adc - remove a false limit on the value of the STARTUP register
  applied by too small a type for the device tree parameter.
* cm3323 - clear the bits when setting the integration time (otherwise
  we can only ever set more bits in the relevant field).
* bmc150-accel - multiple triggers are registered, but on error were not being
  unwound in the opposite order leading to removal of triggers that had not
  yet successfully been registered (count down instead of up when unwinding).
* tcs3414 - ensure right part of val / val2 pair read so that the integration
  time is not always 0.
* cc10001_adc - bug in kconfig dependency. Use of OR when AND was intended.

----------------------------------------------------------------
Adriana Reus (1):
      iio: inv-mpu: Specify the expected format/precision for write channels

Daniel Baluta (2):
      iio: ABI: Clarify proximity output value
      iio: proximity: sx9500: Fix proximity value

Fabio Estevam (1):
      iio: twl4030-madc: Pass the IRQF_ONESHOT flag

Hartmut Knaack (3):
      iio:light:cm3323: clear bitmask before set
      iio:accel:bmc150-accel: fix counting direction
      iio:adc:cc10001_adc: fix Kconfig dependency

Heiko Stuebner (1):
      iio: adc: rockchip_saradc: add missing MODULE_* data

JM Friedt (1):
      iio: DAC: ad5624r_spi: fix bit shift of output data value

Jan Leupold (1):
      iio: adc: at91_adc: allow to use full range of startup time

Peter Meerwald (1):
      iio: light: tcs3414: Fix bug preventing to set integration time

Srinivas Pandruvada (1):
      hid-sensor: Fix suspend/resume delay

 Documentation/ABI/testing/sysfs-bus-iio             |  6 ++----
 drivers/iio/accel/bmc150-accel.c                    |  2 +-
 drivers/iio/adc/Kconfig                             |  3 +--
 drivers/iio/adc/at91_adc.c                          |  8 ++++----
 drivers/iio/adc/rockchip_saradc.c                   |  4 ++++
 drivers/iio/adc/twl4030-madc.c                      |  3 ++-
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 11 ++++++++++-
 drivers/iio/dac/ad5624r_spi.c                       |  4 ++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c          | 18 ++++++++++++++++++
 drivers/iio/light/cm3323.c                          |  2 +-
 drivers/iio/light/tcs3414.c                         |  2 +-
 drivers/iio/proximity/sx9500.c                      |  2 +-
 include/linux/hid-sensor-hub.h                      |  1 +
 13 files changed, 48 insertions(+), 18 deletions(-)

