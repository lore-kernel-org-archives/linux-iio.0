Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38606 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751575AbdIQPUy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2017 11:20:54 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so6621502wmd.5
        for <linux-iio@vger.kernel.org>; Sun, 17 Sep 2017 08:20:53 -0700 (PDT)
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, lorenzo.bianconi@st.com
Subject: [PATCH 2/3] iio: magnetometer: st_magn: add SPI-3wire support to LIS3MDL
Date: Sun, 17 Sep 2017 17:20:46 +0200
Message-Id: <20170917152047.12631-3-lorenzo.bianconi@st.com>
In-Reply-To: <20170917152047.12631-1-lorenzo.bianconi@st.com>
References: <20170917152047.12631-1-lorenzo.bianconi@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add SPI Serial Interface Mode (SIM) register information to
LIS3MDL magn sensor

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index 8745686f233c..72f6d1335a04 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -322,6 +322,10 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 				.mask = 0x07,
 			},
 		},
+		.sim = {
+			.addr = 0x22,
+			.value = BIT(2),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
-- 
2.14.1

