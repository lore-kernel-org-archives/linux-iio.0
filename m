Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:57734 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab1DMNlW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 13 Apr 2011 09:41:22 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Michael.Hennerich@analog.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/12] IIO: precursor cleanups to even system rewrite
Date: Wed, 13 Apr 2011 14:42:55 +0100
Message-Id: <1302702187-953-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Dear All,

Other than the first two which are trivial changes that were sitting
in my tree and probably should have been in the last set (but
weren't as I haven't posted them for review before), these are
all about removing incorrect uses of the previous event handling
system.

All of these cases use it to register an interrupt line purely for
the purposes of triggering.  That should always have been done
as a conventional interrupt registration rather than as 'events'.

The reason this happened was todo with the 'unusual' handing used
with the lis3l02dq where a single line serves both purposes.  There
is a much cleaner way of handling that case, but even that isn't
needed here. Basically that mess got cut and paste into a whole
load of drivers and I was lax and didn't shout enough to get
it fixed at the time.

I've been meaning to 'fix' this lot for a while, but it's becoming
important now the code they were abusing is going away.

I haven't tested these as I don't have the vast majority of the
hardware.  Michael, can you take a look at them. I think they
should be functionaly identical to the original code, but I've
been known to mess this sort of patch up before.

Note these are independent of the next couple of sets except
that those sets will break these drivers without these changes.
Hence they can be reviewed separately, but must merge in the
right order!

Thanks,

Jonathan

Jonathan Cameron (12):
  staging:iio:tsl2563 take advantage of new iio_device_allocate private
    data.
  staging:iio:light:tsl2563 constify gain level table.
  staging:iio:adis16300 replace unnecessary event line registration.
  staging:iio:adis16350 replace unnecessary event line registration.
  staging:iio:adis16400 replace unnecessary event line registration.
  staging:iio:adis16260 replace unnecessary event line registration.
  staging:iio:adis16203 replace unnecessary event line registration.
  staging:iio:adis16204 replace unnecessary event line registration.
  staging:iio:adis16201 replace unnecessary event line registration.
  staging:iio:adis16240 replace unnecessary event line registration.
  staging:iio:adis16209 replace unnecessary event line registration.
  staging:iio:ade7758 replace unnecessary event line registration.

 drivers/staging/iio/accel/adis16201_core.c    |   26 +---------
 drivers/staging/iio/accel/adis16201_trigger.c |   45 +++++++---------
 drivers/staging/iio/accel/adis16203_core.c    |   26 +---------
 drivers/staging/iio/accel/adis16203_trigger.c |   46 +++++++---------
 drivers/staging/iio/accel/adis16204_core.c    |   26 +---------
 drivers/staging/iio/accel/adis16204_trigger.c |   46 +++++++---------
 drivers/staging/iio/accel/adis16209_core.c    |   26 +---------
 drivers/staging/iio/accel/adis16209_trigger.c |   45 +++++++---------
 drivers/staging/iio/accel/adis16240_core.c    |   26 +---------
 drivers/staging/iio/accel/adis16240_trigger.c |   46 +++++++---------
 drivers/staging/iio/gyro/adis16260_core.c     |   25 +--------
 drivers/staging/iio/gyro/adis16260_trigger.c  |   46 +++++++---------
 drivers/staging/iio/imu/adis16300_core.c      |   26 +---------
 drivers/staging/iio/imu/adis16300_trigger.c   |   48 +++++++---------
 drivers/staging/iio/imu/adis16350_core.c      |   26 +---------
 drivers/staging/iio/imu/adis16350_trigger.c   |   48 +++++++---------
 drivers/staging/iio/imu/adis16400_core.c      |   26 +---------
 drivers/staging/iio/imu/adis16400_trigger.c   |   47 +++++++---------
 drivers/staging/iio/light/tsl2563.c           |   72 +++++++++++--------------
 drivers/staging/iio/meter/ade7758_core.c      |   30 +---------
 drivers/staging/iio/meter/ade7758_trigger.c   |   48 +++++++---------
 21 files changed, 250 insertions(+), 550 deletions(-)

-- 
1.7.3.4

