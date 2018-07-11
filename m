Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40714 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbeGKIfX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jul 2018 04:35:23 -0400
Received: by mail-wm0-f68.google.com with SMTP id z13-v6so1598930wma.5
        for <linux-iio@vger.kernel.org>; Wed, 11 Jul 2018 01:32:13 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
To: jramirez@baylibre.com, jic23@kernel.org,
        lorenzo.bianconi@redhat.com
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: imu: st_lsm6dsx: irq not handled unless data pushed to buffers
Date: Wed, 11 Jul 2018 10:32:08 +0200
Message-Id: <1531297928-3824-1-git-send-email-jramirez@baylibre.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Currently IRQ_NONE is returned only when there is no data on the fifo.

When there is no data on the fifo the driver can not push to the
buffers and therefore user space readers polling for data available
will not be awoken and continue to wait.

This commit just extends the same semantics to fifo read errors.

Signed-off-by: Jorge Ramirez-Ortiz <jramirez@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 4994f92..4959923 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -472,7 +472,7 @@ static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
 	count = st_lsm6dsx_read_fifo(hw);
 	mutex_unlock(&hw->fifo_lock);
 
-	return !count ? IRQ_NONE : IRQ_HANDLED;
+	return (!count || count < 0) ? IRQ_NONE : IRQ_HANDLED;
 }
 
 static int st_lsm6dsx_buffer_preenable(struct iio_dev *iio_dev)
-- 
2.7.4

