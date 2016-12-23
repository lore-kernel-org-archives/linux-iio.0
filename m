Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.ispras.ru ([83.149.199.45]:34068 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751936AbcLWWPe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 23 Dec 2016 17:15:34 -0500
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Jonathan Cameron <jic23@kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] iio: mxs-lradc: fix error handling in mxs_lradc_probe()
Date: Sat, 24 Dec 2016 01:15:19 +0300
Message-Id: <1482531319-26935-1-git-send-email-khoroshilov@ispras.ru>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

During transition to using devm_input_allocate_device()
goto to resource deallocation block was replaced by return
in case of error in iio_device_register().
That is wrong since resources are left undeallocated.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 962ed43a3eac ("iio: mxs-lradc: remove mxs_lradc_ts_unregister")
---
 drivers/iio/adc/mxs-lradc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index b84d37c80a94..1ab0caeb3577 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1702,7 +1702,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	ret = iio_device_register(iio);
 	if (ret) {
 		dev_err(dev, "Failed to register IIO device\n");
-		return ret;
+		goto err_ts_register;
 	}
 
 	return 0;
-- 
2.7.4

