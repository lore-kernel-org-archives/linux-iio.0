Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:50470 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751027AbdJZIAr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 04:00:47 -0400
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] iio/light/gp2ap020a00f: Use common error handling code in
 gp2ap020a00f_adjust_lux_mode()
Message-ID: <06da0424-1ec9-209e-a433-48288c49132b@users.sourceforge.net>
Date: Thu, 26 Oct 2017 10:00:21 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 26 Oct 2017 09:50:21 +0200

* Add jump targets so that two error messages are stored only once
  at the end of this function implementation.

* Adjust condition checks.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/light/gp2ap020a00f.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 44b13fbcd093..ae29bce660ac 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -741,19 +741,13 @@ static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
 		 */
 		err =  gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TH, false);
-		if (err < 0) {
-			dev_err(&data->client->dev,
-				"Clearing als threshold register failed.\n");
-			return false;
-		}
+		if (err)
+			goto report_clearing_failure;
 
 		err =  gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TL, false);
-		if (err < 0) {
-			dev_err(&data->client->dev,
-				"Clearing als threshold register failed.\n");
-			return false;
-		}
+		if (err)
+			goto report_clearing_failure;
 
 		/* Change lux mode */
 		err = regmap_update_bits(data->regmap,
@@ -793,27 +787,30 @@ static bool gp2ap020a00f_adjust_lux_mode(struct gp2ap020a00f_data *data,
 		if (test_bit(GP2AP020A00F_FLAG_ALS_RISING_EV, &data->flags)) {
 			err =  gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TH, true);
-			if (err < 0) {
-				dev_err(&data->client->dev,
-				"Adjusting als threshold value failed.\n");
-				return false;
-			}
+			if (err)
+				goto report_adjustment_failure;
 		}
 
 		if (test_bit(GP2AP020A00F_FLAG_ALS_FALLING_EV, &data->flags)) {
 			err =  gp2ap020a00f_write_event_threshold(data,
 					GP2AP020A00F_THRESH_TL, true);
-			if (err < 0) {
-				dev_err(&data->client->dev,
-				"Adjusting als threshold value failed.\n");
-				return false;
-			}
+			if (err)
+				goto report_adjustment_failure;
 		}
 
 		return true;
 	}
 
 	return false;
+
+report_clearing_failure:
+	dev_err(&data->client->dev,
+		"Clearing als threshold register failed.\n");
+	return false;
+
+report_adjustment_failure:
+	dev_err(&data->client->dev, "Adjusting als threshold value failed.\n");
+	return false;
 }
 
 static void gp2ap020a00f_output_to_lux(struct gp2ap020a00f_data *data,
-- 
2.14.3

