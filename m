Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750714AbeALHjk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 12 Jan 2018 02:39:40 -0500
From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
To: <lars@metafoo.de>, <pmeerw@pmeerw.net>, <linux-iio@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <arnd@arndb.de>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH] iio: accel: use strlcpy() instead of strncpy()
Date: Fri, 12 Jan 2018 15:45:38 +0800
Message-ID: <1515743138-94480-1-git-send-email-wangxiongfeng2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Xiongfeng Wang <xiongfeng.wang@linaro.org>

gcc-8 reports

drivers/iio/accel/st_accel_i2c.c: In function 'st_accel_i2c_probe':
./include/linux/string.h:245:9: warning: '__builtin_strncpy' specified
bound 20 equals destination size [-Wstringop-truncation]

The compiler require that the length of the dest string is greater than
the length we want to copy to make sure the dest string is
nul-terminated. We can just use strlcpy() to avoid this warning.

Signed-off-by: Xiongfeng Wang <xiongfeng.wang@linaro.org>
---
 drivers/iio/accel/st_accel_i2c.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
index 363429b..6bdec8c 100644
--- a/drivers/iio/accel/st_accel_i2c.c
+++ b/drivers/iio/accel/st_accel_i2c.c
@@ -159,9 +159,8 @@ static int st_accel_i2c_probe(struct i2c_client *client,
 		if ((ret < 0) || (ret >= ST_ACCEL_MAX))
 			return -ENODEV;
 
-		strncpy(client->name, st_accel_id_table[ret].name,
+		strlcpy(client->name, st_accel_id_table[ret].name,
 				sizeof(client->name));
-		client->name[sizeof(client->name) - 1] = '\0';
 	} else if (!id)
 		return -ENODEV;
 
-- 
1.8.3.1

