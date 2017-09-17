Return-Path: <SRS0=/wsa=AS=gmail.com=lorenzo.bianconi83@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH 3/3] iio: pressure: st_pressure: add SPI-3wire support to st_pressure framework
Date: Sun, 17 Sep 2017 17:20:47 +0200
Message-Id: <20170917152047.12631-4-lorenzo.bianconi@st.com>
In-Reply-To: <20170917152047.12631-1-lorenzo.bianconi@st.com>
References: <20170917152047.12631-1-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Add SPI Serial Interface Mode (SIM) register information
to STM pressure framework

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/pressure/st_pressure_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
index b8890e37a2d2..15ad6054d9f6 100644
--- a/drivers/iio/pressure/st_pressure_core.c
+++ b/drivers/iio/pressure/st_pressure_core.c
@@ -297,6 +297,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 				.mask = 0x03,
 			},
 		},
+		.sim = {
+			.addr = 0x20,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -343,6 +347,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 			.addr = 0x20,
 			.mask = 0x04,
 		},
+		.sim = {
+			.addr = 0x20,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -406,6 +414,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 				.mask = 0x03,
 			},
 		},
+		.sim = {
+			.addr = 0x20,
+			.value = BIT(0),
+		},
 		.multi_read_bit = true,
 		.bootime = 2,
 	},
@@ -471,6 +483,10 @@ static const struct st_sensor_settings st_press_sensors_settings[] = {
 				.mask = 0x03,
 			},
 		},
+		.sim = {
+			.addr = 0x10,
+			.value = BIT(0),
+		},
 		.multi_read_bit = false,
 		.bootime = 2,
 	},
-- 
2.14.1
