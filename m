Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 0/6] iio: sx9500: power and GPIO fixes
Date: Fri,  3 Apr 2015 15:47:28 +0300
Message-Id: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This series addresses a few separate issues of the driver, the main one
being power usage.

Also featured: GPIO pin renaming to something less silly than
"sx9500_gpio-gpios", using a reset pin if available, and finally a minor
formatting nit that kept bugging me.

Vlad Dogaru (6):
  iio: sx9500: add power management
  iio: sx9500: optimize power usage
  iio: sx9500: rename GPIO interrupt pin
  iio: sx9500: refactor GPIO interrupt code
  iio: sx9500: add GPIO reset pin
  iio: sx9500: fix formatting

 drivers/iio/proximity/sx9500.c | 479 ++++++++++++++++++++++++++++++++---------
 1 file changed, 381 insertions(+), 98 deletions(-)

-- 
1.9.1
