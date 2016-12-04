Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:46896 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751990AbcLDCUU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:20 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 02/19] staging: iio: isl29028: remove enable flag from isl29028_enable_proximity()
Date: Sat,  3 Dec 2016 21:19:26 -0500
Message-Id: <1480817983-32359-3-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_enable_proximity() has a boolean argument named enable. This
function is only called once and the enable flag is set to true in that
call. This patch removes the enable parameter from that function.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 4e35d00..c8e234d 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -93,15 +93,13 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
 				  sel << ISL29028_CONF_PROX_SLP_SH);
 }
 
-static int isl29028_enable_proximity(struct isl29028_chip *chip, bool enable)
+static int isl29028_enable_proximity(struct isl29028_chip *chip)
 {
 	int ret;
-	int val = 0;
 
-	if (enable)
-		val = ISL29028_CONF_PROX_EN;
 	ret = regmap_update_bits(chip->regmap, ISL29028_REG_CONFIGURE,
-				 ISL29028_CONF_PROX_EN_MASK, val);
+				 ISL29028_CONF_PROX_EN_MASK,
+				 ISL29028_CONF_PROX_EN);
 	if (ret < 0)
 		return ret;
 
@@ -215,7 +213,7 @@ static int isl29028_proxim_get(struct isl29028_chip *chip, int *prox_data)
 	int ret;
 
 	if (!chip->enable_prox) {
-		ret = isl29028_enable_proximity(chip, true);
+		ret = isl29028_enable_proximity(chip);
 		if (ret < 0)
 			return ret;
 		chip->enable_prox = true;
-- 
2.7.4

