Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33273 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932545AbdC2MdX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:33:23 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 2/4] iio: imu: st_lsm6dsx: Replace ternary operator with min macro
Date: Wed, 29 Mar 2017 18:03:09 +0530
Message-Id: <1490790791-5694-3-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use macro min() to get the minimum of two values for brevity and
readability.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/humidity/hts221_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/humidity/hts221_core.c b/drivers/iio/humidity/hts221_core.c
index 3f3ef4a1..f98240a 100644
--- a/drivers/iio/humidity/hts221_core.c
+++ b/drivers/iio/humidity/hts221_core.c
@@ -206,7 +206,7 @@ int hts221_config_drdy(struct hts221_hw *hw, bool enable)
 	err = hts221_write_with_mask(hw, HTS221_REG_CNTRL3_ADDR,
 				     HTS221_DRDY_MASK, val);
 
-	return err < 0 ? err : 0;
+	return min(err, 0);
 }
 
 static int hts221_update_odr(struct hts221_hw *hw, u8 odr)
-- 
2.7.4

