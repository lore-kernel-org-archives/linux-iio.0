Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38638 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbeIBRsA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Sep 2018 13:48:00 -0400
From: Tomasz Duszynski <tduszyns@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: light: bh1750: simplify setting PM ops
Date: Sun,  2 Sep 2018 15:29:23 +0200
Message-Id: <20180902132923.13513-1-tduszyns@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Relying on CONFIG_PM_SLEEP to set PM ops is not necessary
since core will handle everything internally. One have to only make sure
that functions that can go unused are marked with __maybe_unused.

Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
---
 drivers/iio/light/bh1750.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/bh1750.c b/drivers/iio/light/bh1750.c
index 493ca7420602..c3a481452b67 100644
--- a/drivers/iio/light/bh1750.c
+++ b/drivers/iio/light/bh1750.c
@@ -278,8 +278,7 @@ static int bh1750_remove(struct i2c_client *client)
 	return 0;
 }

-#ifdef CONFIG_PM_SLEEP
-static int bh1750_suspend(struct device *dev)
+static int __maybe_unused bh1750_suspend(struct device *dev)
 {
 	int ret;
 	struct bh1750_data *data =
@@ -297,10 +296,6 @@ static int bh1750_suspend(struct device *dev)
 }

 static SIMPLE_DEV_PM_OPS(bh1750_pm_ops, bh1750_suspend, NULL);
-#define BH1750_PM_OPS (&bh1750_pm_ops)
-#else
-#define BH1750_PM_OPS NULL
-#endif

 static const struct i2c_device_id bh1750_id[] = {
 	{ "bh1710", BH1710 },
@@ -315,7 +310,7 @@ MODULE_DEVICE_TABLE(i2c, bh1750_id);
 static struct i2c_driver bh1750_driver = {
 	.driver = {
 		.name = "bh1750",
-		.pm = BH1750_PM_OPS,
+		.pm = &bh1750_pm_ops,
 	},
 	.probe = bh1750_probe,
 	.remove = bh1750_remove,
--
2.18.0
