Return-Path: <zubair.lutfullah@gmail.com>
From: Zubair Lutfullah <zubair.lutfullah@gmail.com>
To: jic23@cam.ac.uk,
	dmitry.torokhov@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bigeasy@linutronix.de,
	gregkh@linuxfoundation.org,
	zubair.lutfullah@gmail.com
Subject: [PATCH V11 0/3] iio: input: ti_am335x_adc: Add continuous sampling support
Date: Thu, 19 Sep 2013 11:24:32 +0500
Message-Id: <1379571876-12420-1-git-send-email-zubair.lutfullah@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

These apply to the togreg branch in iio.

Round 11
- Optimized memory usage based on list feedback
- Changed devm_*_irq to normal *_irq functions

Round 10 updates
- Removed devm_free as not needed

Round 9 updates

- Removed Trigger.
- Restructured everything for INDIO_BUFFERED_HARDWARE mode.
- Threaded IRQ with top/bottom halfs. Top half HW IRQ wakes
bottom half threaded worker that pushes samples to iio/userspace.
- Removed some of the patchwork to the driver that was irrelevant to the
continuous sampling patch.

Cleanup will be done separately once this goes through.
Hope these patches meet the mighty kernel standards :)

Zubair

Zubair Lutfullah (3):
  input: ti_am335x_tsc: Enable shared IRQ for TSC
  iio: ti_am335x_adc: optimize memory usage.
  iio: ti_am335x_adc: Add continuous sampling support

 drivers/iio/adc/ti_am335x_adc.c           |  217 ++++++++++++++++++++++++++++-
 drivers/input/touchscreen/ti_am335x_tsc.c |   12 +-
 include/linux/mfd/ti_am335x_tscadc.h      |    9 ++
 3 files changed, 228 insertions(+), 10 deletions(-)

-- 
1.7.9.5
