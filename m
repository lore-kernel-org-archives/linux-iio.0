Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:58523 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbbFBVet (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 2 Jun 2015 17:34:49 -0400
From: Octavian Purdila <octavian.purdila@intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 0/2] change "client->irq >= 0" to "client->irq > 0"
Date: Wed,  3 Jun 2015 00:34:11 +0300
Message-Id: <1433280853-3988-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This fixes an issue introduces by commit dab472eb931b ("i2c / ACPI:
Use 0 to indicate that device does not have interrupt assigned") where
drivers will try to request IRQ 0 when no GpioInt is defined in ACPI.

The same issue occurs when the device is instantiated via device tree
with no IRQ, or from the i2c sysfs interface, even before the patch
above.

Linus, since the commit above was already merged in the GPIO tree,
should these fixes be merged also via the GPIO tree (with ACKs from
the others subsystem maintainers)?

Octavian Purdila (2):
  iio: change "client->irq >= 0" to "client->irq > 0"
  rtc: change "client->irq >= 0" to "client->irq > 0"

 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/accel/mma9553.c      | 2 +-
 drivers/iio/imu/kmx61.c          | 8 ++++----
 drivers/rtc/rtc-ds1374.c         | 4 ++--
 drivers/rtc/rtc-ds3232.c         | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1

