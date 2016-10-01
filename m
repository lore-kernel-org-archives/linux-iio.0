Return-Path: <ico@pruts.nl>
From: Ico Doornekamp <ico@pruts.nl>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Ico Doornekamp <ico@pruts.nl>
Subject: [PATCH] iio: magnetometer: ak8974: small endianness fixes
Date: Sat,  1 Oct 2016 19:30:14 +0200
Message-Id: <20161001173014.16059-1-ico@pruts.nl>
List-ID: <linux-iio@vger.kernel.org>

Fixes two cases of 'cast to restricted __le16' as reported by sparse.

Signed-off-by: Ico Doornekamp <ico@pruts.nl>
---
 drivers/iio/magnetometer/ak8974.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index 2173531..ce09d77 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -287,7 +287,7 @@ static int ak8974_await_drdy(struct ak8974 *ak8974)
 	return 0;
 }
 
-static int ak8974_getresult(struct ak8974 *ak8974, s16 *result)
+static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
 {
 	unsigned int src;
 	int ret;
@@ -395,7 +395,7 @@ static int ak8974_selftest(struct ak8974 *ak8974)
 static int ak8974_get_u16_val(struct ak8974 *ak8974, u8 reg, u16 *val)
 {
 	int ret;
-	u16 bulk;
+	__le16 bulk;
 
 	ret = regmap_bulk_read(ak8974->map, reg, &bulk, 2);
 	if (ret)
@@ -453,7 +453,7 @@ static int ak8974_read_raw(struct iio_dev *indio_dev,
 			   long mask)
 {
 	struct ak8974 *ak8974 = iio_priv(indio_dev);
-	s16 hw_values[3];
+	__le16 hw_values[3];
 	int ret = -EINVAL;
 
 	pm_runtime_get_sync(&ak8974->i2c->dev);
@@ -494,7 +494,7 @@ static void ak8974_fill_buffer(struct iio_dev *indio_dev)
 {
 	struct ak8974 *ak8974 = iio_priv(indio_dev);
 	int ret;
-	s16 hw_values[8]; /* Three axes + 64bit padding */
+	__le16 hw_values[8]; /* Three axes + 64bit padding */
 
 	pm_runtime_get_sync(&ak8974->i2c->dev);
 	mutex_lock(&ak8974->lock);
-- 
2.9.3
