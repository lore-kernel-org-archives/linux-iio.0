Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36615 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbIJQc4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 10 Sep 2015 12:32:56 -0400
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Andreas Dilger <andreas.dilger@intel.com>
Cc: Ian Abbott <abbotti@mev.co.uk>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 4/6] Staging: iio: cdc: Prefer using the BIT macro
Date: Thu, 10 Sep 2015 22:02:39 +0530
Message-Id: <1441902761-11190-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro

This was done with coccinelle:
@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index e6e9eaa..10fa372 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -46,10 +46,10 @@
 #define AD7746_REG_VOLT_GAINL		18
 
 /* Status Register Bit Designations (AD7746_REG_STATUS) */
-#define AD7746_STATUS_EXCERR		(1 << 3)
-#define AD7746_STATUS_RDY		(1 << 2)
-#define AD7746_STATUS_RDYVT		(1 << 1)
-#define AD7746_STATUS_RDYCAP		(1 << 0)
+#define AD7746_STATUS_EXCERR		BIT(3)
+#define AD7746_STATUS_RDY		BIT(2)
+#define AD7746_STATUS_RDYVT		BIT(1)
+#define AD7746_STATUS_RDYCAP		BIT(0)
 
 /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
 #define AD7746_CAPSETUP_CAPEN		(1 << 7)
-- 
2.1.4

