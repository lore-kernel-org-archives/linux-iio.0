Return-Path: <daniel.baluta@intel.com>
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: daniel.baluta@intel.com,
	viorel.suman@intel.com,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] iio: magnetometer: mmc35240: fix SET/RESET sequence
Date: Tue, 14 Jul 2015 17:56:54 +0300
Message-Id: <1436885814-29155-4-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

From: Viorel Suman <viorel.suman@intel.com>

The RESET operation invoked in the last instance will align
in the natural way all 3 axis and the chip top view.

Signed-off-by: Viorel Suman <viorel.suman@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index f4d7495..a53efd2 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -215,14 +215,15 @@ static int mmc35240_init(struct mmc35240_data *data)
 
 	/*
 	 * make sure we restore sensor characteristics, by doing
-	 * a RESET/SET sequence
+	 * a SET/RESET sequence, the axis polarity being naturally
+	 * aligned after RESET
 	 */
-	ret = mmc35240_hw_set(data, false);
+	ret = mmc35240_hw_set(data, true);
 	if (ret < 0)
 		return ret;
 	usleep_range(MMC53240_WAIT_SET_RESET, MMC53240_WAIT_SET_RESET + 1);
 
-	ret = mmc35240_hw_set(data, true);
+	ret = mmc35240_hw_set(data, false);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.1
