Return-Path: <SRS0=G8mi=GG=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com,
	21cnbao@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH v2 0/9] Staging: iio: accel: adis16201 driver cleanup
Date: Sat, 17 Mar 2018 01:36:17 +0530
Message-Id: <1521230786-18155-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The following patch series cleans up miscellaneous code fragments and 
then the driver is moved from staging to mainline IIO subsytem directory.
Note that the last patch to move driver is *not* generated using '-M' flag,
which is used for detecting renames, since it may help reviewers to
suggest more cleanups/fix while pointing inline to the patch, the 
necessary changes. The framing of patch is made consistent with the
datasheet naming where possible.

For all the patches:
Suggested-by: Jonathan Cameron <jic23@kernel.org>
https://marc.info/?l=linux-iio&m=151775804702998&w=2

Himanshu Jha (9):
  Staging: iio: accel: adis16201: Rename few macro definitions
  Staging: iio: accel: adis16201: Remove unnecessary comments
  Staging: iio: accel: adis16201: Add _REG suffix to reisters
  Staging: iio: accel: adis16201: Group register definitions
  Staging: iio: accel: adis16201: Add comments about units in read_raw()
  Staging: iio: accel: adis16201: Use sign_extend32 function
  Staging: iio: accel: adis16201: Prefer reverse christmas tree ordering
  Staging: iio: accel: adis16201: Adjust argument to match open
    parentheses
  Staging: iio: accel: adis16201: Move adis16201 driver out of staging

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 327 +++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 385 ----------------------------------
 6 files changed, 340 insertions(+), 398 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

-- 
2.7.4
