Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50592 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755107AbcKJJ0Y (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:24 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 22/28] staging: iio: tsl2583: add tsl2583 to list of supported devices in the header
Date: Thu, 10 Nov 2016 04:25:58 -0500
Message-Id: <1478769964-7065-23-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
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
index c9635e3..d3fe9f7 100644
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

