Return-Path: <MAILER-DAEMON>
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v2 3/4] iio:magnetometer: st_magn: add BDU settings
Date: Thu, 25 Oct 2018 19:38:11 -0700
Message-Id: <20181026023812.29720-3-martin@martingkelly.com>
In-Reply-To: <20181026023812.29720-1-martin@martingkelly.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
List-ID: <linux-iio@vger.kernel.org>

From: Martin Kelly <martin@martingkelly.com>

LIS3MDL and LSM9DS1 are missing BDU settings in their register maps, so add
them. I don't have a LIS3MDL sensor to test, but this works correctly on
the LSM9DS1, which has the same register map.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/magnetometer/st_magn_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index a186b844d664..370b93db528d 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -316,6 +316,10 @@ static const struct st_sensor_settings st_magn_sensors_settings[] = {
 				},
 			},
 		},
+		.bdu = {
+			.addr = 0x24,
+			.mask = 0x40,
+		},
 		.drdy_irq = {
 			/* drdy line is routed drdy pin */
 			.stat_drdy = {
-- 
2.11.0
