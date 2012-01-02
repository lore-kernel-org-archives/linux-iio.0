Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:50668 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab2ABRZH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2012 12:25:07 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: pirmin.duss@flytec.ch, lars@metafoo.de,
	Jonathan Cameron <jic23@kernel.org>
Subject: [RFC PATCH 0/6] Make iio_info elements attrs and event_attrs struct attribute *
Date: Mon,  2 Jan 2012 17:25:17 +0000
Message-Id: <1325525123-31158-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This came up whilst I was taking a look at Pirmin Duss' driver the other day.
When we originally created these the attribute groups were passed directly
through the core and registered with sysfs.  Since the introduction of
iio_chan_spec structures this is no longer true.  Their elements are simply
coppied into attribute_groups created by the core.

Hence, what other reasons are there for having these as attribute groups?
The only one I can see is the availablity of the is_visible callback.

Now I've always had mixed feelings about that one. It's handy on occasion
but mostly gets used to handle variations across the different devices
that are supported by a given driver.  This is true of ad7192, ad9834,
ad5446 (indirectly).  These can all be easily unwound and handled at a
higher level (which iio_info varient we use for the device instance).

The ad7606 is the only more complex use case here.  There we have
attributes whose visibility is dependent on some gpios being specified
in platform data.  There are two different sets so we have a total of 4
resulting iio_info structures.  Not too bad I suppose.

A side effect of this is that we can remove the code Lars-Peter just added
to copy the is_visible callback over.  That copy is a little odd anyway
as it is applied to far more attributes than are initially visible.  whilst
all current drivers do a 'is condition true then mask attribute' we only
need one to do the reverse logic to get nasty to find bug.

Note this set is on top of Lars-Peters recent rearrangement of the event
code as obviously the last patch here edits code he moves.

Jonathan

Jonathan Cameron (6):
  staging:iio:adc:ad7192 unwind use of is_visible for attribute group.
  staging:iio:dds:ad9834 unwind use of is_visible for attrs.
  staging:iio:dac:ad5446 unwind use of is_visible for attrs.
  staging:iio:adc:ad7606 unwind use of is_visible for attrs.
  staging:iio:adc:adt7310/7410 sticking plaster fix for broken event
    attrs.
  staging:iio:treewide make attrs and event_attrs entries struct
    attribute *

 drivers/staging/iio/accel/adis16201_core.c      |    6 +--
 drivers/staging/iio/accel/adis16203_core.c      |    6 +--
 drivers/staging/iio/accel/adis16204_core.c      |    6 +--
 drivers/staging/iio/accel/adis16209_core.c      |    6 +--
 drivers/staging/iio/accel/adis16220_core.c      |    6 +--
 drivers/staging/iio/accel/adis16240_core.c      |    6 +--
 drivers/staging/iio/accel/kxsd9.c               |    6 +--
 drivers/staging/iio/accel/lis3l02dq_core.c      |    6 +--
 drivers/staging/iio/accel/sca3000_core.c        |   19 +-----
 drivers/staging/iio/adc/ad7192.c                |   41 ++++++-------
 drivers/staging/iio/adc/ad7280a.c               |   12 +---
 drivers/staging/iio/adc/ad7291.c                |   12 +---
 drivers/staging/iio/adc/ad7606_core.c           |   73 +++++++++++++----------
 drivers/staging/iio/adc/ad7793.c                |    6 +--
 drivers/staging/iio/adc/ad7816.c                |   13 +----
 drivers/staging/iio/adc/ad799x.h                |    1 -
 drivers/staging/iio/adc/ad799x_core.c           |   14 +----
 drivers/staging/iio/adc/adt7310.c               |   26 +--------
 drivers/staging/iio/adc/adt7410.c               |   26 +--------
 drivers/staging/iio/adc/max1363_core.c          |   10 +---
 drivers/staging/iio/addac/adt7316.c             |   26 +-------
 drivers/staging/iio/cdc/ad7150.c                |    7 +--
 drivers/staging/iio/cdc/ad7152.c                |    6 +--
 drivers/staging/iio/cdc/ad7746.c                |    6 +--
 drivers/staging/iio/dac/ad5064.c                |    6 +--
 drivers/staging/iio/dac/ad5360.c                |    6 +--
 drivers/staging/iio/dac/ad5380.c                |    6 +--
 drivers/staging/iio/dac/ad5446.c                |   39 ++++---------
 drivers/staging/iio/dac/ad5504.c                |   21 +-----
 drivers/staging/iio/dac/ad5624r_spi.c           |    6 +--
 drivers/staging/iio/dac/ad5686.c                |    6 +--
 drivers/staging/iio/dac/ad5791.c                |    6 +--
 drivers/staging/iio/dac/max517.c                |   12 +---
 drivers/staging/iio/dds/ad5930.c                |    6 +--
 drivers/staging/iio/dds/ad9832.c                |    6 +--
 drivers/staging/iio/dds/ad9834.c                |   46 +++++++--------
 drivers/staging/iio/dds/ad9850.c                |    6 +--
 drivers/staging/iio/dds/ad9852.c                |    6 +--
 drivers/staging/iio/dds/ad9910.c                |    6 +--
 drivers/staging/iio/dds/ad9951.c                |    6 +--
 drivers/staging/iio/gyro/adis16260_core.c       |    6 +--
 drivers/staging/iio/iio.h                       |    4 +-
 drivers/staging/iio/impedance-analyzer/ad5933.c |    6 +--
 drivers/staging/iio/imu/adis16400_core.c        |    6 +--
 drivers/staging/iio/industrialio-core.c         |    4 +-
 drivers/staging/iio/industrialio-event.c        |    4 +-
 drivers/staging/iio/light/isl29018.c            |    6 +--
 drivers/staging/iio/light/tsl2583.c             |    6 +--
 drivers/staging/iio/magnetometer/ak8975.c       |    7 +--
 drivers/staging/iio/magnetometer/hmc5843.c      |    6 +--
 drivers/staging/iio/meter/ade7753.c             |    6 +--
 drivers/staging/iio/meter/ade7754.c             |    6 +--
 drivers/staging/iio/meter/ade7758_core.c        |    6 +--
 drivers/staging/iio/meter/ade7759.c             |    6 +--
 drivers/staging/iio/meter/ade7854.c             |    6 +--
 drivers/staging/iio/resolver/ad2s1210.c         |    6 +--
 56 files changed, 164 insertions(+), 463 deletions(-)

-- 
1.7.7.4

