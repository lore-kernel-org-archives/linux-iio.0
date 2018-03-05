Return-Path: <SRS0=UV2j=F3=gmail.com=himanshujha199640@kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com,
	Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 00/11] staging: iio: accel: adis16201 driver cleanup
Date: Mon,  5 Mar 2018 13:19:19 +0530
Message-Id: <1520236170-14668-1-git-send-email-himanshujha199640@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The following patch series cleans up miscellaneous code fragments and
then the driver is moved from staging to mainline IIO subsytem directory.
Note that the last patch to move driver is *not* generated using '-M' flag,
which is used for detecting renames, since it may help reviewers to
suggest more cleanups/fix while pointing inline to the patch, the
necessary changes. The framing of patch is made consistent with the datasheet
naming where possible.

For all the patches:
Suggested-by: Jonathan Cameron <jic23@kernel.org>
https://marc.info/?l=linux-iio&m=151775804702998&w=2

All the patches have been tested using 0-day test service with success.

Himanshu Jha (11):
  Staging: iio: accel: Prefer alphabetical sequence of header files
  Staging: iio: accel: Add a blank space before returns
  Staging: iio: accel: Remove unnecessary comments
  Staging: iio: accel: Rename few macro definitions
  Staging: iio: accel: Add _REG suffix to registers
  Staging: iio: accel: Reverse christmas tree
  Staging: iio: accel: Adjust arguments to match open parentheses
  Staging: iio: accel: Use switch statement than if-else
  Staging: iio: accel: Use sign_extend32 function
  Staging: iio: accel: Add comments about units in data read function
  Staging: iio: accel: Move adis16201 driver out of staging subsystem

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 323 ++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 381 ----------------------------------
 6 files changed, 336 insertions(+), 394 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

-- 
2.7.4
