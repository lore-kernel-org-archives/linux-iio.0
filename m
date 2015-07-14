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
Subject: [PATCH 2/3] iio: magnetometer: mmc35240: Fix SET/RESET mask
Date: Tue, 14 Jul 2015 17:56:53 +0300
Message-Id: <1436885814-29155-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
References: <1436885814-29155-1-git-send-email-daniel.baluta@intel.com>
List-ID: <linux-iio@vger.kernel.org>

This fixes setting the SET/RESET bit in the REG_CTRL0
register.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/magnetometer/mmc35240.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
index e89b059..f4d7495 100644
--- a/drivers/iio/magnetometer/mmc35240.c
+++ b/drivers/iio/magnetometer/mmc35240.c
@@ -195,8 +195,8 @@ static int mmc35240_hw_set(struct mmc35240_data *data, bool set)
 		coil_bit = MMC35240_CTRL0_RESET_BIT;
 
 	return regmap_update_bits(data->regmap, MMC35240_REG_CTRL0,
-				  MMC35240_CTRL0_REFILL_BIT,
-				  coil_bit);
+				  coil_bit, coil_bit);
+
 }
 
 static int mmc35240_init(struct mmc35240_data *data)
-- 
1.9.1
