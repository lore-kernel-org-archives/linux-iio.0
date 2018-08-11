Return-Path: <SRS0=fQkM=K2=gmail.com=marcus.folkesson@kernel.org>
From: Marcus Folkesson <marcus.folkesson@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] iio: dac: max517: avoid using CONFIG_PM_SLEEP
Date: Sat, 11 Aug 2018 10:47:09 +0200
Message-Id: <20180811084709.6640-1-marcus.folkesson@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This is already handled by SIMPLE_DEV_PM_OPS().

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
Somehow git-send-email messed up (?!) the format for (at least) gmail, so resend it.
Mutt still read the mail correct though.

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
