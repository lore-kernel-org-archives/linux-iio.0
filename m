Return-Path: <teodora.baluta@intel.com>
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	daniel.baluta@intel.com,
	teodora.baluta@intel.com,
	dan.carpenter@oracle.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: magnetometer: minor style change and add support for new chip
Date: Mon, 20 Jul 2015 16:52:28 +0300
Message-Id: <1437400350-25960-1-git-send-email-teodora.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The first patch makes a minor style change in order to accomodate the
adding of the devices easier. The second patch adds support for mmc34160
magnetometer.

---
Changes since v1:
- split the patch at [0] in 2
- rebased on top of fixes at [1]
- reword description in Kconfig

[0] https://lkml.org/lkml/2015/6/29/171
[1] https://lkml.org/lkml/2015/7/14/439

Teodora Baluta (2):
  iio: mmc35240: minor change to improve code readibility
  iio: magnetometer: add mmc34160 magnetometer driver

 drivers/iio/magnetometer/Kconfig    |   4 +-
 drivers/iio/magnetometer/mmc35240.c | 229 ++++++++++++++++++++++++++++--------
 2 files changed, 181 insertions(+), 52 deletions(-)

-- 
1.9.1
