Return-Path: <laurentiu.palcu@intel.com>
From: Laurentiu Palcu <laurentiu.palcu@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	laurentiu.palcu@intel.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] iio: accel: BMC150: add support for more Bosch chips
Date: Thu, 28 Aug 2014 11:35:03 +0300
Message-Id: <1409214906-27038-1-git-send-email-laurentiu.palcu@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Hi,

The following patchset fixes a couple of minor issues with the BMC150
accelerometer driver and, also, adds support for more Bosch accelerometer chips
that are basically identical to BMC150 or have only the resolution different.
So, it makes sense to reuse this existing driver.

All the accelerometer chips were tested using the eval boards provided by
Bosch.

laurentiu

Laurentiu Palcu (3):
  iio: accel: BMC150: fix scale value for 16G
  iio: accel: BMC150: fix issues when CONFIG_PM_RUNTIME is not set
  iio: accel: BMC150: add support for other Bosch chips

 drivers/iio/accel/bmc150-accel.c | 238 ++++++++++++++++++++++++++++++---------
 1 file changed, 184 insertions(+), 54 deletions(-)

-- 
1.9.1
