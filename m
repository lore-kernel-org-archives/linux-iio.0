Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:14880 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752346AbcD2LnM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 29 Apr 2016 07:43:12 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 2/3] iio: bmi160: Fix ODR setting
Date: Fri, 29 Apr 2016 14:42:34 +0300
Message-Id: <1461930155-13871-3-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
References: <1461930155-13871-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

mask and val parameters of regmap_update_bits were reveresed.

Fixes: 77c4ad2d6a9 ("iio: imu: Add initial support for Bosch BMI160")
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/bmi160/bmi160_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index cd9b75e..b8a290e 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -364,8 +364,8 @@ int bmi160_set_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
 
 	return regmap_update_bits(data->regmap,
 				  bmi160_regs[t].config,
-				  bmi160_odr_table[t].tbl[i].bits,
-				  bmi160_regs[t].config_odr_mask);
+				  bmi160_regs[t].config_odr_mask,
+				  bmi160_odr_table[t].tbl[i].bits);
 }
 
 static int bmi160_get_odr(struct bmi160_data *data, enum bmi160_sensor_type t,
-- 
2.5.0

