Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42156 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbeHJVqN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Aug 2018 17:46:13 -0400
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: max517: avoid using CONFIG_PM_SLEEP
Date: Fri, 10 Aug 2018 20:51:08 +0200
Message-Id: <20180810185110.12710-1-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SIMPLE_DEV_PM_OPS() is already doing this.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/iio/dac/max517.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 1d853247a205..451d10e323cf 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -113,15 +113,14 @@ static int max517_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max517_suspend(struct device *dev)
+static int __maybe_unused max517_suspend(struct device *dev)
 {
 	u8 outbuf = COMMAND_PD;
 
 	return i2c_master_send(to_i2c_client(dev), &outbuf, 1);
 }
 
-static int max517_resume(struct device *dev)
+static int __maybe_unused max517_resume(struct device *dev)
 {
 	u8 outbuf = 0;
 
@@ -129,10 +128,6 @@ static int max517_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(max517_pm_ops, max517_suspend, max517_resume);
-#define MAX517_PM_OPS (&max517_pm_ops)
-#else
-#define MAX517_PM_OPS NULL
-#endif
 
 static const struct iio_info max517_info = {
 	.read_raw = max517_read_raw,
@@ -229,7 +224,7 @@ MODULE_DEVICE_TABLE(i2c, max517_id);
 static struct i2c_driver max517_driver = {
 	.driver = {
 		.name	= MAX517_DRV_NAME,
-		.pm		= MAX517_PM_OPS,
+		.pm	= &max517_pm_ops,
 	},
 	.probe		= max517_probe,
 	.remove		= max517_remove,
-- 
2.11.0.rc2
