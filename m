Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 0/3] Add available sampling frequency and scale attributes
Date: Fri, 29 Apr 2016 14:42:32 +0300
Message-Id: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

First two patches are bugfixes related to sampling frequency and the last
one is adding support for exporting available sampling frequency and scale.

Daniel Baluta (3):
  iio: bmi160: Fix output data rate for accel
  iio: bmi160: Fix ODR setting
  imu: bmi160: Add avail frequency and scale attributes

 drivers/iio/imu/bmi160/bmi160_core.c | 43 +++++++++++++++++++++++++++++-------
 1 file changed, 35 insertions(+), 8 deletions(-)

-- 
2.5.0
