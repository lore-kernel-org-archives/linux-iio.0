Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
Cc: linux-kernel@vger.kernel.org,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 06/17] iio: accel: mma9551_core: typo fix in RSC APP ID
Date: Mon, 13 Apr 2015 18:40:53 +0300
Message-Id: <1428939664-12503-7-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fix typo in Reset/Suspend/Clear Application ID definition.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
Reported-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma9551_core.c | 2 +-
 drivers/iio/accel/mma9551_core.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
index efe09a3..2fd2a99 100644
--- a/drivers/iio/accel/mma9551_core.c
+++ b/drivers/iio/accel/mma9551_core.c
@@ -800,7 +800,7 @@ EXPORT_SYMBOL(mma9551_read_accel_scale);
  */
 int mma9551_app_reset(struct i2c_client *client, u32 app_mask)
 {
-	return mma9551_write_config_byte(client, MMA9551_APPID_RCS,
+	return mma9551_write_config_byte(client, MMA9551_APPID_RSC,
 					 MMA9551_RSC_RESET +
 					 MMA9551_RSC_OFFSET(app_mask),
 					 MMA9551_RSC_VAL(app_mask));
diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
index edaa56b..79939e4 100644
--- a/drivers/iio/accel/mma9551_core.h
+++ b/drivers/iio/accel/mma9551_core.h
@@ -22,7 +22,7 @@
 #define MMA9551_APPID_TILT		0x0B
 #define MMA9551_APPID_SLEEP_WAKE	0x12
 #define MMA9551_APPID_PEDOMETER	        0x15
-#define MMA9551_APPID_RCS		0x17
+#define MMA9551_APPID_RSC		0x17
 #define MMA9551_APPID_NONE		0xff
 
 /* Reset/Suspend/Clear application app masks */
-- 
1.9.1
