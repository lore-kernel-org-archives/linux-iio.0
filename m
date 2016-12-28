Return-Path: <SRS0=KeG3=YL=gmail.com=akinobu.mita@kernel.org>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: [PATCH] iio: max44000: correct value in illuminance_integration_time_available
Date: Thu, 29 Dec 2016 02:16:36 +0900
Message-Id: <1482945396-18604-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

According to the datasheet, the shortest available integration time for
ALS ADC conversion is 1.5625ms but illuminance_integration_time_available
sysfs file shows wrong value.

Cc: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 drivers/iio/light/max44000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/max44000.c b/drivers/iio/light/max44000.c
index a144ca3..81bd8e8 100644
--- a/drivers/iio/light/max44000.c
+++ b/drivers/iio/light/max44000.c
@@ -113,7 +113,7 @@ static const char max44000_int_time_avail_str[] =
 	"0.100 "
 	"0.025 "
 	"0.00625 "
-	"0.001625";
+	"0.0015625";
 
 /* Available scales (internal to ulux) with pretty manual alignment: */
 static const int max44000_scale_avail_ulux_array[] = {
-- 
2.7.4
