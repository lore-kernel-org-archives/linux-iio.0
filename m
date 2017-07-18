Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:36013 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbdGRJw7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 18 Jul 2017 05:52:59 -0400
From: Jaya Durga <rjdurga@gmail.com>
To: gregkh@linuxfoundation.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jaya Durga <rjdurga@gmail.com>
Subject: [PATCH 3/3] Staging: iio: adc: ad7280a.c: Fixed Macro argument reuse
Date: Tue, 18 Jul 2017 15:17:52 +0530
Message-Id: <1500371272-16701-1-git-send-email-rjdurga@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

CHECK: Macro argument reuse 'addr' - possible side-effects?

convert AD7280A_DEVADDR to inline function to fix checkpath check

Signed-off-by: Jaya Durga <rjdurga@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index d5ab83f..cb94b7f 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -99,9 +99,12 @@
 #define AD7280A_DEVADDR_MASTER		0
 #define AD7280A_DEVADDR_ALL		0x1F
 /* 5-bit device address is sent LSB first */
-#define AD7280A_DEVADDR(addr)	(((addr & 0x1) << 4) | ((addr & 0x2) << 3) | \
-				(addr & 0x4) | ((addr & 0x8) >> 3) | \
-				((addr & 0x10) >> 4))
+static inline unsigned int AD7280A_DEVADDR(unsigned int addr)
+{
+	return ((((addr & 0x1) << 4) | ((addr & 0x2) << 3) |
+		  (addr & 0x4) | ((addr & 0x8) >> 3) |
+		  ((addr & 0x10) >> 4)));
+}
 
 /* During a read a valid write is mandatory.
  * So writing to the highest available address (Address 0x1F)
-- 
1.9.1

