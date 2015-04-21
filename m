Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:13925 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755527AbbDUQJJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Apr 2015 12:09:09 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com, jic23@kernel.org
Cc: pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, daniel.baluta@intel.com
Subject: [PATCH v8 0/2] Add support for LTR-301 and LTR-559 sensors
Date: Tue, 21 Apr 2015 19:10:58 +0300
Message-Id: <1429632660-8716-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patchset adds support for LiteOn LTR301 ambient light sensor
and LTR559 ambient light and proximity sensor.

I will just leave this here if Sathya needs to push support for LTR-301.
Minimal tested. I will be back in few days with more testing.

v8:

1. Rebased on the latest linux-iio testing branch.

v7:
1. Rebase LTR-301 on top of LTR-559 and merged the patches into a single patchset
2. Moved ltr501_chip_info_tbl below ltr501_info in patch 1 in order
to make patch 2 changes look natural. :)
3. Moved "else" branch of id check from patch 2 to patch 1. Now it is no
longer possible to have a NULL name after this check. If id is not NULL
than id->name is one of ltr501_id already defined strings.

v6:
1. Changed the title in commit log

v5:
1. Rebased this patch on top of Daniel's LTR559 patchset
   (http://marc.info/?l=linux-kernel&m=142779827617036&w=2)
2. Added info and channel members to chip_info struture.

v4:
1. Addressed minor comments from Peter Meerwald
2. Changed invalid chip id errno from ENOSYS to ENODEV
3. Fixed channel id index number
4. Removed unused variable.

v3:
1. Sent v2 before by mistake. So sending the final version of v2 as v3.

v2:
1. Handled device id NULL case in probe
2. Changed pr_warn to dev_warn

v1:
Extended LTR501 driver to support both LTR301 and LTR501 device.

Daniel Baluta (2):
  iio: ltr501: Add support for ltr559 chip
  iio: ltr501: Add support for ltr301 chip

 drivers/iio/light/Kconfig  |   3 +-
 drivers/iio/light/ltr501.c | 290 +++++++++++++++++++++++++++++++++++++++------
 2 files changed, 256 insertions(+), 37 deletions(-)

-- 
1.9.1

