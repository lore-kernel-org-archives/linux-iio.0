Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 0/3] IIO fixes for 3.0 (or 3.0 stable)
Date: Wed, 13 Jul 2011 12:51:57 +0100
Message-Id: <1310557920-30519-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

A few clangers slipped through until now.  Sorry they are so late!

The IMU patch is non trivial so has been on list for a few days.
Result is you get the same channel which ever one you try to read on
some devices (oops).

Kfifo hasn't been posted, but is trivial.  Just causes a warning. Virtually
no users, so this one isn't that critical.

lis3l02dq - not posted, but trivial. Causes null dereference on remove.

Thanks

Jonathan

Jonathan Cameron (3):
  staging:iio:imu fix missing register table index for some channels
  staging:iio:accel:lis3l02dq: fix incorrect pointer passed to
    spi_set_drvdata.
  staging:iio:kfifo_buf fix double initialization of the ring device
    structure.

 drivers/staging/iio/accel/lis3l02dq_core.c |    2 +-
 drivers/staging/iio/imu/adis16400.h        |    3 ++
 drivers/staging/iio/imu/adis16400_core.c   |   50 +++++++++++++++-------------
 drivers/staging/iio/kfifo_buf.c            |    2 -
 4 files changed, 31 insertions(+), 26 deletions(-)

-- 
1.7.3.4
