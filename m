Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52128 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757708Ab3IAQzm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Sep 2013 12:55:42 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, fengguang.wu@intel.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH] staging:iio:dummy fix kfifo_buf kconfig dependency issue if kfifo modular and buffer enabled for built in dummy driver.
Date: Sun,  1 Sep 2013 18:55:36 +0100
Message-Id: <1378058136-18453-1-git-send-email-jic23@kernel.org>
In-Reply-To: <20130723235123.GA25723@localhost>
References: <20130723235123.GA25723@localhost>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This only occurs in the unlikely event that the example driver is built
in whilst the buffer implementation is not.

Solved by switching from a depends on to a select for this particular case.

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index db4d6dc..b36feb0 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -37,7 +37,7 @@ config IIO_SIMPLE_DUMMY_EVENTS
 
 config IIO_SIMPLE_DUMMY_BUFFER
        boolean "Buffered capture support"
-       depends on IIO_KFIFO_BUF
+       select IIO_KFIFO_BUF
        help
          Add buffered data capture to the simple dummy driver.
 
-- 
1.8.4

