Return-Path: <SRS0=gLGt=F2=onstation.org=masneyb@kernel.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	devel@driverdev.osuosl.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-kernel@vger.kernel.org,
	Jon.Brenner@ams.com
Subject: [PATCH 00/12] staging cleanups
Date: Sat,  3 Mar 2018 20:49:30 -0500
Message-Id: <20180304014942.18727-1-masneyb@onstation.org>
List-ID: <linux-iio@vger.kernel.org>

Here is another patch series that inches the driver closer to moving out
of staging. The most interesting changes are the last two in the series.
One gets the proximity sensor working and the other one removes the
unnecessary in_proximity0_calibscale_available sysfs attribute from two
of the supported devices. The rest of the patches are not that
interesting and either reduce duplicate code, add error handling, or
other minor cosmetic changes.

Brian Masney (12):
  staging: iio: tsl2x7x: remove power functions from
    tsl2X7X_platform_data
  staging: iio: tsl2x7x: add common function for clearing interrupts
  staging: iio: tsl2x7x: add common function for reading chip status
  staging: iio: tsl2x7x: add common function for writing to the control
    register
  staging: iio: tsl2x7x: convert mutex_trylock() to mutex_lock()
  staging: iio: tsl2x7x: correctly return errors in tsl2x7x_get_prox()
  staging: iio: tsl2x7x: correct 'Avoid CamelCase' warning from
    checkpatch
  staging: iio: tsl2x7x: add error handling to tsl2x7x_prox_cal()
  staging: iio: tsl2x7x: add missing error checks
  staging: iio: tsl2x7x: make logging consistent and correct newlines
  staging: iio: tsl2x7x: remove unnecessary sysfs attribute
  staging: iio: tsl2x7x: make proximity sensor function correctly

 drivers/staging/iio/light/tsl2x7x.c | 346 ++++++++++++++++++------------------
 drivers/staging/iio/light/tsl2x7x.h |   6 +-
 2 files changed, 179 insertions(+), 173 deletions(-)

-- 
2.14.3
