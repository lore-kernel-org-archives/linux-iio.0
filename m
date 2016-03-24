Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Markus Pargmann <mpa@pengutronix.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] iio: accel: bmc150: remove unused definition
Date: Thu, 24 Mar 2016 11:00:55 +0200
Message-Id: <1458810056-24236-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

bmc150_i2c_regmap_conf is defined in bmc150-accel-core.c, but
never used here. The definition is needed in bmc150-accel-i2c.c,
where it is again defined.

Remove the unnecessary definition of bmc150_i2c_regmap_conf from
bmc150-accel-core.c and update the one from bmc150-accel-i2c.c
to contain all fields.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 6 ------
 drivers/iio/accel/bmc150-accel-i2c.c  | 1 +
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index c73331f7..feff894 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -246,12 +246,6 @@ static const struct {
 				       {500000, BMC150_ACCEL_SLEEP_500_MS},
 				       {1000000, BMC150_ACCEL_SLEEP_1_SEC} };
 
-static const struct regmap_config bmc150_i2c_regmap_conf = {
-	.reg_bits = 8,
-	.val_bits = 8,
-	.max_register = 0x3f,
-};
-
 static int bmc150_accel_set_mode(struct bmc150_accel_data *data,
 				 enum bmc150_power_modes mode,
 				 int dur_us)
diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index b41404b..f0969fe 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -31,6 +31,7 @@
 static const struct regmap_config bmc150_i2c_regmap_conf = {
 	.reg_bits = 8,
 	.val_bits = 8,
+	.max_register = 0x3f,
 };
 
 static int bmc150_accel_probe(struct i2c_client *client,
-- 
1.9.1
