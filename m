Return-Path: <SRS0=63t4=5S=electromag.com.au=preid@kernel.org>
From: Phil Reid <preid@electromag.com.au>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
  preid@electromag.com.au, linux-iio@vger.kernel.org
Subject: [PATCH 1/1] iio: buffer-dma: Add missing header buffer_impl.h
Date: Tue, 13 Jun 2017 10:31:36 +0800
Message-Id: <1497321096-77903-1-git-send-email-preid@electromag.com.au>
List-ID: <linux-iio@vger.kernel.org>

Add buffer_impl.h as buffer.h was split into interface for using and
for internals. Without this industrialio-buffer-dma.c fails
to compile.

Fixes:
commit 33dd94cb972175249258329c4aaffddcc82c2005 ("iio:buffer.h - split
into buffer.h and buffer_impl.h")

Signed-off-by: Phil Reid <preid@electromag.com.au>
---
 drivers/iio/buffer/industrialio-buffer-dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dma.c b/drivers/iio/buffer/industrialio-buffer-dma.c
index dd99d27..ff03324 100644
--- a/drivers/iio/buffer/industrialio-buffer-dma.c
+++ b/drivers/iio/buffer/industrialio-buffer-dma.c
@@ -14,6 +14,7 @@
 #include <linux/sched.h>
 #include <linux/poll.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
 #include <linux/dma-mapping.h>
 #include <linux/sizes.h>
-- 
1.8.3.1
