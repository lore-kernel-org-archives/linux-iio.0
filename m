Return-Path: <SRS0=8i//=E7=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 0/2] Remove usage of mlocks from ade7758 file 
Date: Tue,  6 Feb 2018 01:05:50 +0530
Message-Id: <cover.1517845616.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset has been introduced for the removal of mlocks
from the ade7758 file and replace it with the already established
buf_lock.
Patch *[1/2] removes the unnecessary mlocks i.e. which are
taken around the read cases.
Patch *[2/2] replaces other mlocks with buf_locks and introduces
unlocked forms of read and write registers so as to avoid nested 
locks. Also some additional cleanups like moving the locks to where
they are required to protect, are made to improve the code clarity.

This patchset has been introduced after the revisions done on the
patch *[2/2] and also there was the need of patch *[1/2].


Shreeya Patel (2):
  Staging: iio: ade7758: Remove iio_dev mlock
  Staging: iio: ade7758: Expand buf_lock to cover both buffer and state
    protection

 drivers/staging/iio/meter/ade7758.h      |  2 +-
 drivers/staging/iio/meter/ade7758_core.c | 54 ++++++++++++++++++++++----------
 2 files changed, 39 insertions(+), 17 deletions(-)

-- 
2.7.4
