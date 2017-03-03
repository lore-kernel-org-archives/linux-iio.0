Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34873 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbdCCRc4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Mar 2017 12:32:56 -0500
Received: by mail-pg0-f65.google.com with SMTP id 1so13266922pgz.2
        for <linux-iio@vger.kernel.org>; Fri, 03 Mar 2017 09:32:50 -0800 (PST)
Date: Fri, 3 Mar 2017 07:38:37 -0800
From: Katie Dunne <kdunne@mail.ccsf.edu>
To: outreachy-kernel@googlegroups.com
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 2/2] staging: iio: meter: ade7753: Clean up includes
Message-ID: <20170303153837.GC29234@katie-Inspiron-5748>
References: <cover.1488553341.git.kdunne@mail.ccsf.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1488553341.git.kdunne@mail.ccsf.edu>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Alphabetize header files.

Signed-off-by: Katie Dunne <kdunne@mail.ccsf.edu>
---
 drivers/staging/iio/meter/ade7753.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 063ff27..dfd8b71 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -6,20 +6,19 @@
  * Licensed under the GPL-2 or later.
  */
 
-#include <linux/interrupt.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
-#include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
-#include <linux/spi/spi.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
 #include <linux/list.h>
 #include <linux/module.h>
-
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/spi/spi.h>
 #include "meter.h"
 
 #define ADE7753_WAVEFORM   0x01
-- 
2.7.4

