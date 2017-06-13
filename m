Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f53.google.com ([74.125.83.53]:32941 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751758AbdFMPwb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 13 Jun 2017 11:52:31 -0400
Received: by mail-pg0-f53.google.com with SMTP id f185so62558346pgc.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Jun 2017 08:52:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: jic23@kernel.org, pmeerw@pmeerw.net, robh+dt@kernel.org,
        william.markezana@meas-spec.com, ludovic.tancerel@maplehightech.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] iio: temperature: tsys01: Add OF match table
Date: Tue, 13 Jun 2017 21:22:22 +0530
Message-Id: <1497369142-32473-1-git-send-email-manivannan.sadhasivam@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add of_match_table for Measurement Specialties TSYS01 temperature sensor

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/iio/temperature/tsys01.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 3e60c61..d8aa211 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -214,11 +214,18 @@ static const struct i2c_device_id tsys01_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, tsys01_id);
 
+static const struct of_device_id tsys01_of_match[] = {
+	{ .compatible = "meas,tsys01", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, tsys01_of_match);
+
 static struct i2c_driver tsys01_driver = {
 	.probe = tsys01_i2c_probe,
 	.id_table = tsys01_id,
 	.driver = {
 		   .name = "tsys01",
+		   .of_match_table = of_match_ptr(tsys01_of_match),
 		   },
 };
 
-- 
2.7.4

