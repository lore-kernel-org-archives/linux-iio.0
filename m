Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:45364 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1174340AbdDYBj5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 24 Apr 2017 21:39:57 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v3 0/2] staging: iio: isl29028: move out of staging
Date: Mon, 24 Apr 2017 21:34:32 -0400
Message-Id: <20170425013434.1206-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Minor cleanup to the proximity sampling to move this driver out of
staging.

Datasheet:
http://www.intersil.com/content/dam/Intersil/documents/isl2/isl29028.pdf

Changes since v2:
- Reject any value that is not in the
  in_proximity_sampling_frequency_available sysfs attribute.
- Changed the sampling frequency 83.3 to 80. The data sheet lists 12.5
  ms, but the original code listed 12 ms, which was the cause of the
  discrepancy.
Changes since v1:
- in_proximity_sampling_frequency_available sysfs attribute now shows
  decimals.

Jonathan: Sorry it took me a little over two months to get back to you
on this driver. I got side tracked with other projects.

Brian Masney (2):
  staging: iio: isl29028: correct proximity sleep times
  staging: iio: isl29028: move out of staging

 drivers/iio/light/Kconfig            |  10 +
 drivers/iio/light/Makefile           |   1 +
 drivers/iio/light/isl29028.c         | 723 +++++++++++++++++++++++++++++++++++
 drivers/staging/iio/light/Kconfig    |  10 -
 drivers/staging/iio/light/Makefile   |   1 -
 drivers/staging/iio/light/isl29028.c | 693 ---------------------------------
 6 files changed, 734 insertions(+), 704 deletions(-)
 create mode 100644 drivers/iio/light/isl29028.c
 delete mode 100644 drivers/staging/iio/light/isl29028.c

-- 
2.9.3

