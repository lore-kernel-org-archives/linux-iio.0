Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-222.synserver.de ([212.40.185.222]:1071 "EHLO
	smtp-out-222.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755239Ab2KUQ1V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Nov 2012 11:27:21 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 04/11] staging:iio:ad7793: Use kstrtol instead of strict_strtol
Date: Wed, 21 Nov 2012 17:27:09 +0100
Message-Id: <1353515236-21843-4-git-send-email-lars@metafoo.de>
In-Reply-To: <1353515236-21843-1-git-send-email-lars@metafoo.de>
References: <1353515236-21843-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

strict_strtol is deprecated in favor of kstrtol.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 1c3d668..028473a 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -204,7 +204,7 @@ static ssize_t ad7793_write_frequency(struct device *dev,
 	}
 	mutex_unlock(&indio_dev->mlock);
 
-	ret = strict_strtol(buf, 10, &lval);
+	ret = kstrtol(buf, 10, &lval);
 	if (ret)
 		return ret;
 
-- 
1.8.0

