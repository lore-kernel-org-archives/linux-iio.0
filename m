Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:58492 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaFRR1L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 18 Jun 2014 13:27:11 -0400
Message-ID: <53A1CC65.5010100@kernel.org>
Date: Wed, 18 Jun 2014 18:29:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Linux IIO List <linux-iio@vger.kernel.org>
Subject: [PULL] First set of IIO fixes for the 3.16 cycle. (take 2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 86281966c7395aa9a13a20c52e26005f5e142451:

   Merge tag 'iio-fixes-for-3.15b' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-linus (2014-04-30 14:19:23 -0700)

are available in the git repository at:


   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-3.16a

for you to fetch changes up to e94f62e79f7f63a68574ee5e76c19837ec12f3db:

   iio: adc: checking for NULL instead of IS_ERR() in probe (2014-06-14 16:16:43 +0100)

----------------------------------------------------------------
First set of IIO fixes for the 3.16 cycle.

A mixed bag of fixes, many of which feel just to late for 3.15.

* hid sensors - some devices need a feature report request in order to
   change power state.  This isn't part of the spec, but has been observed
   on several devices and does no harm to others.
* mpl3115 has had two errors in the buffer description fixed. The presure is
   signed, not unsigned and the temperature has 12 bits rather than 16.
   These could lead to incorrect interpretation of the data in userspace.
* tsl2x7x - the high byte of the proximity thresholds should be written along
   with the low byte (which was). This could lead to interesting results
   with large thresholds.
* twl4030 - a flag to specify processed values were required was not set
   when initializing a reading.  As such values returned were in an unknown
   state. Fixed by simply initializing it appropriately.
* IIO_SIMPLE_DUMMY_BUFFER did not select IIO_BUFFER leading to randconfig
   build errors.
* ak8975 was applying an unwanted le16_to_cpu conversion as the i2c framework
   already performs one.  As such for big endian systems, the bytes would be
   in the wrong order in the magnetic field measurements reported.
* mxs-lradc - the controllable voltage dividers were not enabled / disabled for
   later channels than the first one during conversion.
* at91_adc error handling returned -ENOMEM in a u8. Return value of
   at91_adc_get_trigger_value_by_name changed to int thus allowing -ENOMEM and
   also original values to be returned.
* mcb - mcb_request_mem returns and ERR_PTR but the caller was checking for
   NULL to detect an error.

----------------------------------------------------------------
Archana Patni (1):
       iio: hid-sensors: Get feature report from sensor hub after changing power state

Arnd Bergmann (1):
       staging/iio: IIO_SIMPLE_DUMMY_BUFFER neds IIO_BUFFER

Dan Carpenter (2):
       iio: adc: at91: signedness bug in at91_adc_get_trigger_value_by_name()
       iio: adc: checking for NULL instead of IS_ERR() in probe

Mario Schuknecht (1):
       staging: iio: tsl2x7x_core: fix proximity treshold

Paul Kocialkowski (1):
       twl4030-madc: Request processed values in twl4030_get_madc_conversion

Peter Meerwald (2):
       iio: Fix two mpl3115 issues in measurement conversion
       iio: Fix endianness issue in ak8975_read_axis()

Robert Hodaszi (1):
       iio: mxs-lradc: fix divider

  drivers/iio/adc/at91_adc.c                          | 16 ++++++++--------
  drivers/iio/adc/men_z188_adc.c                      |  4 ++--
  drivers/iio/adc/twl4030-madc.c                      |  1 +
  drivers/iio/common/hid-sensors/hid-sensor-trigger.c |  3 +++
  drivers/iio/magnetometer/ak8975.c                   |  9 +--------
  drivers/iio/pressure/mpl3115.c                      |  6 +++---
  drivers/staging/iio/Kconfig                         |  9 +++++----
  drivers/staging/iio/adc/mxs-lradc.c                 | 12 ++++++++----
  drivers/staging/iio/light/tsl2x7x_core.c            |  8 ++++++--
  9 files changed, 37 insertions(+), 31 deletions(-)
