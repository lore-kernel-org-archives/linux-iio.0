Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:6077 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205AbaKQNRO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Nov 2014 08:17:14 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] kmx61: Small cleanups
Date: Mon, 17 Nov 2014 15:18:34 +0200
Message-Id: <1416230316-14511-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is a small cleanup patchset, that:
	* makes it clear that kmx61 uses only the micro part of scale
	* use macro instead of hardcoded value for driver name

Jonathan, if you think it's worth it, these could be squased together with
the initial patch submitted in testing:
	61ef04a496 (iio: imu: Add support for Kionix KMX61 sensor)

Daniel Baluta (2):
  kmx61: Use uscale instead of scale
  kmx61: Use KMX61_DRV_NAME instead of hardcoded value

 drivers/iio/imu/kmx61.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.9.1

