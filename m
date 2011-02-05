Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:60075 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab1BERwP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Feb 2011 12:52:15 -0500
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: mensch0815@googlemail.com,
	device-drivers-devel@blackfin.uclinux.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/5] staging:iio:gyro driver cleanups.
Date: Sat,  5 Feb 2011 17:52:00 +0000
Message-Id: <1296928325-14967-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first 3 of these are cleanups that have been on linux-iio for
quite some time. Ideally they would have an ack from someone at
Analog.

The last 2 are new.  They add support for the adis16251 into
the adis16260 driver and then remove the existing adis16251 driver.
I think I have dealt with all the difference between these parts
that are relevant to the driver.  This will cause a few minor
changes in the userspace interface.  There are other cleanups
needed in adis16260 but those can occur after this merge has
gone in.  If anyone has a chance to check I haven't missed any
incompatabilities that would be great.

Note I have none of these parts so any testing would be much
appreciated!  Unless I've messed up badly the parts already
supported by adis16260 should see no changes at all as a result
of the additional support.

Thanks,

Jonathan

Jonathan Cameron (5):
  staging:iio:gyro:adis16060 cleanup and dead code removal
  staging:iio:gyro:adis16080 unused stub removal and cleanup
  staging:iio:gyro:adis16130 stub removal and cleanup
  staging:iio:gyro: add adis16251 support to adis16260 driver.
  staging:iio:gyro remove adis16251 driver as now supported by
    adis16260 driver.

 drivers/staging/iio/gyro/Kconfig          |   14 +-
 drivers/staging/iio/gyro/adis16060.h      |   70 ---
 drivers/staging/iio/gyro/adis16060_core.c |   59 +--
 drivers/staging/iio/gyro/adis16080.h      |   84 +---
 drivers/staging/iio/gyro/adis16080_core.c |   54 +--
 drivers/staging/iio/gyro/adis16130.h      |   72 +---
 drivers/staging/iio/gyro/adis16130_core.c |   61 +--
 drivers/staging/iio/gyro/adis16251.h      |  185 -------
 drivers/staging/iio/gyro/adis16251_core.c |  777 -----------------------------
 drivers/staging/iio/gyro/adis16260_core.c |   49 ++-
 10 files changed, 78 insertions(+), 1347 deletions(-)
 delete mode 100644 drivers/staging/iio/gyro/adis16251.h
 delete mode 100644 drivers/staging/iio/gyro/adis16251_core.c

-- 
1.7.3.4

