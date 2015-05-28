Return-Path: <marek.belisko@gmail.com>
Sender: Belisko Marek <marek.belisko@gmail.com>
From: Marek Belisko <marek@goldelico.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hns@goldelico.com,
	Marek Belisko <marek@goldelico.com>
Subject: [PATCH 1/2] iio: adc: twl4030_madc: Fix calculation of the temperature sense current
Date: Thu, 28 May 2015 21:50:18 +0200
Message-Id: <1432842619-7251-1-git-send-email-marek@goldelico.com>
List-ID: <linux-iio@vger.kernel.org>

From: "H. Nikolaus Schaller" <hns@goldelico.com>

The bit mask to read the setting of the constant current source
for measuring the NTC voltage was the wrong one. Since default
value is initialized to the lowest level (000 = 10uA) the difference
was probably never noticed in practice.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/iio/adc/twl4030-madc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 94c5f05..6d2d429 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -235,7 +235,7 @@ static int twl4030battery_temperature(int raw_volt)
 	if (ret < 0)
 		return ret;
 
-	curr = ((val & TWL4030_BCI_ITHEN) + 1) * 10;
+	curr = ((val & TWL4030_BCI_ITHSENS) + 1) * 10;
 	/* Getting and calculating the thermistor resistance in ohms */
 	res = volt * 1000 / curr;
 	/* calculating temperature */
-- 
1.9.1
