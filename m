Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbaFRSH3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 14:07:29 -0400
Message-ID: <53A1D5D8.7060107@kernel.org>
Date: Wed, 18 Jun 2014 19:09:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new drivers, features and cleanups for 3.17 - set 1
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 34683a5c6e0ffaa61528ff71c283efe3063cc53f:

   fix format string missmatch in staging/iio/Documentation/iio_utils.h (2014-05-25 12:09:37 +0100)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.17a

for you to fetch changes up to 88f6da779a37a3579e580296776ba86d6c6bd980:

   iio: accel: kxcjk1013 Fix missing unlock errors (2014-06-16 20:57:36 +0100)

----------------------------------------------------------------
First round of new drivers, cleanups and functionality for the 3.17 cycle.

New drivers
* t5403 barometric pressure sensor
* kxcjk1013 accelerometer (with a locking followup fix).
* ak09911 digital compass

Documentation
* ABI docs for proximity added (interface has been there a long time but
   somehow snuck through without being documented)
* Move iio-trig-sysfs documentation out of staging (got left behind when
   the driver moved some time ago).

Cleanups
  * drop the timestamp argument from iio_trigger_poll(_chained) as
    nothing has been done with it for some time.
  * ad799x kerneldoc for ad799x_chip brought up to date.
  * replace a number of reimplementations of the GENMASK macro and
    use the BIT macro to cleanup a few locations.
  * bring the iio_event_monitor example program up to date with new
    device types.
  * fix some incorrect function prototypes in iio_utils.h example code.
  * INDIO_RING_TRIGGERED to INDIO_BUFFER_TRIGGERED fix in docs. This
    got left behind after we renamed it a long time back.
  * fix error handling in the generic_buffer example program.
  * small tidy ups in the iio-trig-periodic-rtc driver.
  * Allow reseting iio-trig-periodic-rtc frequency to 0 (default) after
    it has changed.
  * Trivial tidy ups in coding style in iio_simply_dummy

----------------------------------------------------------------
Jimmy Picard (1):
       staging: iio: fix coding style by adding blank lines in iio_simple_dummy

Peter Meerwald (16):
       iio: Add ABI documentation for proximity
       iio: Add t5403 barometric pressure sensor driver
       iio:adc:ad799x: Fix ad799x_chip_info kerneldoc
       iio:adc:ad5791: Use BIT() and GENMASK() macros
       iio:adc:ad5504: Use BIT() and GENMASK() macros
       iio:adc:ad7887: Use BIT() and GENMASK() macros
       iio:adc:ad7476: Use GENMASK() macro
       iio:adc:ad7298: Use BIT() and GENMASK() macros
       iio: Move documentation of iio-trig-sysfs to ABI/testing
       staging:iio: Update iio_event_monitor program
       staging:iio: Fix iio_utils.h function prototypes
       staging:iio: Fix mention of INDIO_RING_TRIGGERED to INDIO_BUFFER_TRIGGERED
       staging:iio: Fix error handling in generic_buffer example
       staging:iio-trig-periodic-rtc: Cleanup
       staging:iio-trig-periodic-rtc: Allow to reset frequency to 0
       iio: Remove timestamp argument from iio_trigger_poll() and iio_trigger_poll_chained()

Srinivas Pandruvada (3):
       iio: accel: kxcjk1013 3-axis accelerometer driver
       iio: AK09911 : 3 axis compass support
       iio: accel: kxcjk1013 Fix missing unlock errors

  Documentation/ABI/testing/sysfs-bus-iio            |  13 +
  .../ABI/testing}/sysfs-bus-iio-trigger-sysfs       |   0
  drivers/iio/accel/Kconfig                          |  12 +
  drivers/iio/accel/Makefile                         |   1 +
  drivers/iio/accel/kxcjk-1013.c                     | 764 +++++++++++++++++++++
  drivers/iio/adc/ad7298.c                           |  21 +-
  drivers/iio/adc/ad7476.c                           |   5 +-
  drivers/iio/adc/ad7887.c                           |  21 +-
  drivers/iio/adc/ad799x.c                           |   3 +-
  drivers/iio/adc/ad_sigma_delta.c                   |   2 +-
  drivers/iio/adc/at91_adc.c                         |   2 +-
  drivers/iio/adc/xilinx-xadc-core.c                 |   2 +-
  drivers/iio/dac/ad5504.c                           |  11 +-
  drivers/iio/dac/ad5791.c                           |  29 +-
  drivers/iio/industrialio-trigger.c                 |   8 +-
  drivers/iio/light/gp2ap020a00f.c                   |   2 +-
  drivers/iio/magnetometer/Kconfig                   |  10 +
  drivers/iio/magnetometer/Makefile                  |   1 +
  drivers/iio/magnetometer/ak09911.c                 | 326 +++++++++
  drivers/iio/pressure/Kconfig                       |  10 +
  drivers/iio/pressure/Makefile                      |   1 +
  drivers/iio/pressure/t5403.c                       | 275 ++++++++
  drivers/iio/proximity/as3935.c                     |   2 +-
  drivers/iio/trigger/iio-trig-interrupt.c           |   3 +-
  drivers/iio/trigger/iio-trig-sysfs.c               |   2 +-
  drivers/staging/iio/Documentation/generic_buffer.c |   9 +-
  .../staging/iio/Documentation/iio_event_monitor.c  |  10 +
  drivers/staging/iio/Documentation/iio_utils.h      |   6 +-
  drivers/staging/iio/Documentation/trigger.txt      |   2 +-
  drivers/staging/iio/accel/lis3l02dq_ring.c         |   2 +-
  drivers/staging/iio/adc/mxs-lradc.c                |   2 +-
  drivers/staging/iio/iio_simple_dummy.c             |   2 +
  drivers/staging/iio/meter/ade7758_trigger.c        |   2 +-
  drivers/staging/iio/trigger/iio-trig-bfin-timer.c  |   2 +-
  .../staging/iio/trigger/iio-trig-periodic-rtc.c    |  29 +-
  include/linux/iio/accel/kxcjk_1013.h               |  22 +
  include/linux/iio/trigger.h                        |   5 +-
  37 files changed, 1535 insertions(+), 84 deletions(-)
  rename {drivers/staging/iio/Documentation => Documentation/ABI/testing}/sysfs-bus-iio-trigger-sysfs (100%)
  create mode 100644 drivers/iio/accel/kxcjk-1013.c
  create mode 100644 drivers/iio/magnetometer/ak09911.c
  create mode 100644 drivers/iio/pressure/t5403.c
  create mode 100644 include/linux/iio/accel/kxcjk_1013.h
