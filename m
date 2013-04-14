Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53578 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab3DNLX7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Apr 2013 07:23:59 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 2/3] staging:iio:gyro:adis16130 drop unused list.h header.
Date: Sun, 14 Apr 2013 12:23:44 +0100
Message-Id: <1365938625-21778-3-git-send-email-jic23@kernel.org>
In-Reply-To: <1365938625-21778-1-git-send-email-jic23@kernel.org>
References: <1365938625-21778-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/gyro/adis16130_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index 531b803..628671a 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -13,7 +13,6 @@
 #include <linux/spi/spi.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/list.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
-- 
1.8.2.1

