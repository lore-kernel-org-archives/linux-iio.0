Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:5400 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbbGaO2L (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 31 Jul 2015 10:28:11 -0400
From: Teodora Baluta <teodora.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	daniel.baluta@intel.com, teodora.baluta@intel.com,
	dan.carpenter@oracle.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: magnetometer: minor style change and add support for new chip
Date: Fri, 31 Jul 2015 17:27:23 +0300
Message-Id: <1438352845-11540-1-git-send-email-teodora.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The first patch makes a minor style change in order to accomodate the
adding of the devices easier. The second patch adds support for mmc34160
magnetometer.

---
Changes since v2:
- remove unneeded switch

Changes since v1:
- split the patch at [0] in 2
- rebased on top of fixes at [1]
- reword description in Kconfig

[0] https://lkml.org/lkml/2015/6/29/171
[1] https://lkml.org/lkml/2015/7/14/439

Teodora Baluta (2):
  iio: mmc35240: minor change to improve code readibility
  iio: magnetometer: add mmc34160 magnetometer driver

 drivers/iio/magnetometer/Kconfig    |   5 +-
 drivers/iio/magnetometer/mmc35240.c | 213 +++++++++++++++++++++++++++---------
 2 files changed, 166 insertions(+), 52 deletions(-)

-- 
1.9.1

