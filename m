Return-Path: <SRS0=wvzB=7T=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 17 Aug 2017 15:56:09 +0200
Message-Id: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 0/4] iio: magnetometer: ak8974: support AMI306
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

This series adds support for AMI306 magnetometer. The device is very
similar to already supported AMI305. Calibration data is not used
yet as I still need to figure out what it means.

Michał Mirosław (4):
  iio: magnetometer: ak8974: support AMI306 variant
  iio: magnetometer: ak8974: add_device_randomness(fw + serial)
  iio: magnetometer: ak8974: mark INT_CLEAR as precious
  iio: magnetometer: ak8974: debug AMI306 calibration data

 drivers/iio/magnetometer/Kconfig  |   4 +-
 drivers/iio/magnetometer/ak8974.c | 134 +++++++++++++++++++++++++++++++++-----
 2 files changed, 119 insertions(+), 19 deletions(-)

-- 
2.11.0
