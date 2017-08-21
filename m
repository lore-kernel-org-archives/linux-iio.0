Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37333 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754033AbdHUQoB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2017 12:44:01 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: arnd@arndb.de, gregkh@linuxfoundation.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, lars@metafoo.de
Cc: linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-iio@vger.kernel.org
Subject: [PATCH 4/4] staging: iio: tsl2x7x: constify i2c_device_id
Date: Mon, 21 Aug 2017 22:13:51 +0530
Message-Id: <1503333831-26300-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/staging/iio/light/tsl2x7x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 1467199..9b4425d 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -2010,7 +2010,7 @@ static int tsl2x7x_remove(struct i2c_client *client)
 	return 0;
 }
 
-static struct i2c_device_id tsl2x7x_idtable[] = {
+static const struct i2c_device_id tsl2x7x_idtable[] = {
 	{ "tsl2571", tsl2571 },
 	{ "tsl2671", tsl2671 },
 	{ "tmd2671", tmd2671 },
-- 
2.7.4

