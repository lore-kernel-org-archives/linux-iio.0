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
Subject: [PATCH v3 0/5] Support for max44000 Ambient and Infrared Proximity Sensor
Date: Mon, 18 Apr 2016 17:31:52 +0300
Message-Id: <cover.1460989642.git.leonard.crestez@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Changes since v2:
* Drop reg_defaults from regmap_config
* Use REGCACHE_RBTREE
* Implement readable/writable/volatile reg with switches
* Use test_bit when checking the scan mask
* Add _INT_TIME info_mask in patch 4 rather than 2
* Cleaner spacing in max44000_remove

Changes since v1:
* Remove max44000_data.client
* Maintain alphabetical order in kconfig/makefile
* Avoid pointless inlines
* Remove explicit CONFIG_OF because no special handling is done
* Set storagebits = 16 for proximity channel and avoid VLAs
* Expand MAX44000_REGMASK for readability/reviewability
* Clear irq bits at the end of the probe function
* Only write important bits on probe rather than everything

Crestez Dan Leonard (5):
  max44000: Initial support
  max44000: Initial support for proximity reading
  max44000: Support controlling LED current output
  max44000: Expose ambient sensor scaling
  max44000: Initial triggered buffer support

 drivers/iio/light/Kconfig    |  11 +
 drivers/iio/light/Makefile   |   1 +
 drivers/iio/light/max44000.c | 637 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 649 insertions(+)
 create mode 100644 drivers/iio/light/max44000.c

-- 
2.5.5
