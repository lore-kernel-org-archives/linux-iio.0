Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2641 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932695AbbDKA7s (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Apr 2015 20:59:48 -0400
From: Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v6 0/1] LTR301 ALS support
Date: Fri, 10 Apr 2015 17:59:49 -0700
Message-Id: <cover.1428713872.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Following patch adds support for Liteon 301 Ambient light sensor.

Please let me know your review comments.

v1:
Extended LTR501 driver to support both LTR301 and LTR501 device.

v2:
1. Handled device id NULL case in probe
2. Changed pr_warn to dev_warn

v3:
1. Sent v2 before by mistake. So sending the final version of v2 as v3.

v4:
1. Addressed minor comments from Peter Meerwald
2. Changed invalid chip id errno from ENOSYS to ENODEV
3. Fixed channel id index number
4. Removed unused variable.

v5:
1. Rebased this patch on top of Daniel's LTR559 patchset
   (http://marc.info/?l=linux-kernel&m=142779827617036&w=2)
2. Added info and channel members to chip_info struture.

v6:
1. Changed the title in commit log

Kuppuswamy Sathyanarayanan (1):
  iio: ltr501: Add support for ltr301

 drivers/iio/light/Kconfig  |  2 +-
 drivers/iio/light/ltr501.c | 99 +++++++++++++++++++++++++++++++++-------------
 2 files changed, 72 insertions(+), 29 deletions(-)

-- 
1.9.1

