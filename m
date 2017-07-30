Return-Path: <SRS0=O2KO=7B=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v3 00/11] iio: adc: ti-ads1015: fixes, cleanups, and threshold event support
Date: Mon, 31 Jul 2017 00:12:44 +0900
Message-Id: <1501427575-31045-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This series contains some fixes and cleanups, and a threshold event support
for ti-ads1015 driver.

The first six patches are bug fixes, next four are cleanups, and the last
one adds support threshold event.

Changes from v2 (All changes are done in the last patch)
- Add an error checking for conv register read in interrupt handler
- Fix comparator polarity field setting in config register

Changes from v1
- Split the patch "enable conversion when CONFIG_PM is not set" into a pure
  fix and a cleanup
- Add new patch "don't return invalid value from buffer setup callbacks"
- Add new patch "add adequate wait time to get correct conversion"
- Support traditional comparator mode in addition to window comparator mode,
  add a comment for default threshold settings, and allow setting the state
  that has already been set in threshold event support patch

Akinobu Mita (11):
  iio: adc: ti-ads1015: fix incorrect data rate setting update
  iio: adc: ti-ads1015: fix scale information for ADS1115
  iio: adc: ti-ads1015: enable conversion when CONFIG_PM is not set
  iio: adc: ti-ads1015: avoid getting stale result after runtime resume
  iio: adc: ti-ads1015: don't return invalid value from buffer setup
    callbacks
  iio: adc: ti-ads1015: add adequate wait time to get correct conversion
  iio: adc: ti-ads1015: remove unnecessary config register update
  iio: adc: ti-ads1015: add helper to set conversion mode
  iio: adc: ti-ads1015: use devm_iio_triggered_buffer_setup
  iio: adc: ti-ads1015: use iio_device_claim_direct_mode()
  iio: adc: ti-ads1015: add threshold event support

 drivers/iio/adc/ti-ads1015.c | 594 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 500 insertions(+), 94 deletions(-)

Cc: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
-- 
2.7.4
