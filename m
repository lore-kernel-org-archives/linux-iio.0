Return-Path: <SRS0=omKU=ED=redhat.com=lorenzo.bianconi@kernel.org>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 4/4] iio: humidity: hts221: remove unnecessary get_unaligned_le16()
Date: Mon,  8 Jan 2018 23:12:31 +0100
Message-Id: <20180108221231.13283-5-lorenzo.bianconi@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

Remove unnecessary unaligned access routine in hts221_read_oneshot() and
the related include

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/humidity/hts221_core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index fb74a22ef3f5..166946d4978d 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -14,7 +14,6 @@
 #include <linux/iio/sysfs.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <asm/unaligned.h>
 #include <linux/regmap.h>
 #include <linux/bitfield.h>
 
@@ -406,7 +405,7 @@ static int hts221_get_sensor_offset(struct hts221_hw *hw,
 
 static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
 {
-	u8 data[HTS221_DATA_SIZE];
+	__le16 data;
 	int err;
 
 	err = hts221_set_enable(hw, true);
@@ -415,13 +414,13 @@ static int hts221_read_oneshot(struct hts221_hw *hw, u8 addr, int *val)
 
 	msleep(50);
 
-	err = regmap_bulk_read(hw->regmap, addr, data, sizeof(data));
+	err = regmap_bulk_read(hw->regmap, addr, &data, sizeof(data));
 	if (err < 0)
 		return err;
 
 	hts221_set_enable(hw, false);
 
-	*val = (s16)get_unaligned_le16(data);
+	*val = (s16)le16_to_cpu(data);
 
 	return IIO_VAL_INT;
 }
-- 
2.15.1
