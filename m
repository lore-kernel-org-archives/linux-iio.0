Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org,
	patches@linaro.org
Subject: [PATCH 0/8] Use devm_iio_device_alloc
Date: Mon, 22 Jul 2013 16:32:53 +0530
Message-Id: <1374490981-24373-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

All patches are compile tested only.
Based on togreg branch of following tree:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Sachin Kamat (8):
  iio: at91: Use devm_iio_device_alloc
  iio: exynos_adc: Use devm_iio_device_alloc
  iio: max1363: Use devm_iio_device_alloc
  iio: frequency: adf4350: Use devm_* APIs
  staging: iio: mxs-lradc: Use devm_iio_device_alloc
  staging: iio: spear_adc: Use devm_iio_device_alloc
  staging: iio: light: isl29018: Use devm_iio_device_alloc
  staging: iio: light: isl29028: Use devm_iio_device_alloc

 drivers/iio/adc/at91_adc.c           |   23 +++++++----------------
 drivers/iio/adc/exynos_adc.c         |   23 ++++++++---------------
 drivers/iio/adc/max1363.c            |   15 +++++----------
 drivers/iio/frequency/adf4350.c      |   31 +++++++++----------------------
 drivers/staging/iio/adc/mxs-lradc.c  |   21 +++++++--------------
 drivers/staging/iio/adc/spear_adc.c  |   30 ++++++++++++------------------
 drivers/staging/iio/light/isl29018.c |   16 +++++-----------
 drivers/staging/iio/light/isl29028.c |   13 ++++---------
 8 files changed, 57 insertions(+), 115 deletions(-)

-- 
1.7.9.5
