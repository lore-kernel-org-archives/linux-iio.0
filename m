Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54953 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab1HQIeN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 04:34:13 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [RFC PATCH 0/6] IIO: capacitance ADC cleanup (ad7150)
Date: Wed, 17 Aug 2011 09:42:11 +0100
Message-Id: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Couple of bits in here that I'll push out into next set of main cleanups.

Controversial bits (hence RFC) are the introduction of IIO_EV_TYPE_MAG_ADAPTIVE
and IIO_EV_TYPE_THRESH_ADAPTIVE, to handle the 'mean' shifted thresholds
of this device.  I'm far from convinced these are the right way to go,
but best I have come up with just yet.

Note this series is completely untested.  I haven't even verified that the
new chan spec related bits work right yet (can do that with a dummy driver).

Jonathan

Jonathan Cameron (6):
  staging:iio: Add capacitance type and average_raw chan info.
  staging:iio:attrs - make address a u64 to allow event codes to be
    used.
  staging:iio:add adaptive event types and missing extract_type macro.
  staging:iio:naming in the EV_BIT macro fix.
  staging:iio:adc:ad7150: use i2c_smbus commands + drop unused poweroff
    timeout control.
  staging:iio:adc:ad7150 initial chan_spec conversion

 drivers/staging/iio/adc/ad7150.c        |  837 ++++++++++++++-----------------
 drivers/staging/iio/iio.h               |    3 +
 drivers/staging/iio/industrialio-core.c |   26 +-
 drivers/staging/iio/sysfs.h             |    9 +-
 4 files changed, 411 insertions(+), 464 deletions(-)

-- 
1.7.3.4

