Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:41638 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754948AbcGELzz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 5 Jul 2016 07:55:55 -0400
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, knaack.h@gmx.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH 9/9] staging: iio: isl29028: Prefix functions
Date: Tue,  5 Jul 2016 13:55:44 +0200
Message-Id: <1467719744-19450-10-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
References: <1467719744-19450-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
---
 drivers/staging/iio/light/isl29028.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 7358c3b..a238b16 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -462,7 +462,7 @@ static int isl29028_chip_init(struct isl29028_chip *chip)
 	return ret;
 }
 
-static bool is_volatile_reg(struct device *dev, unsigned int reg)
+static bool isl29028_is_volatile_reg(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
 	case ISL29028_REG_INTERRUPT:
@@ -478,7 +478,7 @@ static bool is_volatile_reg(struct device *dev, unsigned int reg)
 static const struct regmap_config isl29028_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
-	.volatile_reg = is_volatile_reg,
+	.volatile_reg = isl29028_is_volatile_reg,
 	.max_register = ISL29028_NUM_REGS - 1,
 	.num_reg_defaults_raw = ISL29028_NUM_REGS,
 	.cache_type = REGCACHE_RBTREE,
-- 
1.7.10.4

