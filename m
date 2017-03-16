Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:37596 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751818AbdCPNDD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 09:03:03 -0400
From: Miguel Robles <miguel.robles@farole.net>
To: jic23@kernel.org, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, Miguel Robles <miguel.robles@farole.net>
Subject: [PATCH] Staging: iio: cdc: use octal permissions instead of symbolic
Date: Thu, 16 Mar 2017 14:02:19 +0100
Message-Id: <1489669339-6412-1-git-send-email-miguel.robles@farole.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix checkpatch warnings:
Symbolic permissions 'S_IWUSR' are not preferred.

Signed-off-by: Miguel Robles <miguel.robles@farole.net>
---
 drivers/staging/iio/cdc/ad7746.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 81f8b9e..6c688bd 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -351,15 +351,15 @@ static ssize_t ad7746_start_gain_calib(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR(in_capacitance0_calibbias_calibration,
-		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN1);
+		       0200, NULL, ad7746_start_offset_calib, CIN1);
 static IIO_DEVICE_ATTR(in_capacitance1_calibbias_calibration,
-		       S_IWUSR, NULL, ad7746_start_offset_calib, CIN2);
+		       0200, NULL, ad7746_start_offset_calib, CIN2);
 static IIO_DEVICE_ATTR(in_capacitance0_calibscale_calibration,
-		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN1);
+		       0200, NULL, ad7746_start_gain_calib, CIN1);
 static IIO_DEVICE_ATTR(in_capacitance1_calibscale_calibration,
-		       S_IWUSR, NULL, ad7746_start_gain_calib, CIN2);
+		       0200, NULL, ad7746_start_gain_calib, CIN2);
 static IIO_DEVICE_ATTR(in_voltage0_calibscale_calibration,
-		       S_IWUSR, NULL, ad7746_start_gain_calib, VIN);
+		       0200, NULL, ad7746_start_gain_calib, VIN);
 
 static int ad7746_store_cap_filter_rate_setup(struct ad7746_chip_info *chip,
 					      int val)
-- 
2.7.4

