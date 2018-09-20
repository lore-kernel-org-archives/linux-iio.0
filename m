Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41502 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITTd1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Sep 2018 15:33:27 -0400
From: Song Qiang <songqiang1304521@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, shubhrajyoti@ti.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] iio: magnetometer: hmc5843: Fixed a comment error.
Date: Thu, 20 Sep 2018 21:49:46 +0800
Message-Id: <20180920134946.9072-1-songqiang1304521@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace 'hcm5843' with 'hmc5843'.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/hmc5843.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 76a5d7484d8d..a75224cf99df 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -31,7 +31,7 @@ enum hmc5843_ids {
 };
 
 /**
- * struct hcm5843_data	- device specific data
+ * struct hmc5843_data	- device specific data
  * @dev:		actual device
  * @lock:		update and read regmap data
  * @regmap:		hardware access register maps
-- 
2.17.1
