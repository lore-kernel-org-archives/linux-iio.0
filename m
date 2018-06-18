Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44100 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755003AbeFRP7Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 18 Jun 2018 11:59:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so9265710plk.11
        for <linux-iio@vger.kernel.org>; Mon, 18 Jun 2018 08:59:25 -0700 (PDT)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
        Eva Rachel Retuya <eraretuya@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v2 1/4] iio: accel: adxl345: add link to datasheet
Date: Tue, 19 Jun 2018 00:59:09 +0900
Message-Id: <1529337552-23726-2-git-send-email-akinobu.mita@gmail.com>
In-Reply-To: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
References: <1529337552-23726-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add a link to the ADXL345 datasheet

Cc: Eva Rachel Retuya <eraretuya@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v2
- No changes from v1

 drivers/iio/accel/adxl345_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 7251d0e..8e0d56b 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -6,6 +6,8 @@
  * This file is subject to the terms and conditions of version 2 of
  * the GNU General Public License. See the file COPYING in the main
  * directory of this archive for more details.
+ *
+ * Datasheet: http://www.analog.com/media/en/technical-documentation/data-sheets/ADXL345.pdf
  */
 
 #include <linux/module.h>
-- 
2.7.4

