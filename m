Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 6/6] iio: sx9500: fix formatting
Date: Fri,  3 Apr 2015 15:47:34 +0300
Message-Id: <1428065254-6444-7-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
References: <1428065254-6444-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 9738df1..2156037 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -1014,7 +1014,7 @@ MODULE_DEVICE_TABLE(acpi, sx9500_acpi_match);
 
 static const struct i2c_device_id sx9500_id[] = {
 	{"sx9500", 0},
-	{}
+	{ },
 };
 MODULE_DEVICE_TABLE(i2c, sx9500_id);
 
-- 
1.9.1
