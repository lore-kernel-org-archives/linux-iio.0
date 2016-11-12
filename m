Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55904 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966837AbcKLSTw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:52 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 20/26] staging: iio: tsl2583: add tsl2583 to list of supported devices in the header
Date: Sat, 12 Nov 2016 13:19:35 -0500
Message-Id: <1478974781-1457-21-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The header only listed the tsl2580 and tsl2581 devices as supported by
this driver. This patch adds the tsl2583 since it is also supported by
this driver.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 3818ffa..806cb0a 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -1,6 +1,6 @@
 /*
  * Device driver for monitoring ambient light intensity (lux)
- * within the TAOS tsl258x family of devices (tsl2580, tsl2581).
+ * within the TAOS tsl258x family of devices (tsl2580, tsl2581, tsl2583).
  *
  * Copyright (c) 2011, TAOS Corporation.
  *
-- 
2.7.4

