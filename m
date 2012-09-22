Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53681 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752577Ab2IVLLP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 22 Sep 2012 07:11:15 -0400
Message-ID: <505D9CD1.8030900@kernel.org>
Date: Sat, 22 Sep 2012 12:11:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new device support and cleanups (set 5 for the 3.7 cycle)
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit ba753e41803681d164eb17274b53085c7987d07c:

  Staging: remove CONFIG_EXPERIMENTAL dependancies (2012-09-17 23:02:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-v3.7e

for you to fetch changes up to 3fff22743640637c2b61473d3cc8d7dc2215984f:

  staging:iio:dummy: Fix potential NULL pointer dereference (2012-09-22 10:55:08 +0100)

----------------------------------------------------------------
Fifth round of new drivers and device support for the IIO
subsystem in the 3.7 cycle.

Here we have a mixed bag of new stuff, minor fixes and
more major fixes for drivers added earlier in this cycle.

1) A number of fixes for the HID sensors code added in previous
pull request.  Typical stuff that has become apparent as more eyes
have looked at the code post merging. Similar case for the ad5755 dac.

2) Cleanups of error handing in inkern.c - again typical stuff to see
as code comes into heavier use and people notice the naughty short
cuts that snuck in originally and kindly fix them.

3) A series from Lars that removes some incorrect error handling
from the remove functions of a number of drivers.  These have been
there for a very long time hence I'm not pushing these out for the
3.6 cycle.

4) Support for more parts in the ad7780 driver.

5) A driver for the adcs on the lp8788 power management unit

6) A client driver for IIO to allow it's ADCs to be used for
battery status measurement.  Note this driver has some dependencies
on some utility functions added to IIO in this series, hence it is
coming via this tree rather than Anton's.

7) A null pointer dereference bug in the 'fake' driver. I'm not
doing this as a fix for the 3.6 cycle because it only effects
'fake' hardware and that code is typically only used by people
investigating how IIO works as part of writing new drivers. Hence
it's hardly a critical fix.

----------------------------------------------------------------
Axel Lin (2):
      HID: hid-sensor-hub: Remove hdev->claimed setting
      HID: hid-sensor-hub: Fix sensor_hub_probe error handling

Dan Carpenter (3):
      HID: sensors: use GFP_ATOMIC under spinlock
      HID: sensors: remove some unneeded checks
      iio: dac/ad5755: signedness bug in ad5755_setup_pdata()

Kim, Milo (3):
      iio: inkern: put the IIO device when it fails to allocate memory
      iio: inkern: clean up error return code
      iio: adc: add new lp8788 adc driver

Lars-Peter Clausen (11):
      staging:iio:adis16200: Do not return a error in remove function
      staging:iio:adis16400: Do not return a error in remove function
      staging:iio:ade7753: Do not return a error in remove function
      staging:iio:ade7754: Do not return a error in remove function
      staging:iio:ade7758: Do not return a error in remove function
      staging:iio:ade7759: Do not return a error in remove function
      staging:iio:lis3l02dq: Do not return a error in remove function
      staging:iio:sca3000: Do not return a error in remove function
      staging:iio:ad7780: Make powerdown GPIO optional
      staging:iio:ad7780: Add support for the ad7170/ad7171
      staging:iio:dummy: Fix potential NULL pointer dereference

Srinivas Pandruvada (1):
      iio: hid-sensors: Prevent crash during hot-unplug

Stephen Rothwell (1):
      HID: sensors: fix up for mfd_add_devices() API change

anish kumar (1):
      power: battery: Generic battery driver using IIO

 drivers/hid/hid-sensor-hub.c                       |  29 +-
 drivers/iio/adc/Kconfig                            |   6 +
 drivers/iio/adc/Makefile                           |   1 +
 drivers/iio/adc/lp8788_adc.c                       | 264 +++++++++++++
 .../iio/common/hid-sensors/hid-sensor-trigger.c    |   1 +
 drivers/iio/dac/ad5755.c                           |   2 +-
 drivers/iio/inkern.c                               |  16 +-
 drivers/power/Kconfig                              |   7 +
 drivers/power/Makefile                             |   1 +
 drivers/power/generic-adc-battery.c                | 422 +++++++++++++++++++++
 drivers/staging/iio/accel/lis3l02dq_core.c         |  14 +-
 drivers/staging/iio/accel/sca3000_core.c           |   6 +-
 drivers/staging/iio/adc/Kconfig                    |   4 +-
 drivers/staging/iio/adc/ad7780.c                   |  67 +++-
 drivers/staging/iio/gyro/adis16260_core.c          |  10 +-
 drivers/staging/iio/iio_simple_dummy.c             |  20 +-
 drivers/staging/iio/iio_simple_dummy.h             |   6 +-
 drivers/staging/iio/iio_simple_dummy_buffer.c      |  11 +-
 drivers/staging/iio/imu/adis16400_core.c           |   8 +-
 drivers/staging/iio/meter/ade7753.c                |  11 +-
 drivers/staging/iio/meter/ade7754.c                |  10 +-
 drivers/staging/iio/meter/ade7758_core.c           |   9 +-
 drivers/staging/iio/meter/ade7759.c                |   9 +-
 include/linux/power/generic-adc-battery.h          |  29 ++
 24 files changed, 838 insertions(+), 125 deletions(-)
 create mode 100644 drivers/iio/adc/lp8788_adc.c
 create mode 100644 drivers/power/generic-adc-battery.c
 create mode 100644 include/linux/power/generic-adc-battery.h
