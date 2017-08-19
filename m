Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38511 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbdHSSr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Aug 2017 14:47:56 -0400
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH 3/3] iio: light: tsl2583: constify i2c_device_id
Date: Sun, 20 Aug 2017 00:17:38 +0530
Message-Id: <1503168458-17676-4-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503168458-17676-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

i2c_device_id are not supposed to change at runtime. All functions
working with i2c_device_id provided by <linux/i2c.h> work with
const i2c_device_id. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index 1679181..fb711ed 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -924,7 +924,7 @@ static const struct dev_pm_ops tsl2583_pm_ops = {
 	SET_RUNTIME_PM_OPS(tsl2583_suspend, tsl2583_resume, NULL)
 };
 
-static struct i2c_device_id tsl2583_idtable[] = {
+static const struct i2c_device_id tsl2583_idtable[] = {
 	{ "tsl2580", 0 },
 	{ "tsl2581", 1 },
 	{ "tsl2583", 2 },
-- 
2.7.4

