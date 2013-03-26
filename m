Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-011.synserver.de ([212.40.185.11]:1037 "EHLO
	smtp-out-226.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932345Ab3CZSlJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Mar 2013 14:41:09 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/6] staging:iio:ad799x: Remove unused ad799x_state fields
Date: Tue, 26 Mar 2013 19:42:59 +0100
Message-Id: <1364323384-30863-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove fields from the ad799x_state struct which are not used.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad799x.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad799x.h b/drivers/staging/iio/adc/ad799x.h
index 3e363c4..9f50f93 100644
--- a/drivers/staging/iio/adc/ad799x.h
+++ b/drivers/staging/iio/adc/ad799x.h
@@ -104,11 +104,9 @@ struct ad799x_chip_info {
 struct ad799x_state {
 	struct i2c_client		*client;
 	const struct ad799x_chip_info	*chip_info;
-	struct iio_trigger		*trig;
 	struct regulator		*reg;
 	u16				int_vref_mv;
 	unsigned			id;
-	char				*name;
 	u16				config;
 };
 
-- 
1.8.0

