Return-Path: <k.wrona@samsung.com>
From: Karol Wrona <k.wrona@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>,
 Karol Wrona <k.wrona@samsung.com>
Subject: [PATCH 2/2] iio: Deselect IIO_TRIGGER for IIO_KFIFO_BUF
Date: Thu, 08 Jan 2015 17:40:27 +0100
Message-id: <1420735227-21091-3-git-send-email-k.wrona@samsung.com>
In-reply-to: <1420735227-21091-1-git-send-email-k.wrona@samsung.com>
References: <1420735227-21091-1-git-send-email-k.wrona@samsung.com>
List-ID: <linux-iio@vger.kernel.org>

iio kfifo can be used without trigger support so there is no need to build it.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/iio/Kconfig |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index 50f6599..dfda2c3 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -27,7 +27,6 @@ boolean "IIO callback buffer used for push in-kernel interfaces"
 	  usage.  That is, those where the data is pushed to the consumer.
 
 config IIO_KFIFO_BUF
-	select IIO_TRIGGER
 	tristate "Industrial I/O buffering based on kfifo"
 	help
 	  A simple fifo based on kfifo.  Note that this currently provides
-- 
1.7.9.5
