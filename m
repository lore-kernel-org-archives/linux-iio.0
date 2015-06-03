Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:50007 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752047AbbFCIcH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 3 Jun 2015 04:32:07 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com, pmeerw@pmeerw.net, knaack.h@gmx.de,
	lars@metafoo.de, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 0/6] Memsic MMC35230 magnetometer fixes
Date: Wed,  3 Jun 2015 11:33:52 +0300
Message-Id: <1433320438-23870-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

First 5 patches are bugfixes or small enhancements found during
tests with a real platform.

The last patch adds compensation for raw values allowing proper
calibration for Android compass apps.

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

