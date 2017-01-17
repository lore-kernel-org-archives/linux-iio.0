Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49336 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751441AbdAQJnW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:43:22 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 13/15] staging: iio: isl29028: only set proximity sampling rate when proximity is enabled
Date: Tue, 17 Jan 2017 04:25:00 -0500
Message-Id: <20170117092502.6951-14-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_chip_init_and_power_on() calls isl29028_set_proxim_sampling()
and this is not needed until the user actually needs to take a proximity
reading. This patch moves the isl29028_set_proxim_sampling() call from
isl29028_chip_init_and_power_on() to isl29028_enable_proximity().
This sets the stage for faster resume times from the runtime power
management if the user is only querying the ALS/IR sensor.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index f1b3651..fa58d08 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -107,6 +107,10 @@ static int isl29028_enable_proximity(struct isl29028_chip *chip)
 {
 	int ret;
 
+	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
+	if (ret < 0)
+		return ret;
+
 	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
 				 ISL29028_CONF_PROX_EN_MASK,
 				 ISL29028_CONF_PROX_EN);
@@ -449,10 +453,6 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
 		return ret;
 	}
 
-	ret = isl29028_set_proxim_sampling(chip, chip->prox_sampling);
-	if (ret < 0)
-		return ret;
-
 	return isl29028_set_als_scale(chip, chip->lux_scale);
 }
 
-- 
2.9.3

