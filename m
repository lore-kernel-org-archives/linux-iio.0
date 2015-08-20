Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21261 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752881AbbHTOht (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 20 Aug 2015 10:37:49 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, teodora.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: accel: add support for Memsic MXC4005
Date: Thu, 20 Aug 2015 17:37:30 +0300
Message-Id: <1440081453-12600-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

Changes since v2:
 - use the MXC4005_REGMAP_NAME for regmap_config instead of REGMAP_DRV_NAME
 - replace struct i2c_client *client with struct device *dev
 - remove redundant REGCACHE_NONE option from regmap_config
 - other small style fixes
 - fix buffer size
 - remove read interrupt source register
 - remove the thread handler since we only have one interrupt
 - make irq->client > 0 since IRQ 0 is not valid
 - rework the irq handler by adding try_to_reenable callback
 - use iio_pollfunc_store_time for timestamps


Teodora Baluta (3):
  iio: accel: add support for mxc4005 accelerometer
  iio: mxc4005: add triggered buffer mode for mxc4005
  iio: mxc4005: add data ready trigger for mxc4005

 drivers/iio/accel/Kconfig   |  13 +
 drivers/iio/accel/Makefile  |   2 +
 drivers/iio/accel/mxc4005.c | 567 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 582 insertions(+)
 create mode 100644 drivers/iio/accel/mxc4005.c

-- 
1.9.1

