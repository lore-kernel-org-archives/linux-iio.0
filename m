Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35166 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932545AbdC2Mdh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:33:37 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 3/4] iio: imu: st_lsm6dsx: Replace ternary operator with min macro
Date: Wed, 29 Mar 2017 18:03:10 +0530
Message-Id: <1490790791-5694-4-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use macro min() to get the minimum of two values for brevity and
readability.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index e959825..e11653d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -203,7 +203,7 @@ int st_lsm6dsx_update_watermark(struct st_lsm6dsx_sensor *sensor, u16 watermark)
 out:
 	mutex_unlock(&hw->lock);
 
-	return err < 0 ? err : 0;
+	return min(err, 0);
 }
 
 /**
-- 
2.7.4

