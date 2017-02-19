Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35040 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751886AbdBST65 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Feb 2017 14:58:57 -0500
Received: by mail-pf0-f196.google.com with SMTP id 68so7787964pfx.2
        for <linux-iio@vger.kernel.org>; Sun, 19 Feb 2017 11:58:56 -0800 (PST)
Date: Mon, 20 Feb 2017 01:28:35 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH v2 1/2] staging: iio: ad7152: Use BIT() macro for left
 shifting 1
Message-ID: <06283c7cbccd40a7214bf4f047c3829e53b6d448.1487483384.git.karniksayli1995@gmail.com>
References: <cover.1487483384.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487483384.git.karniksayli1995@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Replace left shifting on 1 with the BIT(x) macro as suggested by
checkpatch.pl.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
v2:
Used GENMASK() macro instead of BIT() macro for multi-bit bitfields.
Removed extra parentheses around argument to macro

 drivers/staging/iio/cdc/ad7152.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index b91b50f..e8609b8 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -41,10 +41,10 @@
 #define AD7152_REG_CFG2			26
 
 /* Status Register Bit Designations (AD7152_REG_STATUS) */
-#define AD7152_STATUS_RDY1		(1 << 0)
-#define AD7152_STATUS_RDY2		(1 << 1)
-#define AD7152_STATUS_C1C2		(1 << 2)
-#define AD7152_STATUS_PWDN		(1 << 7)
+#define AD7152_STATUS_RDY1		BIT(0)
+#define AD7152_STATUS_RDY2		BIT(1)
+#define AD7152_STATUS_C1C2		BIT(2)
+#define AD7152_STATUS_PWDN		BIT(7)
 
 /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
 #define AD7152_SETUP_CAPDIFF		(1 << 5)
-- 
2.7.4

