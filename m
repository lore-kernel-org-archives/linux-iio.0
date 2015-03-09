Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30046 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbbCIKOk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 9 Mar 2015 06:14:40 -0400
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, pmeerw@pmeerw.net, lars@metafoo.de,
	knaack.h@gmx.de, arnd@arndb.de, fengguang.wu@intel.com
Subject: [PATCH] staging: iio: dummy: Fix undefined symbol build error
Date: Mon,  9 Mar 2015 12:15:53 +0200
Message-Id: <1425896153-620-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CONFIG_SIMPLE_DUMMY_BUFFER compiles in iio_simple_dummy_buffer.c file
which uses functions from industrialio-trigger.c.

So, CONFIG_SIMPLE_DUMMY_BUFFER needs to select IIO_TRIGGER in order to
avoid build error like this:

> ERROR: "iio_trigger_notify_done" [drivers/staging/iio/iio_dummy.ko] undefined!
> ERROR: "iio_triggered_buffer_postenable" [drivers/staging/iio/iio_dummy.ko] undefined!
> ERROR: "iio_triggered_buffer_predisable" [drivers/staging/iio/iio_dummy.ko] undefined!
> ERROR: "iio_alloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
> ERROR: "iio_dealloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!

Cc: Arnd Bergmann <arnd@arndb.de>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/staging/iio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index fa38be0..2a15426 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -38,6 +38,7 @@ config IIO_SIMPLE_DUMMY_EVENTS
 config IIO_SIMPLE_DUMMY_BUFFER
 	boolean "Buffered capture support"
 	select IIO_BUFFER
+	select IIO_TRIGGER
 	select IIO_KFIFO_BUF
 	help
 	  Add buffered data capture to the simple dummy driver.
-- 
1.9.1

