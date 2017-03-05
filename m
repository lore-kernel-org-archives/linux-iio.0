Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35135 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbdCEQhD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Mar 2017 11:37:03 -0500
Received: by mail-wm0-f65.google.com with SMTP id z63so8023959wmg.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Mar 2017 08:37:02 -0800 (PST)
From: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: outreachy-kernel@googlegroups.com, linux-iio@vger.kernel.org,
        Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
Subject: [PATCH 2/2] staging: iio: adis16240: Group similar macros into enums
Date: Sun,  5 Mar 2017 18:26:54 +0200
Message-Id: <0124358fa11efba9989ed7a7158e5fbcb63df835.1488730643.git.narcisaanamaria12@gmail.com>
In-Reply-To: <cover.1488730643.git.narcisaanamaria12@gmail.com>
References: <cover.1488730643.git.narcisaanamaria12@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Group the scan indexes into an enum.

Signed-off-by: Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index 9690e46..4d8ee37 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -192,12 +192,14 @@
  * filling. This may change!
  */
 
-#define ADIS16240_SCAN_ACC_X	0
-#define ADIS16240_SCAN_ACC_Y	1
-#define ADIS16240_SCAN_ACC_Z	2
-#define ADIS16240_SCAN_SUPPLY	3
-#define ADIS16240_SCAN_AUX_ADC	4
-#define ADIS16240_SCAN_TEMP	5
+enum adis16240_scan {
+	ADIS16240_SCAN_ACC_X,
+	ADIS16240_SCAN_ACC_Y,
+	ADIS16240_SCAN_ACC_Z,
+	ADIS16240_SCAN_SUPPLY,
+	ADIS16240_SCAN_AUX_ADC,
+	ADIS16240_SCAN_TEMP,
+};
 
 static ssize_t adis16240_spi_read_signed(struct device *dev,
 					 struct device_attribute *attr,
-- 
1.9.1

