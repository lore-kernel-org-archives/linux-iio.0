Return-Path: <SRS0=r0Dv=BZ=users.sourceforge.net=elfring@kernel.org>
To: linux-iio@vger.kernel.org, Alison Schofield <amsfield22@gmail.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, Hartmut Knaack
 <knaack.h@gmx.de>, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/adc/palmas: Use common error handling code in
 palmas_gpadc_calibrate()
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Message-ID: <0ae3662d-6a74-622c-0423-e8552ea79bca@users.sourceforge.net>
Date: Thu, 26 Oct 2017 08:08:49 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Oct 2017 07:58:03 +0200

* Add a jump target so that a specific error message is stored only once
  at the end of this function implementation.

* Adjust condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/adc/palmas_gpadc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 69b9affeef1e..5e6566692d46 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -304,17 +304,13 @@ static int palmas_gpadc_calibrate(struct palmas_gpadc *adc, int adc_chan)
 
 	ret = palmas_read(adc->palmas, PALMAS_TRIM_GPADC_BASE,
 				adc->adc_info[adc_chan].trim1_reg, &d1);
-	if (ret < 0) {
-		dev_err(adc->dev, "TRIM read failed: %d\n", ret);
-		goto scrub;
-	}
+	if (ret)
+		goto report_failure;
 
 	ret = palmas_read(adc->palmas, PALMAS_TRIM_GPADC_BASE,
 				adc->adc_info[adc_chan].trim2_reg, &d2);
-	if (ret < 0) {
-		dev_err(adc->dev, "TRIM read failed: %d\n", ret);
-		goto scrub;
-	}
+	if (ret)
+		goto report_failure;
 
 	/* gain error calculation */
 	k = (1000 + (1000 * (d2 - d1)) / (x2 - x1));
@@ -329,6 +325,10 @@ static int palmas_gpadc_calibrate(struct palmas_gpadc *adc, int adc_chan)
 
 scrub:
 	return ret;
+
+report_failure:
+	dev_err(adc->dev, "TRIM read failed: %d\n", ret);
+	goto scrub;
 }
 
 static int palmas_gpadc_start_conversion(struct palmas_gpadc *adc, int adc_chan)
-- 
2.14.3
