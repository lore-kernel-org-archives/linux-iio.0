Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33648 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751136AbdFYTPu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Jun 2017 15:15:50 -0400
Received: by mail-qk0-f196.google.com with SMTP id p21so12373840qke.0
        for <linux-iio@vger.kernel.org>; Sun, 25 Jun 2017 12:15:50 -0700 (PDT)
Message-ID: <1498418147.3882.10.camel@gmail.com>
Subject: [PATCH] staging: iio: ad7280a: add spaces around '-'
From: Reno Farnesi <nfarnesi4@gmail.com>
To: jic23@kernel.org
Cc: gregkh@linuxfoundation.org, linux-iio@vger.kernel.org
Date: Sun, 25 Jun 2017 15:15:47 -0400
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following checkpatch check to improve readability.

CHECK: spaces preferred around that '-' (ctx:VxV)

Signed-off-by: Reno Farnesi <nfarnesi4@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c
b/drivers/staging/iio/adc/ad7280a.c
index d5ab83f0236d..d79e7746d351 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -745,14 +745,14 @@ static irqreturn_t ad7280_event_handler(int irq,
void *private)
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_low_value,
-		in_voltage-voltage_thresh_low_value,
+		in_voltage - voltage_thresh_low_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
 		AD7280A_CELL_UNDERVOLTAGE);
 
 static IIO_DEVICE_ATTR_NAMED(in_thresh_high_value,
-		in_voltage-voltage_thresh_high_value,
+		in_voltage - voltage_thresh_high_value,
 		0644,
 		ad7280_read_channel_config,
 		ad7280_write_channel_config,
-- 
2.13.1

