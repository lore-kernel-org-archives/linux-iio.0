Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36721 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753860AbcAJGUJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jan 2016 01:20:09 -0500
Date: Sun, 10 Jan 2016 11:50:18 +0530
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	bhaktipriya96@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: cdc: Prefer using the BIT macro
Message-ID: <20160110062018.GA22031@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace all occurences of (1<<x) by BIT(x) in the file ad7150.c to get rid
of checkpatch.pl "CHECK" output "Prefer using the BIT macro"

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
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

