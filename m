Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:54929 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbaBHAHl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 7 Feb 2014 19:07:41 -0500
Received: from [192.168.0.80] ([178.8.245.194]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MHal6-1WD1uq0YZA-003KVQ for
 <linux-iio@vger.kernel.org>; Sat, 08 Feb 2014 01:07:40 +0100
Message-ID: <52F5754B.9060507@gmx.de>
Date: Sat, 08 Feb 2014 01:07:39 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
Subject: [PATCH]staging:iio:ad799x fix typo in ad799x_events[]
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes a typo in ad799x_events[], which caused the error "Failed to register event set".

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
diff --git a/drivers/staging/iio/adc/ad799x_core.c b/drivers/staging/iio/adc/ad799x_core.c
index c1b601ac..bf9081e 100644
--- a/drivers/staging/iio/adc/ad799x_core.c
+++ b/drivers/staging/iio/adc/ad799x_core.c
@@ -393,7 +393,7 @@ static const struct iio_event_spec ad799x_events[] = {
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_FALLING,
-		.mask_separate = BIT(IIO_EV_INFO_VALUE),
+		.mask_separate = BIT(IIO_EV_INFO_VALUE) |
 			BIT(IIO_EV_INFO_ENABLE),
 	}, {
 		.type = IIO_EV_TYPE_THRESH,
