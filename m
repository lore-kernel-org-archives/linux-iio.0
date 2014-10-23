Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH] bmp280: use correct routine for division
Date: Thu, 23 Oct 2014 16:08:16 +0300
Message-Id: <1414069696-15439-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

The proper way to divide two signed 64-bit values is to use div4_s64.

Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/pressure/bmp280.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index fb91cb3..ce29ff9 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -239,7 +239,7 @@ static u32 bmp280_compensate_press(struct bmp280_data *data,
 		return 0;
 
 	p = ((((s64) 1048576 - adc_press) << 31) - var2) * 3125;
-	do_div(p, var1);
+	p = div64_s64(p, var1);
 	var1 = (((s64) comp->dig_p9) * (p >> 13) * (p >> 13)) >> 25;
 	var2 = (((s64) comp->dig_p8) * p) >> 19;
 	p = ((p + var1 + var2) >> 8) + (((s64) comp->dig_p7) << 4);
-- 
1.9.1
