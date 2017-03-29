Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33733 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932353AbdC2MdU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:33:20 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 1/4] iio: common: st_sensors: Replace ternary operator with min macro
Date: Wed, 29 Mar 2017 18:03:08 +0530
Message-Id: <1490790791-5694-2-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use macro min() to get the minimum of two values for brevity and
readability.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/common/st_sensors/st_sensors_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_i2c.c b/drivers/iio/common/st_sensors/st_sensors_i2c.c
index c83df4d..7a68fdd 100644
--- a/drivers/iio/common/st_sensors/st_sensors_i2c.c
+++ b/drivers/iio/common/st_sensors/st_sensors_i2c.c
@@ -39,7 +39,7 @@ static int st_sensors_i2c_read_byte(struct st_sensor_transfer_buffer *tb,
 	*res_byte = err & 0xff;
 
 st_accel_i2c_read_byte_error:
-	return err < 0 ? err : 0;
+	return min(err, 0);
 }
 
 static int st_sensors_i2c_read_multiple_byte(
-- 
2.7.4

