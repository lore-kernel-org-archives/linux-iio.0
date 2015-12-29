Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35045 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464AbbL2Lqk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 29 Dec 2015 06:46:40 -0500
Received: by mail-pf0-f196.google.com with SMTP id e65so11460673pfe.2
        for <linux-iio@vger.kernel.org>; Tue, 29 Dec 2015 03:46:40 -0800 (PST)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 4/5] Staging: iio: cdc: ad7150: Prefer using the BIT macro
Date: Tue, 29 Dec 2015 16:57:30 +0530
Message-Id: <1451388451-10342-5-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
References: <1451388451-10342-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace bit shifting on 1 with the BIT(x) macro

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7150.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index e8d0ff2..0b934f7 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -21,8 +21,8 @@
  */
 
 #define AD7150_STATUS              0
-#define AD7150_STATUS_OUT1         (1 << 3)
-#define AD7150_STATUS_OUT2         (1 << 5)
+#define AD7150_STATUS_OUT1         BIT(3)
+#define AD7150_STATUS_OUT2         BIT(5)
 #define AD7150_CH1_DATA_HIGH       1
 #define AD7150_CH2_DATA_HIGH       3
 #define AD7150_CH1_AVG_HIGH        5
@@ -36,7 +36,7 @@
 #define AD7150_CH2_TIMEOUT         13
 #define AD7150_CH2_SETUP           14
 #define AD7150_CFG                 15
-#define AD7150_CFG_FIX             (1 << 7)
+#define AD7150_CFG_FIX             BIT(7)
 #define AD7150_PD_TIMER            16
 #define AD7150_CH1_CAPDAC          17
 #define AD7150_CH2_CAPDAC          18
-- 
2.1.4

