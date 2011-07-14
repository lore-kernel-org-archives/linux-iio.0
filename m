Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49458 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754620Ab1GNMdt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Jul 2011 08:33:49 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/7] IIO: Fix to error path and some housekeeping.
Date: Thu, 14 Jul 2011 13:33:40 +0100
Message-Id: <1310646827-25690-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Nothing terribly exciting in here.

Bit of reorganization to ensure drivers see less of the core infrastructure
and removal of various things from headers that no longer have a reason
to exist.

Comments welcome!

Jonathan

Jonathan Cameron (7):
  staging:iio:core simplify and fix a bug in
    iio_device_(un)register_event_set.
  staging:iio:core flatten convenience function that only has one user.
  staging:iio:core squash trivial wrappers and use ida allocation func.
  staging:iio:trigger core. Trivial code cleanups.
  staging:iio: Introduce iio_core.h and move all core only stuff out of
    iio.h.
  staging:iio:sysfs cleanout header for unused definitions.
  staging:iio:events: use IIO_<TYPE> and IIO_MOD_<> instead of
    IIO_EV_CLASS_<TYPE> etc

 drivers/staging/iio/accel/lis3l02dq_core.c |   24 ++--
 drivers/staging/iio/accel/sca3000_core.c   |   18 ++--
 drivers/staging/iio/adc/ad7150.c           |    8 +-
 drivers/staging/iio/adc/ad7816.c           |    2 +-
 drivers/staging/iio/adc/ad799x_core.c      |    4 +-
 drivers/staging/iio/adc/adt75.c            |    2 +-
 drivers/staging/iio/adc/max1363_core.c     |   24 ++---
 drivers/staging/iio/dac/ad5504.c           |    2 +-
 drivers/staging/iio/iio.h                  |   67 +----------
 drivers/staging/iio/iio_core.h             |   48 ++++++++
 drivers/staging/iio/iio_core_trigger.h     |    5 +-
 drivers/staging/iio/industrialio-core.c    |  178 +++++++++++----------------
 drivers/staging/iio/industrialio-ring.c    |    1 +
 drivers/staging/iio/industrialio-trigger.c |   23 ++---
 drivers/staging/iio/light/tsl2563.c        |    2 +-
 drivers/staging/iio/sysfs.h                |   71 +-----------
 16 files changed, 174 insertions(+), 305 deletions(-)
 create mode 100644 drivers/staging/iio/iio_core.h

-- 
1.7.3.4

