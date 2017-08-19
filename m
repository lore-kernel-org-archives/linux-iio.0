Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34835 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751003AbdHSSrx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Aug 2017 14:47:53 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 2/3] iio: light: apds9300: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:17:37 +0530
Message-Id: <1503168458-17676-3-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iio/light/apds9300.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/apds9300.c b/drivers/iio/light/apds9300.c
index 649b26f..05eacd1 100644
--- a/drivers/iio/light/apds9300.c
+++ b/drivers/iio/light/apds9300.c
@@ -505,7 +505,7 @@ static SIMPLE_DEV_PM_OPS(apds9300_pm_ops, apds9300_suspend, apds9300_resume);
 #define APDS9300_PM_OPS NULL
 #endif
 
-static struct i2c_device_id apds9300_id[] = {
+static const struct i2c_device_id apds9300_id[] = {
 	{ APDS9300_DRV_NAME, 0 },
 	{ }
 };
-- 
2.7.4

