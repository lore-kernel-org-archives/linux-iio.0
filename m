Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH] iio: pressure: bmp280: fix temp compensation
Date: Wed,  8 Apr 2015 18:26:12 +0300
Message-Id: <1428506772-23710-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Temperature reads on bmp280 device always return 0,
due to a missing step in the compensation formula
(data->tfine is never initialized).

Initialize data->tfine value so we get correct
temperature and pressure values.

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/pressure/bmp280.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/pressure/bmp280.c b/drivers/iio/pressure/bmp280.c
index 7c623e2..a2602d8 100644
--- a/drivers/iio/pressure/bmp280.c
+++ b/drivers/iio/pressure/bmp280.c
@@ -172,6 +172,7 @@ static s32 bmp280_compensate_temp(struct bmp280_data *data,
 	var2 = (((((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1]))) *
 		  ((adc_temp >> 4) - ((s32)le16_to_cpu(buf[T1])))) >> 12) *
 		((s32)(s16)le16_to_cpu(buf[T3]))) >> 14;
+	data->t_fine = var1 + var2;
 
 	return (data->t_fine * 5 + 128) >> 8;
 }
-- 
1.9.1
