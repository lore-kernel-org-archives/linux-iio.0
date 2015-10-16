Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:56340 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbbJPWa3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 16 Oct 2015 18:30:29 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Cristina Opriceana <cristina.opriceana@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	devel@driverdev.osuosl.org, devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN
Date: Sat, 17 Oct 2015 00:29:55 +0200
Message-ID: <22609671.lgCfBiaFIf@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The iio dummy code was recently changed to use irq_work_queue, but
that code is compiled into the kernel only if IRQ_WORK is set, so
we can get a link error here:

drivers/built-in.o: In function `iio_evgen_poke':
(.text+0x208a04): undefined reference to `irq_work_queue'

This changes the Kconfig file to match what other drivers do.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: fd2bb310ca3d ("Staging: iio: Move evgen interrupt generation to irq_work")
---
Found on ARM randconfig tests

diff --git a/drivers/staging/iio/Kconfig b/drivers/staging/iio/Kconfig
index 6d5b38d69578..9d7f0004d2d7 100644
--- a/drivers/staging/iio/Kconfig
+++ b/drivers/staging/iio/Kconfig
@@ -18,7 +18,8 @@ source "drivers/staging/iio/resolver/Kconfig"
 source "drivers/staging/iio/trigger/Kconfig"
 
 config IIO_DUMMY_EVGEN
-       tristate
+	tristate
+	select IRQ_WORK
 
 config IIO_SIMPLE_DUMMY
        tristate "An example driver with no hardware requirements"

