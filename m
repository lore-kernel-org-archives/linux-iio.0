Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: vapier@gentoo.org
Cc: barry.song@analog.com,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] staging:iio: abi updates for new drivers from Analog.
Date: Sun,  8 Aug 2010 16:08:15 +0100
Message-Id: <1281280098-11111-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Here are the 3 abi update patches needed to make the drivers
Mike posted to work with the current mainline kernel.

These (or equivalent) will need to get merged into the underlying
drivers before they are sent on to Greg KH.

For reference these were against staging-next with the patches
Mike sent applied.

Thanks,

Jonathan

Jonathan Cameron (3):
  staging:iio:adis16201 update driver to compile with mainline abi.
  staging:iio:adis16203 update driver to compile with mainline abi.
  staging:iio:adis16204 update driver to compile with mainline abi.

 drivers/staging/iio/accel/adis16201.h         |    2 --
 drivers/staging/iio/accel/adis16201_core.c    |   19 +++++++++----------
 drivers/staging/iio/accel/adis16201_ring.c    |    4 ++--
 drivers/staging/iio/accel/adis16201_trigger.c |   10 ++++------
 drivers/staging/iio/accel/adis16203.h         |    2 --
 drivers/staging/iio/accel/adis16203_core.c    |   19 +++++++++----------
 drivers/staging/iio/accel/adis16203_ring.c    |    4 ++--
 drivers/staging/iio/accel/adis16203_trigger.c |   10 ++++------
 drivers/staging/iio/accel/adis16204.h         |    2 --
 drivers/staging/iio/accel/adis16204_core.c    |   19 +++++++++----------
 drivers/staging/iio/accel/adis16204_ring.c    |    4 ++--
 drivers/staging/iio/accel/adis16204_trigger.c |   10 ++++------
 12 files changed, 45 insertions(+), 60 deletions(-)
