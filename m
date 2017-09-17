Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37589 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751391AbdIQPUw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2017 11:20:52 -0400
Received: by mail-wr0-f194.google.com with SMTP id u48so3755386wrf.4
        for <linux-iio@vger.kernel.org>; Sun, 17 Sep 2017 08:20:52 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 1/3] iio: gyro: st_gyro: add SPI-3wire support to st_gyro framework
Date: Sun, 17 Sep 2017 17:20:45 +0200
Message-Id: <20170917152047.12631-2-lorenzo.bianconi@st.com>
In-Reply-To: <20170917152047.12631-1-lorenzo.bianconi@st.com>
References: <20170917152047.12631-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add SPI Serial Interface Mode (SIM) register information
to STM gyroscope framework

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/gyro/st_gyro_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/iio/gyro/st_gyro_core.c b/drivers/iio/gyro/st_gyro_core.c
index 46991f7131d1..b31064ba37b9 100644
--- a/drivers/iio/gyro/st_gyro_core.c
+++ b/drivers/iio/gyro/st_gyro_core.c
@@ -125,6 +125,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 				.mask = 0x07,
 			},
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -200,6 +204,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 				.mask = 0x07,
 			},
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -270,6 +278,10 @@ static const struct st_sensor_settings st_gyro_sensors_settings[] = {
 				.mask = 0x07,
 			},
 		},
+		.sim = {
+			.addr = 0x23,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
-- 
2.14.1

