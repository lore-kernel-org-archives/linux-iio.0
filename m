Return-Path: <MAILER-DAEMON>
From: Martin Kelly <martin@martingkelly.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	Denis Ciocca <denis.ciocca@st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Martin Kelly <martin@martingkelly.com>
Subject: [PATCH v2 1/4] iio: magnetometer: add clarifying comment
Date: Thu, 25 Oct 2018 19:38:09 -0700
Message-Id: <20181026023812.29720-1-martin@martingkelly.com>
List-ID: <linux-iio@vger.kernel.org>

From: Martin Kelly <martin@martingkelly.com>

Add a comment clarifying better when to use <device_name> vs
<device_name>-magn in compatibility strings.

Signed-off-by: Martin Kelly <martin@martingkelly.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
index 7b7cd08fcc32..15bb09267098 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -23,6 +23,8 @@
  * For new single-chip sensors use <device_name> as compatible string.
  * For old single-chip devices keep <device_name>-magn to maintain
  * compatibility
+ * For multi-chip devices, use <device_name>-magn to distinguish which
+ * capability is being used
  */
 static const struct of_device_id st_magn_of_match[] = {
 	{
-- 
2.11.0
