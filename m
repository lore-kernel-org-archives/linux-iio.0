Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:39096 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757979Ab1GKQA4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2011 12:00:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] IIO: Header housekeeping.
Date: Mon, 11 Jul 2011 17:00:50 +0100
Message-Id: <1310400053-30041-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lots of header includes that aren't needed.
Some are cut and paste bloat, others from pre threaded irq days.

Pretty straight forward. Build tested on arm. Probably worth a quick
build on blackfin if someone has the time.

Jonathan Cameron (3):
  staging:iio:adc: header cleanup - remove unused.
  staging:iio:accel header housekeeping - remove unecessary includes.
  staging:iio:gyro and meter: header housecleaning.

 drivers/staging/iio/accel/adis16201_ring.c    |    4 ----
 drivers/staging/iio/accel/adis16201_trigger.c |    5 -----
 drivers/staging/iio/accel/adis16203_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16203_trigger.c |    6 ------
 drivers/staging/iio/accel/adis16204_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16204_trigger.c |    6 ------
 drivers/staging/iio/accel/adis16209_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16209_trigger.c |    6 ------
 drivers/staging/iio/accel/adis16240_ring.c    |    7 -------
 drivers/staging/iio/accel/adis16240_trigger.c |    6 ------
 drivers/staging/iio/accel/lis3l02dq_ring.c    |    4 ----
 drivers/staging/iio/accel/sca3000_ring.c      |    2 --
 drivers/staging/iio/adc/ad7298_ring.c         |    3 ---
 drivers/staging/iio/adc/ad7476_ring.c         |    2 --
 drivers/staging/iio/adc/ad7606_ring.c         |    2 --
 drivers/staging/iio/adc/ad7887_ring.c         |    3 ---
 drivers/staging/iio/adc/ad799x_ring.c         |    3 ---
 drivers/staging/iio/adc/max1363_ring.c        |    4 ----
 drivers/staging/iio/gyro/adis16260_ring.c     |    7 -------
 drivers/staging/iio/gyro/adis16260_trigger.c  |    6 ------
 drivers/staging/iio/meter/ade7758_ring.c      |    8 --------
 drivers/staging/iio/meter/ade7758_trigger.c   |    6 ------
 22 files changed, 0 insertions(+), 111 deletions(-)

-- 
1.7.3.4

