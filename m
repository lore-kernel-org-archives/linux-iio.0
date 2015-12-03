Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:57480 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbbLCX2h (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Dec 2015 18:28:37 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Cristina Opriceana <cristina.opriceana@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH, RESEND] staging: iio: select IRQ_WORK for IIO_DUMMY_EVGEN
Date: Fri, 04 Dec 2015 00:28:17 +0100
Message-ID: <1589979.s93Dkm5ubV@wuerfel>
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
Acked-by: Daniel Baluta <daniel.baluta@intel.com>
---
I submitted the patch before and it was accepted, but then it
apparently got lost when the driver was moved out of staging,
and the bug came back with today's linux-next


diff --git a/drivers/iio/dummy/Kconfig b/drivers/iio/dummy/Kconfig
index e8676aa97d62..71805ced1aae 100644
--- a/drivers/iio/dummy/Kconfig
+++ b/drivers/iio/dummy/Kconfig
@@ -5,7 +5,8 @@ menu "IIO dummy driver"
 	depends on IIO
 
 config IIO_DUMMY_EVGEN
-       tristate
+	select IRQ_WORK
+	tristate
 
 config IIO_SIMPLE_DUMMY
        tristate "An example driver with no hardware requirements"

