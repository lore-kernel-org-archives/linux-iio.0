Return-Path: <elfring@users.sourceforge.net>
Subject: [PATCH] iio: qcom-spmi-vadc: One check less in
 vadc_measure_ref_points() after error detection
References: <566ABCD9.1060404@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Julia Lawall <julia.lawall@lip6.fr>
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <567E9059.30709@users.sourceforge.net>
Date: Sat, 26 Dec 2015 14:04:25 +0100
MIME-Version: 1.0
In-Reply-To: <566ABCD9.1060404@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 26 Dec 2015 13:53:15 +0100

This issue was detected by using the Coccinelle software.

Move the jump label directly before the desired log statement
so that the variable "ret" does not need to be checked once more
after it was determined that a function call failed.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index c2babe5..391eefa 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -424,7 +424,7 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	prop = vadc_get_channel(vadc, VADC_REF_1250MV);
 	ret = vadc_do_conversion(vadc, prop, &read_1);
 	if (ret)
-		goto err;
+		goto report_failure;
 
 	/* Try with buffered 625mV channel first */
 	prop = vadc_get_channel(vadc, VADC_SPARE1);
@@ -433,11 +433,11 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 
 	ret = vadc_do_conversion(vadc, prop, &read_2);
 	if (ret)
-		goto err;
+		goto report_failure;
 
 	if (read_1 == read_2) {
 		ret = -EINVAL;
-		goto err;
+		goto report_failure;
 	}
 
 	vadc->graph[VADC_CALIB_ABSOLUTE].dy = read_1 - read_2;
@@ -447,23 +447,24 @@ static int vadc_measure_ref_points(struct vadc_priv *vadc)
 	prop = vadc_get_channel(vadc, VADC_VDD_VADC);
 	ret = vadc_do_conversion(vadc, prop, &read_1);
 	if (ret)
-		goto err;
+		goto report_failure;
 
 	prop = vadc_get_channel(vadc, VADC_GND_REF);
 	ret = vadc_do_conversion(vadc, prop, &read_2);
 	if (ret)
-		goto err;
+		goto report_failure;
 
 	if (read_1 == read_2) {
 		ret = -EINVAL;
-		goto err;
+		goto report_failure;
 	}
 
 	vadc->graph[VADC_CALIB_RATIOMETRIC].dy = read_1 - read_2;
 	vadc->graph[VADC_CALIB_RATIOMETRIC].gnd = read_2;
-err:
-	if (ret)
+	if (ret) {
+report_failure:
 		dev_err(vadc->dev, "measure reference points failed\n");
+	}
 
 	return ret;
 }
-- 
2.6.3
