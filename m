Return-Path: <sachin.kamat@linaro.org>
From: Sachin Kamat <sachin.kamat@linaro.org>
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk,
	jic23@kernel.org,
	sachin.kamat@linaro.org
Subject: [PATCH 00/11] iio: adc: Use devm_* APIs
Date: Tue, 23 Jul 2013 14:28:06 +0530
Message-Id: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

All patches are compile tested and based on togreg branch
of following tree:
git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git

Sachin Kamat (11):
  iio: adc: ad7298: Use devm_* APIs
  iio: adc: ad7476: Use devm_* APIs
  iio: adc: ad7791: Use devm_* APIs
  iio: adc: ad7793: Use devm_* APIs
  iio: adc: ad7887: Use devm_* APIs
  iio: adc: ad7923: Use devm_* APIs
  iio: adc: lp8788_adc: Use devm_* APIs
  iio: adc: mcp320x: Use devm_* APIs
  iio: adc: nau7802: Use devm_iio_device_alloc
  iio: adc: ti-adc081c: Use devm_* APIs
  iio: adc: viperboard_adc: Use devm_iio_device_alloc

 drivers/iio/adc/ad7298.c         |   24 ++++++++----------------
 drivers/iio/adc/ad7476.c         |   26 ++++++++------------------
 drivers/iio/adc/ad7791.c         |   19 +++++--------------
 drivers/iio/adc/ad7793.c         |   23 ++++++-----------------
 drivers/iio/adc/ad7887.c         |   23 +++++++----------------
 drivers/iio/adc/ad7923.c         |   20 +++++++-------------
 drivers/iio/adc/lp8788_adc.c     |    7 ++-----
 drivers/iio/adc/mcp320x.c        |   18 +++++-------------
 drivers/iio/adc/nau7802.c        |   19 ++++++++-----------
 drivers/iio/adc/ti-adc081c.c     |   18 +++++-------------
 drivers/iio/adc/viperboard_adc.c |    9 ++-------
 11 files changed, 63 insertions(+), 143 deletions(-)

-- 
1.7.9.5
