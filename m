Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:33782 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbcBHGta (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Feb 2016 01:49:30 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: lars@metafoo.de, gregkh@linuxfoundation.org,
	Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] Staging:iio:Prefer using BIT macro
Date: Mon,  8 Feb 2016 12:18:56 +0530
Message-Id: <74ee6d155e15fbfe06512c7caa52f1575727402e.1454913458.git.bhumirks@gmail.com>
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
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 2226051..f631012 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -222,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 		value = (s8)((data >> AD7816_TEMP_FLOAT_OFFSET) - 103);
 		data &= AD7816_TEMP_FLOAT_MASK;
 		if (value < 0)
-			data = (1 << AD7816_TEMP_FLOAT_OFFSET) - data;
+			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
 		return sprintf(buf, "%d.%.2d\n", value, data * 25);
 	}
 	return sprintf(buf, "%u\n", data);
-- 
1.9.1

