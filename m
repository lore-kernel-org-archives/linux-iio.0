Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:46089 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbaDIX3O (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Apr 2014 19:29:14 -0400
Received: by mail-ig0-f182.google.com with SMTP id uy17so3081168igb.3
        for <linux-iio@vger.kernel.org>; Wed, 09 Apr 2014 16:29:14 -0700 (PDT)
From: Michael Welling <mwelling@ieee.org>
To: linux-iio@vger.kernel.org, jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: Michael Welling <mwelling@ieee.org>
Subject: [PATCH 1/3] Removes unwanted space before semicolon
Date: Wed,  9 Apr 2014 18:28:47 -0500
Message-Id: <1397086129-12112-2-git-send-email-mwelling@ieee.org>
In-Reply-To: <1397086129-12112-1-git-send-email-mwelling@ieee.org>
References: <1397086129-12112-1-git-send-email-mwelling@ieee.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

---
 drivers/staging/iio/light/tsl2583.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 0a60def..77c7f65 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -211,7 +211,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
 	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
 		/* device is not enabled */
 		dev_err(&chip->client->dev, "taos_get_lux device is not enabled\n");
-		ret = -EBUSY ;
+		ret = -EBUSY;
 		goto out_unlock;
 	}
 
-- 
1.7.9.5

