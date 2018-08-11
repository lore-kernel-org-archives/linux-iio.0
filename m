Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35669 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbeHKLom (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Aug 2018 07:44:42 -0400
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] iio: dac: max5821: avoid using CONFIG_PM_SLEEP
Date: Sat, 11 Aug 2018 10:47:18 +0200
Message-Id: <20180811084718.6697-1-marcus.folkesson@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is already handled by SIMPLE_DEV_PM_OPS().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
Mutt still read the mail correct though.

 drivers/iio/dac/max5821.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index d0ecc1fdd8fc..f0cf6903dcd2 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -270,8 +270,7 @@ static int max5821_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-static int max5821_suspend(struct device *dev)
+static int __maybe_unused max5821_suspend(struct device *dev)
 {
 	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
 			 MAX5821_EXTENDED_DAC_A |
@@ -281,7 +280,7 @@ static int max5821_suspend(struct device *dev)
 	return i2c_master_send(to_i2c_client(dev), outbuf, 2);
 }
 
-static int max5821_resume(struct device *dev)
+static int __maybe_unused max5821_resume(struct device *dev)
 {
 	u8 outbuf[2] = { MAX5821_EXTENDED_COMMAND_MODE,
 			 MAX5821_EXTENDED_DAC_A |
@@ -292,10 +291,6 @@ static int max5821_resume(struct device *dev)
 }
 
 static SIMPLE_DEV_PM_OPS(max5821_pm_ops, max5821_suspend, max5821_resume);
-#define MAX5821_PM_OPS (&max5821_pm_ops)
-#else
-#define MAX5821_PM_OPS NULL
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct iio_info max5821_info = {
 	.read_raw = max5821_read_raw,
@@ -392,7 +387,7 @@ static struct i2c_driver max5821_driver = {
 	.driver = {
 		.name	= "max5821",
 		.of_match_table = max5821_of_match,
-		.pm     = MAX5821_PM_OPS,
+		.pm     = &max5821_pm_ops,
 	},
 	.probe		= max5821_probe,
 	.remove		= max5821_remove,
-- 
2.11.0.rc2
