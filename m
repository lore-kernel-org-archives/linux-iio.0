Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:29347 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbbFEMm2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 08:42:28 -0400
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
Subject: [PATCH v2 0/2] fix drivers that consider 0 as a valid IRQ in client->irq
Date: Fri,  5 Jun 2015 15:41:56 +0300
Message-Id: <1433508118-3938-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Since patch "i2c / ACPI: Use 0 to indicate that device does not have
interrupt assigned" [1], 0 is not a valid i2c client irq anymore, so
change all driver's checks accordingly.

The same issue occurs when the device is instantiated via device tree
with no IRQ, or from the i2c sysfs interface, even before the patch
above.

[1] https://lkml.org/lkml/2015/5/6/279

Changes since v1:

* remove the commit id as the referenced patch is not yet merged

* rephrased the subject line to be more descriptive

Octavian Purdila (2):
  iio: fix drivers that consider 0 as a valid IRQ in client->irq
  rtc: fix drivers that consider 0 as a valid IRQ in client->irq

 drivers/iio/accel/bmc150-accel.c | 2 +-
 drivers/iio/accel/kxcjk-1013.c   | 2 +-
 drivers/iio/accel/mma9553.c      | 2 +-
 drivers/iio/imu/kmx61.c          | 8 ++++----
 drivers/rtc/rtc-ds1374.c         | 4 ++--
 drivers/rtc/rtc-ds3232.c         | 2 +-
 6 files changed, 10 insertions(+), 10 deletions(-)

-- 
1.9.1

