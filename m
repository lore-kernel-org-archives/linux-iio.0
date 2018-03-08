Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40453 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbeCHJrd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 8 Mar 2018 04:47:33 -0500
Received: by mail-wm0-f67.google.com with SMTP id t6so9834820wmt.5
        for <linux-iio@vger.kernel.org>; Thu, 08 Mar 2018 01:47:33 -0800 (PST)
Date: Thu, 8 Mar 2018 10:47:29 +0100
From: David Veenstra <davidjulianveenstra@gmail.com>
To: lars@metafoo.de
Cc: linux-iio@vger.kernel.org
Subject: [PATCH] Staging: iio: adt7316: Move symbol export to definition
Message-ID: <20180308094729.GA11441@zenbook-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch clears the following checkpatch.pl warning:

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
+EXPORT_SYMBOL_GPL(adt7316_pm_ops);

Signed-off-by: David Veenstra <davidjulianveenstra@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 2d33632c00e8..3f22d1088713 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2079,9 +2079,8 @@ static int adt7316_enable(struct device *dev)
 
 	return _adt7316_store_enabled(chip, 1);
 }
-
-SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
 EXPORT_SYMBOL_GPL(adt7316_pm_ops);
+SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);
 #endif
 
 static const struct iio_info adt7316_info = {
-- 
2.16.2

