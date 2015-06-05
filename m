Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59891 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932496AbbFELBg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 5 Jun 2015 07:01:36 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, pmeerw@pmeerw.net
Cc: daniel.baluta@intel.com, knaack.h@gmx.de, lars@metafoo.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v2 4/6] iio: magnetometer: mmc35240: Use a smaller sleep value
Date: Fri,  5 Jun 2015 14:03:13 +0300
Message-Id: <1433502195-30296-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
References: <1433502195-30296-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to datasheet, Page 8, minimum wait time to complete
measurement is 10ms. Adjusting this value will increase the
userspace polling rate.

Fixes: abeb6b1e7b ("iio: magnetometer: Add support for MEMSIC MMC35240")
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index 7fff38e..7bc72b3 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -219,7 +219,8 @@ static int mmc35240_take_measurement(struct mmc35240_data *data)
 			return ret;
 		if (reg_status & MMC35240_STATUS_MEAS_DONE_BIT)
 			break;
-		msleep(20);
+		/* minimum wait time to complete measurement is 10 ms */
+		usleep_range(10000, 11000);
 	}
 
 	if (tries < 0) {
-- 
1.9.1

