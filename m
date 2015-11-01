Return-Path: <ciorneiioana@gmail.com>
From: Ioana Ciornei <ciorneiioana@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: outreachy-kernel@googlegroups.com,
	Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 0/2] iio: check return value of sscanf
Date: Sun,  1 Nov 2015 15:03:23 +0200
Message-Id: <1446383003-12924-1-git-send-email-ciorneiioana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patchset fixes the checkpatch.pl warnings:
WARNING: unchecked sscanf return value
by checking that the return value of sscanf call is the one
expected.


Ioana Ciornei (2):
  iio: gyro: check sscanf return value
  iio: imu: check sscanf return value

 drivers/iio/gyro/adis16136.c     | 4 +++-
 drivers/iio/imu/adis16400_core.c | 6 +++++-
 drivers/iio/imu/adis16480.c      | 4 +++-
 3 files changed, 11 insertions(+), 3 deletions(-)

-- 
2.1.4
