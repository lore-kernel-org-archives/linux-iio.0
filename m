Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36298 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757168AbeAHWMt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Jan 2018 17:12:49 -0500
Received: by mail-wr0-f193.google.com with SMTP id b76so12284589wrd.3
        for <linux-iio@vger.kernel.org>; Mon, 08 Jan 2018 14:12:49 -0800 (PST)
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v3 1/4] iio: humidity: hts221: remove warnings in hts221_parse_{temp,rh}_caldata()
Date: Mon,  8 Jan 2018 23:12:28 +0100
Message-Id: <20180108221231.13283-2-lorenzo.bianconi@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove following sparse warnings in hts221_parse_temp_caldata() and in
hts221_parse_rh_caldata():
drivers/iio/humidity/hts221_core.c:302:19: warning: cast to
restricted __le16
drivers/iio/humidity/hts221_core.c:314:18: warning: cast to
restricted __le16
drivers/iio/humidity/hts221_core.c:320:18: warning: cast to
restricted __le16
drivers/iio/humidity/hts221_core.c:355:18: warning: cast to
restricted __le16
drivers/iio/humidity/hts221_core.c:361:18: warning: cast to
restricted __le16

Fixes: e4a70e3e7d84 ("iio: humidity: add support to hts221 rh/temp combo
device")

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
---
 drivers/iio/humidity/hts221_core.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index d3f7904766bd..b662afb2b35c 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -289,6 +289,7 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 	int err, *slope, *b_gen;
 	s16 cal_x0, cal_x1, cal_y0, cal_y1;
 	u8 cal0, cal1;
+	__le16 val;
 
 	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_Y_H,
 			   sizeof(cal0), &cal0);
@@ -299,7 +300,7 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 			   sizeof(cal1), &cal1);
 	if (err < 0)
 		return err;
-	cal_y0 = (le16_to_cpu(cal1 & 0x3) << 8) | cal0;
+	cal_y0 = ((cal1 & 0x3) << 8) | cal0;
 
 	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_Y_H,
 			   sizeof(cal0), &cal0);
@@ -307,17 +308,17 @@ static int hts221_parse_temp_caldata(struct hts221_hw *hw)
 		return err;
 	cal_y1 = (((cal1 & 0xc) >> 2) << 8) | cal0;
 
-	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_X_L, sizeof(cal_x0),
-			   (u8 *)&cal_x0);
+	err = hw->tf->read(hw->dev, HTS221_REG_0T_CAL_X_L, sizeof(val),
+			   (u8 *)&val);
 	if (err < 0)
 		return err;
-	cal_x0 = le16_to_cpu(cal_x0);
+	cal_x0 = le16_to_cpu(val);
 
-	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_X_L, sizeof(cal_x1),
-			   (u8 *)&cal_x1);
+	err = hw->tf->read(hw->dev, HTS221_REG_1T_CAL_X_L, sizeof(val),
+			   (u8 *)&val);
 	if (err < 0)
 		return err;
-	cal_x1 = le16_to_cpu(cal_x1);
+	cal_x1 = le16_to_cpu(val);
 
 	slope = &hw->sensors[HTS221_SENSOR_T].slope;
 	b_gen = &hw->sensors[HTS221_SENSOR_T].b_gen;
@@ -334,6 +335,7 @@ static int hts221_parse_rh_caldata(struct hts221_hw *hw)
 {
 	int err, *slope, *b_gen;
 	s16 cal_x0, cal_x1, cal_y0, cal_y1;
+	__le16 val;
 	u8 data;
 
 	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_Y_H, sizeof(data),
@@ -348,17 +350,17 @@ static int hts221_parse_rh_caldata(struct hts221_hw *hw)
 		return err;
 	cal_y1 = data;
 
-	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_X_H, sizeof(cal_x0),
-			   (u8 *)&cal_x0);
+	err = hw->tf->read(hw->dev, HTS221_REG_0RH_CAL_X_H, sizeof(val),
+			   (u8 *)&val);
 	if (err < 0)
 		return err;
-	cal_x0 = le16_to_cpu(cal_x0);
+	cal_x0 = le16_to_cpu(val);
 
-	err = hw->tf->read(hw->dev, HTS221_REG_1RH_CAL_X_H, sizeof(cal_x1),
-			   (u8 *)&cal_x1);
+	err = hw->tf->read(hw->dev, HTS221_REG_1RH_CAL_X_H, sizeof(val),
+			   (u8 *)&val);
 	if (err < 0)
 		return err;
-	cal_x1 = le16_to_cpu(cal_x1);
+	cal_x1 = le16_to_cpu(val);
 
 	slope = &hw->sensors[HTS221_SENSOR_H].slope;
 	b_gen = &hw->sensors[HTS221_SENSOR_H].b_gen;
-- 
2.15.1

