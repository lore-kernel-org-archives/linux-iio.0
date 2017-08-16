Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35025 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752493AbdHPRC6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Aug 2017 13:02:58 -0400
Received: by mail-wr0-f193.google.com with SMTP id w63so4082767wrc.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Aug 2017 10:02:57 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, linus.walleij@linaro.org,
        lorenzo.bianconi@st.com
Subject: [PATCH 1/4] iio: magnetometer: st_magn: fix status register address for LSM303AGR
Date: Wed, 16 Aug 2017 19:02:50 +0200
Message-Id: <20170816170253.8382-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170816170253.8382-1-lorenzo.bianconi@st.com>
References: <20170816170253.8382-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes: 97865fe41322 (iio: st_sensors: verify interrupt event to status)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 3573636bad8e..039b0e94420a 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -358,7 +358,7 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 			.mask_int1 = 0x01,
 			.addr_ihl = 0x63,
 			.mask_ihl = 0x04,
-			.addr_stat_drdy = ST_SENSORS_DEFAULT_STAT_ADDR,
+			.addr_stat_drdy = 0x67,
 		},
 		.multi_read_bit = false,
 		.bootime = 2,
-- 
2.14.0

