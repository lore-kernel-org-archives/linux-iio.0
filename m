Return-Path: <roberta.dobrescu@gmail.com>
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
To: linux-iio@vger.kernel.org
Cc: daniel.baluta@intel.com,
	octavian.purdila@intel.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>
Subject: [PATCH 1/5] staging: iio: Documentation: iio_event_monitor: Include linux/iio/types.h
Date: Thu, 26 Feb 2015 10:49:23 +0200
Message-Id: <1424940567-24877-2-git-send-email-roberta.dobrescu@gmail.com>
In-Reply-To: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
References: <1424940567-24877-1-git-send-email-roberta.dobrescu@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

By adding this line and installing the kernel headers with
make headers_install, iio_event_monitor can be compiled without
any hacks.

Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>
---
 drivers/staging/iio/Documentation/iio_event_monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/Documentation/iio_event_monitor.c b/drivers/staging/iio/Documentation/iio_event_monitor.c
index 72c96aa..019a6e5 100644
--- a/drivers/staging/iio/Documentation/iio_event_monitor.c
+++ b/drivers/staging/iio/Documentation/iio_event_monitor.c
@@ -28,6 +28,7 @@
 #include <sys/ioctl.h>
 #include "iio_utils.h"
 #include <linux/iio/events.h>
+#include <linux/iio/types.h>
 
 static const char * const iio_chan_type_name_spec[] = {
 	[IIO_VOLTAGE] = "voltage",
-- 
1.9.1
