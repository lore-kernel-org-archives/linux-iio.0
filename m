Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35700 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112AbbKYL3X (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2015 06:29:23 -0500
Received: by wmuu63 with SMTP id u63so133811159wmu.0
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2015 03:29:22 -0800 (PST)
From: Marc Titinger <mtitinger@baylibre.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux@roeck-us.net, jdelvare@suse.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lm-sensors@lm-sensors.org, Marc Titinger <mtitinger@baylibre.com>
Subject: [PATCH 0/2] IIO version of INA2xx (followup of related RFC)
Date: Wed, 25 Nov 2015 12:28:14 +0100
Message-Id: <1448450896-24387-1-git-send-email-mtitinger@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

following RFC started in https://lkml.org/lkml/2015/11/10/370
and feed back from https://lkml.org/lkml/2015/11/18/395

 * squash to a single patch that provides DIRECT and SOFTWARE buffer mode.

 * implement INFO_INT_TIME abi for each adc in order to better match how
   the chip works.  This also allows to compute the actual sample freq
   for INFO_SAMP_FREQ, that results from both the averaging ratio and the
   possible integration times.

 * Add an INT_TIME setting for each voltage ADC (default values are compa
   -tible for previous implementations).

 * provide the averaging feature of the chip using the OVERSAMPLING_RATIO
   abi.

 * by default, only issue a new sample value in the buffer when the
   Conversion Ready Flag indicates that a new value is available. The
   capture thread polls slightly faster than the chip-internal sampling
   clock to prevent re-read or skipping of samples.

 * Since this check for CVRF has its cost (i2c xfer), allow for a relaxed
   mode for when re-read or skipping or one sample is not big deal, but
   a faster sampling rate is wanted.

 * remove the calibration INFO, since the driver sets a hardcoded value
   for 'Current_LSB', only RShunt is available as a parameter. No use to
   expose the register to the user.

Why two drivers (hwmon and IIO) for this device ?
------------------------------------------------

 * Hwmon and IIO do not address exactly the same use-cases, while this chip
   can (and is) being used either as a power monitoring feature of a host
   device or as sensor to measure power properties of a target DUT.

 * In the second use-case (probing a DUT) we wish to plot measurements
   over time, display transients, peak values, compute derived metrics
   (like energy). A buffer streaming scheme and remote capabilities
   with libiio seems beneficial.


Marc Titinger (1):
  iio: ina2xx: add support for TI INA2xx Power Monitors
  iio: ina2xx: provide a sysfs parameter to allow async readout of the
    ADCs

 drivers/iio/adc/Kconfig      |  10 +
 drivers/iio/adc/Makefile     |   1 +
 drivers/iio/adc/ina2xx-iio.c | 720 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 731 insertions(+)
 create mode 100644 drivers/iio/adc/ina2xx-iio.c

-- 
1.9.1

