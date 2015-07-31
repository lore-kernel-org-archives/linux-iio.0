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
Subject: [PATCH 0/3] iio: accel: add support for Memsic MXC4005
Date: Fri, 31 Jul 2015 18:25:37 +0300
Message-Id: <1438356340-13306-1-git-send-email-teodora.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This patch set adds support for Memsic MXC4005XC 3-axis accelerometer
sensor. The first patch adds basic support for the accelerometer, with
raw readings, the second patch adds support for buffer mode and the last
one adds the data ready trigger.

Teodora Baluta (3):
  iio: accel: add support for mxc4005 accelerometer
  iio: mxc4005: add triggered buffer mode for mxc4005
  iio: mxc4005: add data ready trigger for mxc4005

 drivers/iio/accel/Kconfig   |  13 +
 drivers/iio/accel/Makefile  |   2 +
 drivers/iio/accel/mxc4005.c | 601 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 616 insertions(+)
 create mode 100644 drivers/iio/accel/mxc4005.c

-- 
1.9.1
