Return-Path: <octavian.purdila@intel.com>
From: Octavian Purdila <octavian.purdila@intel.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: srinivas.pandruvada@linux.intel.com,
	hadess@hadess.net,
	daniel.baluta@intel.com,
	irina.tirdea@intel.com,
	ao2@ao2.it,
	u.kleine-koenig@pengutronix.de,
	vlad.dogaru@intel.com,
	linus.walleij@linaro.org,
	tiberiu.a.breana@intel.com,
	javier@osg.samsung.com,
	dan.carpenter@oracle.com,
	geert@linux-m68k.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH 0/2] remove unused ACPI GPIO interrupt probing code
Date: Wed, 23 Sep 2015 12:01:59 +0300
Message-Id: <1442998921-17665-1-git-send-email-octavian.purdila@intel.com>
List-ID: <linux-iio@vger.kernel.org>

With the addition of automatically ACPI GPIO assignment to i2c
client->irq we can now remove the code the does the ACPI GPIO probing
for drivers that use a single interrupt.

Tested on hardware only on bmc150-accel, rest of the drivers where
compile tested only.

Octavian Purdila (2):
  iio: fix drivers that use 0 as a valid IRQ in client->irq (part 2)
  iio: remove gpio interrupt probing from drivers that use a single
    interrupt

 drivers/iio/accel/bmc150-accel.c       | 30 --------------------------
 drivers/iio/accel/kxcjk-1013.c         | 34 +----------------------------
 drivers/iio/accel/mma9553.c            | 29 -------------------------
 drivers/iio/accel/stk8312.c            | 30 +-------------------------
 drivers/iio/accel/stk8ba50.c           | 30 +-------------------------
 drivers/iio/imu/kmx61.c                | 28 ------------------------
 drivers/iio/light/stk3310.c            | 39 +---------------------------------
 drivers/iio/magnetometer/bmc150_magn.c | 33 ----------------------------
 drivers/iio/proximity/sx9500.c         |  9 --------
 9 files changed, 4 insertions(+), 258 deletions(-)

-- 
1.9.1
