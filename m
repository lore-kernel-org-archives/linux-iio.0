Return-Path: <sst@poczta.fm>
From: Slawomir Stepien <sst@poczta.fm>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH 07/10] iio: common: ms_sensors: use tab for indention
Date: Thu, 14 Apr 2016 21:36:39 +0200
Message-Id: <1460662602-2951-8-git-send-email-sst@poczta.fm>
In-Reply-To: <1460662602-2951-1-git-send-email-sst@poczta.fm>
References: <1460662602-2951-1-git-send-email-sst@poczta.fm>
List-ID: <linux-iio@vger.kernel.org>

This fixes the error reported by checkpatch.pl:

ERROR: code indent should use tabs where possible

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/iio/common/ms_sensors/ms_sensors_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
index 669dc7c..ecf7721 100644
--- a/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
+++ b/drivers/iio/common/ms_sensors/ms_sensors_i2c.c
@@ -106,7 +106,7 @@ int ms_sensors_convert_and_read(void *cli, u8 conv, u8 rd,
 				unsigned int delay, u32 *adc)
 {
 	int ret;
-        __be32 buf = 0;
+	__be32 buf = 0;
 	struct i2c_client *client = (struct i2c_client *)cli;
 
 	/* Trigger conversion */
-- 
2.8.0
