Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42754 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426Ab3FWV2a (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 23 Jun 2013 17:28:30 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 4/5] iio: remove mention of ring buffer from  CONFIG_IIO_KFIFO_BUF, CONFIG_IIO_TRIGGER description
Date: Sun, 23 Jun 2013 23:28:19 +0200
Message-Id: <1372022900-18670-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

ring buffers are only in staging, don't mention them here

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index be8e303..524380c 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -30,8 +30,7 @@ config IIO_KFIFO_BUF
 	select IIO_TRIGGER
 	tristate "Industrial I/O buffering based on kfifo"
 	help
-	  A simple fifo based on kfifo.  Use this if you want a fifo
-	  rather than a ring buffer. Note that this currently provides
+	  A simple fifo based on kfifo.  Note that this currently provides
 	  no buffer events so it is up to userspace to work out how
 	  often to read from the buffer.
 
@@ -49,7 +48,7 @@ config IIO_TRIGGER
 	help
 	  Provides IIO core support for triggers.  Currently these
 	  are used to initialize capture of samples to push into
-	  ring buffers.  The triggers are effectively a 'capture
+	  buffers.  The triggers are effectively a 'capture
 	  data now' interrupt.
 
 config IIO_CONSUMERS_PER_TRIGGER
-- 
1.8.3.1

