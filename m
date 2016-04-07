Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 0/5] Support for max44000 Ambient and Infrared Proximity Sensor
Date: Thu,  7 Apr 2016 19:21:49 +0300
Message-Id: <cover.1460045763.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The driver supports reporting illuminance and proximity (via raw reads or
software-triggered) buffers and controling the scaling factors.

There is no support for power management, events or reporting the IR/green
channels separately. The device is always set in the ALS/PROX mode in order to
report all data.

Crestez Dan Leonard (5):
  max44000: Initial commit
  max44000: Initial support for proximity reading
  max44000: Support controlling LED current output
  max44000: Expose ambient sensor scaling
  max44000: Initial triggered buffer support

 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/max44000.c | 627 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 639 insertions(+)
 create mode 100644 drivers/iio/light/max44000.c

-- 
2.8.0.rc3
