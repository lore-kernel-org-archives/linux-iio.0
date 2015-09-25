Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35995 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbbIYRXq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2015 13:23:46 -0400
Received: by pablk4 with SMTP id lk4so14342497pab.3
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 10:23:45 -0700 (PDT)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 1/2] Staging: iio: cdc: Prefer using the BIT macro
Date: Fri, 25 Sep 2015 22:53:01 +0530
Message-Id: <1443201782-25863-2-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
References: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace bit shifting on 1 with the BIT(x) macro

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 10fa372..55cc8bb 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -68,12 +68,12 @@
 #define AD7746_VTSETUP_VTCHOP		(1 << 0)
 
 /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
-#define AD7746_EXCSETUP_CLKCTRL		(1 << 7)
-#define AD7746_EXCSETUP_EXCON		(1 << 6)
-#define AD7746_EXCSETUP_EXCB		(1 << 5)
-#define AD7746_EXCSETUP_NEXCB		(1 << 4)
-#define AD7746_EXCSETUP_EXCA		(1 << 3)
-#define AD7746_EXCSETUP_NEXCA		(1 << 2)
+#define AD7746_EXCSETUP_CLKCTRL		BIT(7)
+#define AD7746_EXCSETUP_EXCON		BIT(6)
+#define AD7746_EXCSETUP_EXCB		BIT(5)
+#define AD7746_EXCSETUP_NEXCB		BIT(4)
+#define AD7746_EXCSETUP_EXCA		BIT(3)
+#define AD7746_EXCSETUP_NEXCA		BIT(2)
 #define AD7746_EXCSETUP_EXCLVL(x)	(((x) & 0x3) << 0)
 
 /* Config Register Bit Designations (AD7746_REG_CFG) */
-- 
2.1.4

