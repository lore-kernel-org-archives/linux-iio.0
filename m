Return-Path: <SRS0=pUtU=6P=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 0/8] iio: adc: ti-ads1015: fixes, cleanups, and threshold event support
Date: Thu, 13 Jul 2017 01:31:56 +0900
Message-Id: <1499877124-21658-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This series contains some fixes and cleanups that I found, and a threshold
event support for ti-ads1015 driver.

The first five patches are classified as bug fixes (one of which is a
borderline between bugfix and cleanup).  The next two are cleanups that
can be considered as preparation for the last threshold event support.

Akinobu Mita (8):
  iio: adc: ti-ads1015: fix incorrect data rate setting update
  iio: adc: ti-ads1015: remove unnecessary config register update
  iio: adc: ti-ads1015: fix scale information for ADS1115
  iio: adc: ti-ads1015: enable conversion when CONFIG_PM is not set
  iio: adc: ti-ads1015: avoid getting stale result after runtime resume
  iio: adc: ti-ads1015: use devm_iio_triggered_buffer_setup
  iio: adc: ti-ads1015: use iio_device_claim_direct_mode()
  iio: adc: ti-ads1015: add threshold event support

 drivers/iio/adc/ti-ads1015.c | 534 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 442 insertions(+), 92 deletions(-)

Cc: Daniel Baluta <daniel.baluta@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4
