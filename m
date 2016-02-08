Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32797 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755041AbcBHGtr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 01:49:47 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: lars@metafoo.de, gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] Staging: iio: adc: Prefer using the BIT macro
Date: Mon,  8 Feb 2016 12:18:57 +0530
Message-Id: <9d77eec44a1f7223c2482ebe3c7df1f90d96aa9a.1454913458.git.bhumirks@gmail.com>
In-Reply-To: <cover.1454913458.git.bhumirks@gmail.com>
References: <cover.1454913458.git.bhumirks@gmail.com>
In-Reply-To: <cover.1454913458.git.bhumirks@gmail.com>
References: <cover.1454913458.git.bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch replaces bit shifting on 1 with the BIT(x) macro.

This was done with coccinelle:

@@ int g; @@

-(1 << g)
+BIT(g)

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/staging/iio/adc/ad7280a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 0c73bce..ccf3157 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -117,7 +117,7 @@
  */
 #define POLYNOM		0x2F
 #define POLYNOM_ORDER	8
-#define HIGHBIT		(1 << (POLYNOM_ORDER - 1))
+#define HIGHBIT		BIT((POLYNOM_ORDER - 1))
 
 struct ad7280_state {
 	struct spi_device		*spi;
@@ -388,7 +388,7 @@ static ssize_t ad7280_show_balance_sw(struct device *dev,
 
 	return sprintf(buf, "%d\n",
 		       !!(st->cb_mask[this_attr->address >> 8] &
-		       (1 << ((this_attr->address & 0xFF) + 2))));
+		       BIT(((this_attr->address & 0xFF) + 2))));
 }
 
 static ssize_t ad7280_store_balance_sw(struct device *dev,
-- 
1.9.1

