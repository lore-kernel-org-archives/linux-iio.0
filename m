Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34827 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbbL0FLq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Dec 2015 00:11:46 -0500
Received: by mail-pa0-f46.google.com with SMTP id jx14so150968881pad.2
        for <linux-iio@vger.kernel.org>; Sat, 26 Dec 2015 21:11:46 -0800 (PST)
From: Matt Ranostay <mranostay@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH] iio: chemical: vz89x: correct xfer return value
Date: Sat, 26 Dec 2015 21:11:30 -0800
Message-Id: <1451193090-3625-1-git-send-email-mranostay@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

vz89x_i2c_xfer() function was never returning a non-positive value on
error, and this patch corrects that with a -EIO return code.

Also the error condition was incorrect since it was against measurement
size and not the i2c messages send/received count.

Signed-off-by: Matt Ranostay <mranostay@gmail.com>
---
 drivers/iio/chemical/vz89x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index c3367aa..0666919 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -120,7 +120,7 @@ static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
 
 	ret = i2c_transfer(client->adapter, msg, 2);
 
-	return (ret == VZ89X_REG_MEASUREMENT_SIZE) ? 0 : ret;
+	return (ret == 2) ? 0 : -EIO;
 }
 
 static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
-- 
2.6.4

