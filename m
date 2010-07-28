Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: Greg KH <greg@kroah.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>,
	akpm@linux-foundation.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio Build issue fixes
Date: Wed, 28 Jul 2010 20:07:34 +0100
Message-Id: <1280344057-18786-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <4C5077A0.7090701@cam.ac.uk>
References: <4C5077A0.7090701@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Sorry about this lot.  I clearly missed one big case when build testing
the last series of patches I sent you. Evidently never built them without
buffering enabled.

Randy Dunlap found these 3 (posted to lkml in the thread,

mmotm 2010-07-27-14-56 uploaded (staging/iio)

I know of one remaining issue to do with some pointer arithmetic that won't
work on 64 bit machines that I will try and get fixed shortly.

Jonathan Cameron (3):
  staging:iio: iio_sw_ring_helper_state - add dummy case for no buffer
    builds.
  staging:iio:lis3l02dq add a thresh_timestamp field to state for no
    ring case
  staging:iio:adis1350 add dummy ring functions for no ring build case

 drivers/staging/iio/accel/lis3l02dq.h      |    2 ++
 drivers/staging/iio/accel/lis3l02dq_core.c |   14 +++++++-------
 drivers/staging/iio/imu/adis16350.h        |    8 ++++++++
 drivers/staging/iio/ring_sw.h              |    3 +++
 4 files changed, 20 insertions(+), 7 deletions(-)
