Return-Path: <stufever@gmail.com>
From: stufever@gmail.com
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org,
	gregkh@suse.de,
	jic23@cam.ac.uk,
	Wang Shaoyan <wangshaoyan.pt@taobao.com>
Subject: [PATCH] staging: IIO: DAC: Delete useless label error_ret in ade7854.c
Date: Sun,  7 Aug 2011 02:24:24 +0800
Message-Id: <1312655064-28311-1-git-send-email-wangshaoyan.pt@taobao.com>
List-ID: <linux-iio@vger.kernel.org>

From: Wang Shaoyan <wangshaoyan.pt@taobao.com>

  drivers/staging/iio/meter/ade7854.c: In function 'ade7854_probe':
  drivers/staging/iio/meter/ade7854.c:585: warning: label 'error_ret' defined but not used

The label error_ret is defined, but never used, so delete it to avoid annoying warning.

Signed-off-by: Wang Shaoyan <wangshaoyan.pt@taobao.com>
---
 drivers/staging/iio/meter/ade7854.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index b82659f..ac3f9d5 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -582,7 +582,6 @@ error_unreg_dev:
 	iio_device_unregister(indio_dev);
 error_free_dev:
 	iio_free_device(indio_dev);
-error_ret:
 	return ret;
 }
 EXPORT_SYMBOL(ade7854_probe);
-- 
1.7.0.4
