Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50303 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab3KQOOK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Nov 2013 09:14:10 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 00/11] IIO: Add core support for _available interfaces
Date: Sun, 17 Nov 2013 15:14:51 +0000
Message-Id: <1384701302-26564-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

Firstly this is an RFC rather than a final proposal for a couple of reasons
1) Others may have better idea of the the interface, particularly wrt to te
   range attributes (we are restricted by existing userspace interface for
   the list of available options one).
2) I've only converted a small number of drivers and honestly I suspect I've
   broken some of them trying to avoid multiple coppies of the same data.
3) The range version isn't documented yet.

In brief what I propose here has come up a few times in the depths of random
driver reviews: An interface to tell the subsystem what values are possible
for a given info_mask element.  This is then exported to userspace with the
same interface as was being used by the 'custom' attributes previously deployed
to indicate this stuff.  It is importantly also available to inkernel
consumers of the IIO channels.

There are two forms:

1. The conventional list of values.  A flat array is provided by the driver
with either one element (IIO_VAL_INT) or two (IIO_VAL_INT_PLUS etc) per value.
Note this array must be constant at the time of passing to ensure no race
conditions occur.

2. A new range approach. The format for this is open to discussion.
In this proposal 3 (single or pairs of) values are provided in a flat array.
These provide inclusive end markers and a step size between them.
Thus [0..1..3] is the equivalent of 0 1 2 3.

I would envision that many more of our info_mask elements will have
_available attributes than currently, many of which will make use of this
second interface.

The actual conversions of drivers is only painful in the 'clever' common
library ones.  The solution proposed here for the AD_SD drivers is clunky
but I can't immediately see how to do things in a cleaner fashion.

Anyhow, all comments welcome!  Whilst I think we need an interface
to provide this functionality, I am far from fixed on this necessarily
being the right way to do it.  It's just the best one I've thought up
yet.

Jonathan

Jonathan Cameron (11):
  iio:core: add a callback to allow drivers to provide _available
    attributes
  staging:iio:dummy driver: Add example usecases for the new *_available
    interface.
  iio:accel:bma180 use new read_avail to replace *_available attrs.
  iio:accel:kxsd9 use new read_avail to replace accel_scan_available.
  iio:st sensors: remove custom sampling frequence attribute in favour
    of core support.
  iio: ad_sigma_delta provide macro parameters for available info masks
  iio:adc:ad7793: use samp_freq element of info_mask_shared_by_all.
  iio:adc:ad7793: Use the read_avail callback to provide the scale and
    sampling frequency interfaces.
  iio:adc:ad7791 Provide sampling frequency and scale_available access
    via core.
  staging:iio:adc:ad7192 use infomask* to provide access to sampling
    frequency and scale_available
  iio:adc:mcp3422: use core to provide _available information rather
    than custom attrs.

 drivers/iio/accel/bma180.c                      |  61 +++---
 drivers/iio/accel/kxsd9.c                       |  52 ++---
 drivers/iio/accel/st_accel_core.c               |  12 +-
 drivers/iio/adc/ad7791.c                        | 106 ++++-----
 drivers/iio/adc/ad7793.c                        | 275 ++++++++++++------------
 drivers/iio/adc/mcp3422.c                       |  72 ++++---
 drivers/iio/common/st_sensors/st_sensors_core.c |  29 ---
 drivers/iio/gyro/st_gyro_core.c                 |  12 +-
 drivers/iio/industrialio-core.c                 | 209 ++++++++++++++++--
 drivers/iio/magnetometer/st_magn_core.c         |  12 +-
 drivers/iio/pressure/st_pressure_core.c         |  27 ++-
 drivers/staging/iio/adc/ad7192.c                | 166 ++++++--------
 drivers/staging/iio/adc/ad7780.c                |   2 +-
 drivers/staging/iio/iio_simple_dummy.c          |  29 ++-
 include/linux/iio/adc/ad_sigma_delta.h          |  47 +++-
 include/linux/iio/common/st_sensors.h           |  15 +-
 include/linux/iio/iio.h                         |  11 +
 include/linux/iio/types.h                       |   5 +
 18 files changed, 696 insertions(+), 446 deletions(-)

-- 
1.8.4.2

