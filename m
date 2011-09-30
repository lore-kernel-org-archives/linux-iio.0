Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46052 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129Ab1I3KGf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 30 Sep 2011 06:06:35 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Device-drivers-devel@blackfin.uclinux.org,
	manuel.stahl@iis.fraunhofer.de, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 00/11] IIO: resolvers - first round of cleanups.
Date: Fri, 30 Sep 2011 11:14:43 +0100
Message-Id: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi All,

Mostly straight forward, but that change I suggested yesterday
IIO_GYRO -> IIO_ANGL_VEL and in_gyro_x_* -> in_anglvel_x_*
is in here.  I'm interested to hear peoples opinions on that
in particular.

Note the ad2s1210 is still definitely a work in progress.
There are numerous weird and wonderful corners of its abi
a the moment that need sorting out.

Thanks,

Jonathan

Jonathan Cameron (11):
  staging:iio:resolver:ad2s90 fix registration of null pointer
  staging:iio:resolver:ad2s90 ensure name is passed to iio_core.
  stagiong:iio:resolver:ad2s90 chan spec conversion
  staging:iio: rename gyro channels to anglvel
  staging:iio:Documentation gyro -> anglvel updates in attribute names
  staging:iio:resolver:ad2s120x chan spec conversion
  staging:iio:resolver rename ad2s120x ->ad2s1200
  staging:iio:resolver:ad2s1210 ensure iio_dev->name is set
  staging:iio:resolver:ad2s1210 minimal chan spec conversion.
  staging:iio:resolver:ad2s1210 drop raw config register access
  staging:iio:resolver:ad2s1210 cleanup gpio handling.

 drivers/staging/iio/Documentation/sysfs-bus-iio |  108 ++++++------
 drivers/staging/iio/gyro/adis16060_core.c       |    2 +-
 drivers/staging/iio/gyro/adis16080_core.c       |    2 +-
 drivers/staging/iio/gyro/adis16130_core.c       |    2 +-
 drivers/staging/iio/gyro/adis16260_core.c       |    8 +-
 drivers/staging/iio/gyro/adxrs450_core.c        |    4 +-
 drivers/staging/iio/iio.h                       |    2 +-
 drivers/staging/iio/imu/adis16400_core.c        |   22 ++--
 drivers/staging/iio/industrialio-core.c         |    2 +-
 drivers/staging/iio/resolver/Kconfig            |    4 +-
 drivers/staging/iio/resolver/Makefile           |    2 +-
 drivers/staging/iio/resolver/ad2s1200.c         |  187 ++++++++++++++++++++
 drivers/staging/iio/resolver/ad2s120x.c         |  178 -------------------
 drivers/staging/iio/resolver/ad2s1210.c         |  216 +++++++++-------------
 drivers/staging/iio/resolver/ad2s90.c           |   57 +++---
 15 files changed, 382 insertions(+), 414 deletions(-)
 create mode 100644 drivers/staging/iio/resolver/ad2s1200.c
 delete mode 100644 drivers/staging/iio/resolver/ad2s120x.c

-- 
1.7.3.4

