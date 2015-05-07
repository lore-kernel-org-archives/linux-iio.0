Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn1on0134.outbound.protection.outlook.com ([157.56.110.134]:40032
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751097AbbEGNoq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 7 May 2015 09:44:46 -0400
From: Fabio Estevam <fabio.estevam@freescale.com>
To: <jic23@kernel.org>
CC: <khoroshilov@ispras.ru>, <daniel.baluta@intel.com>,
	<linux-iio@vger.kernel.org>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] iio: light: hid-sensor-prox: Fix memory leak in hid_prox_probe()
Date: Thu, 7 May 2015 10:44:22 -0300
Message-ID: <1431006262-18543-1-git-send-email-fabio.estevam@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

When prox_parse_report() fails we should free the previously allocated 
'channels' struct.

Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/iio/light/hid-sensor-prox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index 91ecc46..f76ef0f 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -332,7 +332,7 @@ error_remove_trigger:
 error_unreg_buffer_funcs:
 	iio_triggered_buffer_cleanup(indio_dev);
 error_free_dev_mem:
-	kfree(indio_dev->channels);
+	kfree(channels);
 	return ret;
 }
 
-- 
1.9.1

