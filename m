Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58435 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab3I2TtI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 29 Sep 2013 15:49:08 -0400
Message-ID: <5248925E.8090900@kernel.org>
Date: Sun, 29 Sep 2013 21:49:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: [PULL] IIO new driver features, cleanups and fixes for 3.13 set 2
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The following changes since commit 3ffdea3feca9e2c95c2e93e217d77c9c368f747a:

  Merge tag 'iio-for-3.13a' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into staging-next (2013-09-22
11:30:12 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-3.13b

for you to fetch changes up to 10a485c55ae8d313194afc7a8c65df3ac7c048a1:

  iio:trigger: fix sysfs name on list mutex (2013-09-28 11:51:16 +0100)

----------------------------------------------------------------
Second set of new functionality for IIO in the 3.13 cycle - with bug fixes for first set.

This is a small, mainly to get a couple of compile bug related fixes into
the tree ASAP.

New device support:
1) Add ad5446 dac support to the ad5641 driver.

New functionality and cleanups:
1) Optional power supply regulators for the st pressure sensors drivers using
   the new optional regulator interface.
2) Bit of tidying up of naming in the sysfs trigger.

Bug fixes from the previous series:
1) Missing select IIO_BUFFER for ti_am335x_adc
2) Drop a bonus bracket in iio-trig-bfin-timmer

----------------------------------------------------------------
Aida Mynzhasova (1):
      iio: dac: ad5446: Add support for AD5641

Denis CIOCCA (1):
      iio:trigger: fix sysfs name on list mutex

Jonathan Cameron (1):
      iio:ti_am335x_adc ensure that IIO_KFIFO_BUF is not selected witout IIO_BUFFER

Lars-Peter Clausen (1):
      staging:iio:iio-trig-bfin-timer: Fix compile error

Lee Jones (2):
      iio: pressure-core: st: Provide support for the Vdd power supply
      iio: pressure-core: st: Provide support for the Vdd_IO power supply

 drivers/iio/adc/Kconfig                           |  1 +
 drivers/iio/dac/Kconfig                           |  2 +-
 drivers/iio/dac/ad5446.c                          |  6 ++++
 drivers/iio/pressure/st_pressure_core.c           | 39 +++++++++++++++++++++++
 drivers/iio/trigger/iio-trig-sysfs.c              | 14 ++++----
 drivers/staging/iio/trigger/iio-trig-bfin-timer.c |  2 +-
 include/linux/iio/common/st_sensors.h             |  5 +++
 7 files changed, 60 insertions(+), 9 deletions(-)
