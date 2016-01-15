Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33413 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbcAOTnd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2016 14:43:33 -0500
From: Bhumika Goyal <bhumirks@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, pmeerw@pmeerw.net,
	devel@driverdev.osuosl.org, Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/2] staging:iio:adc:add space around '-'
Date: Sat, 16 Jan 2016 01:12:42 +0530
Message-Id: <fc4c2ee35d86982c40b1b2955e0c0fc7ff207d52.1452878721.git.bhumirks@gmail.com>
In-Reply-To: <cover.1452878721.git.bhumirks@gmail.com>
References: <cover.1452878721.git.bhumirks@gmail.com>
In-Reply-To: <cover.1452878721.git.bhumirks@gmail.com>
References: <cover.1452878721.git.bhumirks@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds space around '-' operator.Found using checkpatch.pl

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 9221103..54db0f0 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -376,7 +376,7 @@ ad7192_show_scale_available(struct device *dev,
 }
 
 static IIO_DEVICE_ATTR_NAMED(in_v_m_v_scale_available,
-			     in_voltage-voltage_scale_available,
+			     in_voltage - voltage_scale_available,
 			     S_IRUGO, ad7192_show_scale_available, NULL, 0);
 
 static IIO_DEVICE_ATTR(in_voltage_scale_available, S_IRUGO,
-- 
1.9.1

