Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751968AbbFELB1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 07:01:27 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 0/6] Memsic MMC35230 magnetometer fixes
Date: Fri,  5 Jun 2015 14:03:09 +0300
Message-Id: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First 5 patches are bugfixes or small enhancements found during
tests with a real platform.

The last patch adds compensation for raw values allowing proper
calibration for Android compass apps.

Changes since v1:
	* fixed nits reported by Peter
		* few whitespaces and spelling erorrs
		* added MMC35240_ prefix to some macro's
	
Daniel Baluta (6):
  iio: magnetometer: mmc35240: i2c device name should be lower case
  iio: magnetometer: mmc35240: NULL terminate attribute array
  iio: magnetometer: mmc35240: Fix broken processed value
  iio: magnetometer: mmc35240: Use a smaller sleep value
  iio: magnetometer: mmc35240: Fix sensitivity on z-axis
  iio: magnetometer: mmc35240: Add compensation for raw values

 drivers/iio/magnetometer/mmc35240.c | 113 ++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 23 deletions(-)

-- 
1.9.1

