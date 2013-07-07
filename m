Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48266 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121Ab3GGUYW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 7 Jul 2013 16:24:22 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 5/5] iio: fix semicolon in io_core_trigger.h
Date: Sun,  7 Jul 2013 22:24:06 +0200
Message-Id: <1373228646-5356-5-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
References: <1373228646-5356-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/iio_core_trigger.h | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/iio_core_trigger.h b/drivers/iio/iio_core_trigger.h
index 6f7c56f..1fdb1e4 100644
--- a/drivers/iio/iio_core_trigger.h
+++ b/drivers/iio/iio_core_trigger.h
@@ -30,7 +30,7 @@ void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev);
 static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
 {
 	return 0;
-};
+}
 
 /**
  * iio_device_unregister_trigger_consumer() - reverse the registration process
@@ -38,9 +38,6 @@ static int iio_device_register_trigger_consumer(struct iio_dev *indio_dev)
  **/
 static void iio_device_unregister_trigger_consumer(struct iio_dev *indio_dev)
 {
-};
+}
 
 #endif /* CONFIG_TRIGGER_CONSUMER */
-
-
-
-- 
1.8.3.2

