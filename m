Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:46646 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933898AbeBLLzY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Feb 2018 06:55:24 -0500
From: Himanshu Jha <himanshujha199640@gmail.com>
To: 21cnbao@gmail.com, jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH 0/4] staging: iio: accel: adis16201 driver cleanup
Date: Mon, 12 Feb 2018 17:24:55 +0530
Message-Id: <1518436499-8584-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following patch series cleans up miscellaneous code fragments and
then the driver is moved from staging to mainline IIO subsytem directory.
Note that the last patch to move driver is *not* generated using '-M' flag,
which is used for detecting renames, since it may help reviewers to
suggest more cleanups/fix while pointing inline to the patch the
necessary changes.

All the patches have been tested using 0-day test service with success.

For all the patches:
Suggested-by: Jonathan Cameron <jic23@kernel.org>

Himanshu Jha (4):
  staging: iio: accel: adis16201: Use SPDX identifier
  staging: iio: accel: Remove unnecessary comments and add suitable
    suffix
  staging: iio: accel: Use sign_extend32 and adjust a switch statement
  staging: iio: accel: Move adis16201 driver out of staging

 drivers/iio/accel/Kconfig             |  12 ++
 drivers/iio/accel/Makefile            |   1 +
 drivers/iio/accel/adis16201.c         | 315 ++++++++++++++++++++++++++++
 drivers/staging/iio/accel/Kconfig     |  12 --
 drivers/staging/iio/accel/Makefile    |   1 -
 drivers/staging/iio/accel/adis16201.c | 381 ----------------------------------
 6 files changed, 328 insertions(+), 394 deletions(-)
 create mode 100644 drivers/iio/accel/adis16201.c
 delete mode 100644 drivers/staging/iio/accel/adis16201.c

-- 
2.7.4

