Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:39738 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751668AbdEEAiq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 4 May 2017 20:38:46 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 1/2] staging: iio: tsl2x7x: rename driver for consistency with other IIO light drivers
Date: Thu,  4 May 2017 20:38:22 -0400
Message-Id: <20170505003823.12133-2-masneyb@onstation.org>
In-Reply-To: <20170505003823.12133-1-masneyb@onstation.org>
References: <20170505003823.12133-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch renames the tsl2x7x_core.c file to tsl2x7x.c so that the
naming convention is consistent with other IIO light drivers outside
of staging.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/Makefile                      | 2 +-
 drivers/staging/iio/light/{tsl2x7x_core.c => tsl2x7x.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename drivers/staging/iio/light/{tsl2x7x_core.c => tsl2x7x.c} (100%)

diff --git a/drivers/staging/iio/light/Makefile b/drivers/staging/iio/light/Makefile
index 10286c3..ab8dc3a 100644
--- a/drivers/staging/iio/light/Makefile
+++ b/drivers/staging/iio/light/Makefile
@@ -2,4 +2,4 @@
 # Makefile for industrial I/O Light sensors
 #
 
-obj-$(CONFIG_TSL2x7x)	+= tsl2x7x_core.o
+obj-$(CONFIG_TSL2x7x)	+= tsl2x7x.o
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x.c
similarity index 100%
rename from drivers/staging/iio/light/tsl2x7x_core.c
rename to drivers/staging/iio/light/tsl2x7x.c
-- 
2.9.3

