Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:60158 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932798Ab2DMJnG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 13 Apr 2012 05:43:06 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 00/14 V2] IIO: Kill off IIO_CHAN macro.
Date: Fri, 13 Apr 2012 10:42:46 +0100
Message-Id: <1334310180-22170-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Greg,

This is clearly out some old cruft.  Arnd warned me it was
a stupid idea and I didn't listen :(  Anyhow, I've been meanging
to do this for ages.  Lars-Peter verified the Analog devices
driver changes and the rest are my drivers so I doubt anyone will
look at them even if I let this sit for longer.

I don't think this is dependent on the fix series I sent a few
mins back, but it was after it in my tree, so there might be
some fuzz in iio.h.

Thanks,

Jonathan

Original message:

This one has been on my mental todo list for a while. As long
as it was there, from time to time a new driver would get
proposed using it thus wasting some poor developers time.

This kills off the remaing users and gets rid of it!

Please can people sanity check I haven't messed up the
removal in their drivers (and anyone elses if they are
bored enough!)

Jonathan

Jonathan Cameron (14):
  staging:iio:accel:adis16201 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16203 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16204 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16209 unwind use of IIO_CHAN macro.
  staging:iio:accel:adis16240 unwind use of IIO_CHAN macro.
  staging:iio:accel:lis3l02dq unwind use of IIO_CHAN macro.
  staging:iio:accel:sca3000 unwind use of IIO_CHAN macro.
  staging:iio:adc:ad7298 unwind use of IIO_CHAN macro.
  staging:iio:adc:ad7476 unwind use of IIO_CHAN macro.
  staging:iio:accel:ad7780 unwind use of IIO_CHAN macro.
  staging:iio:gyro:adis16260 unwind use of IIO_CHAN macro.
  staging:iio:impedance-analyzer:ad5933 unwind use of IIO_CHAN macro.
  staging:iio:meter:ade7758 unwind use of IIO_CHAN macro.
  staging:iio:core drop the IIO_CHAN macro for ease of maintenance.

 drivers/staging/iio/accel/adis16201_core.c      |  116 ++++++++---
 drivers/staging/iio/accel/adis16203_core.c      |   87 ++++++--
 drivers/staging/iio/accel/adis16204_core.c      |   92 ++++++---
 drivers/staging/iio/accel/adis16209_core.c      |  135 +++++++++---
 drivers/staging/iio/accel/adis16240_core.c      |  103 +++++++---
 drivers/staging/iio/accel/lis3l02dq_core.c      |   25 ++-
 drivers/staging/iio/accel/sca3000_core.c        |   26 ++-
 drivers/staging/iio/adc/ad7298_core.c           |   63 ++++---
 drivers/staging/iio/adc/ad7476_core.c           |   45 ++--
 drivers/staging/iio/adc/ad7780.c                |   30 ++-
 drivers/staging/iio/gyro/adis16260_core.c       |   89 ++++++--
 drivers/staging/iio/iio.h                       |   17 --
 drivers/staging/iio/impedance-analyzer/ad5933.c |   47 ++++-
 drivers/staging/iio/meter/ade7758_core.c        |  256 +++++++++++++++++------
 14 files changed, 813 insertions(+), 318 deletions(-)

