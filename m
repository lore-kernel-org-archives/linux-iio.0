Return-Path: <teodora.baluta@intel.com>
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	teodora.baluta@intel.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iio: accel: add support for Memsic MXC4005
Date: Thu, 13 Aug 2015 20:31:38 +0300
Message-Id: <1439487101-13085-1-git-send-email-teodora.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds support for Memsic MXC4005XC 3-axis accelerometer
sensor. The first patch adds basic support for the accelerometer, with
raw readings, the second patch adds support for buffer mode and the last
one adds the data ready trigger.

---
Changes since v1:
- fixes for the comments (coding style, proper buffer length,
  available_scan_masks)
- remove unnecessary locking for regmap operations since regmap has an
  internal locking mechanism
- keep the mutex for set_trigger_state operation to protect the state
  variable trigger_enabled

Teodora Baluta (3):
  iio: accel: add support for mxc4005 accelerometer
  iio: mxc4005: add triggered buffer mode for mxc4005
  iio: mxc4005: add data ready trigger for mxc4005

 drivers/iio/accel/Kconfig   |  13 +
 drivers/iio/accel/Makefile  |   2 +
 drivers/iio/accel/mxc4005.c | 586 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 601 insertions(+)
 create mode 100644 drivers/iio/accel/mxc4005.c

-- 
1.9.1
