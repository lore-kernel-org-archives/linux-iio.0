Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33921 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdCEQ14 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 11:27:56 -0500
Received: by mail-wm0-f67.google.com with SMTP id u132so2167347wmg.1
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 08:26:49 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH 1/2] staging: iio: adis16209: Group similar macros into enums
Date: Sun,  5 Mar 2017 18:26:41 +0200
Message-Id: <50dc46612578fa9cf84d1b8243c86dbf0aace3a4.1488730643.git.narcisaanamaria12@gmail.com>
In-Reply-To: <cover.1488730643.git.narcisaanamaria12@gmail.com>
References: <cover.1488730643.git.narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Group the scan indexes into an enum.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 8ff537f..c28a099 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -152,14 +152,16 @@
 
 #define ADIS16209_ERROR_ACTIVE          BIT(14)
 
-#define ADIS16209_SCAN_SUPPLY	0
-#define ADIS16209_SCAN_ACC_X	1
-#define ADIS16209_SCAN_ACC_Y	2
-#define ADIS16209_SCAN_AUX_ADC	3
-#define ADIS16209_SCAN_TEMP	4
-#define ADIS16209_SCAN_INCLI_X	5
-#define ADIS16209_SCAN_INCLI_Y	6
-#define ADIS16209_SCAN_ROT	7
+enum adis16209_scan {
+	ADIS16209_SCAN_SUPPLY,
+	ADIS16209_SCAN_ACC_X,
+	ADIS16209_SCAN_ACC_Y,
+	ADIS16209_SCAN_AUX_ADC,
+	ADIS16209_SCAN_TEMP,
+	ADIS16209_SCAN_INCLI_X,
+	ADIS16209_SCAN_INCLI_Y,
+	ADIS16209_SCAN_ROT,
+};
 
 static const u8 adis16209_addresses[8][1] = {
 	[ADIS16209_SCAN_SUPPLY] = { },
-- 
1.9.1

