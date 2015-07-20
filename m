Return-Path: <adam.yh.lee@gmail.com>
From: Adam YH Lee <adam.yh.lee@gmail.com>
To: linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: linux-iio@vger.kernel.org,
	sre@kernel.org,
	jic23@kernel.org,
	pmeerw@pmeerw.net,
	Adam YH Lee <adam.yh.lee@gmail.com>
Subject: [PATCH] Fix incomplete initialization of ADC[3:6]$
Date: Mon, 20 Jul 2015 11:14:17 -0700
Message-Id: <1437416058-24586-1-git-send-email-adam.yh.lee@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Additionally the original discussion for this patch can be found here [5].
$
[1] http://comments.gmane.org/gmane.linux.ports.arm.omap/83698$
[2] http://gumstix.8.x6.nabble.com/twl4030-madc-low-read-value-td4967139.html#none$
[3] https://e2e.ti.com/support/power_management/pmu/f/43/t/732$
[4] http://www.droid-developers.org/images/2/21/Tps65950_TRM.pdf$
[5] http://www.spinics.net/lists/linux-omap/msg120300.html

Adam YH Lee (1):
  [TWL4030 MADC] Fix ADC[3:6] readings

 drivers/iio/adc/twl4030-madc.c | 14 ++++++++++++++
 drivers/phy/phy-twl4030-usb.c  |  7 +++++++
 2 files changed, 21 insertions(+)

-- 
2.1.4
