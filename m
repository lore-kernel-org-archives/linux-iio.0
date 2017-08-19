Return-Path: <SRS0=Az8E=7V=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/3] iio: accel: bma180: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:17:36 +0530
Message-Id: <1503168458-17676-2-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iio/accel/bma180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index efc6773..3dec972 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -842,7 +842,7 @@ static SIMPLE_DEV_PM_OPS(bma180_pm_ops, bma180_suspend, bma180_resume);
 #define BMA180_PM_OPS NULL
 #endif
 
-static struct i2c_device_id bma180_ids[] = {
+static const struct i2c_device_id bma180_ids[] = {
 	{ "bma180", BMA180 },
 	{ "bma250", BMA250 },
 	{ }
-- 
2.7.4
