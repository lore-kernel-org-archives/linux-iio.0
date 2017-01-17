Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49338 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdAQJnW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:43:22 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 12/15] staging: iio: isl29028: remove enable flag from isl29028_enable_proximity()
Date: Tue, 17 Jan 2017 04:24:59 -0500
Message-Id: <20170117092502.6951-13-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_enable_proximity() has a boolean argument named enable. This
function is only called once and the enable flag is set to true in that
call. This patch removes the enable parameter from that function.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
The device gets runtime power management support in the next patch in
this set and autosuspends after two seconds of inactivity. Once the
device suspends, the pin that drives the external LED for proximity
sensing will only go high the next time that the user asks for a
reading from the proximity sensor.

This patch also sets the stage for additional cleanups prior to the
introduction of runtime power management support.

 drivers/staging/iio/light/isl29028.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index bc9c01d..f1b3651 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -103,15 +103,13 @@ static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
 	return ret;
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
 
@@ -225,7 +223,7 @@ static int isl29028_read_proxim(struct isl29028_chip *chip, int *prox)
 	int ret;
 
 	if (!chip->enable_prox) {
-		ret = isl29028_enable_proximity(chip, true);
+		ret = isl29028_enable_proximity(chip);
 		if (ret < 0)
 			return ret;
 
-- 
2.9.3

