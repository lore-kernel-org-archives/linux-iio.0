Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ob0-f182.google.com ([209.85.214.182]:60541 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbaJaPot (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 31 Oct 2014 11:44:49 -0400
Received: by mail-ob0-f182.google.com with SMTP id nt9so6701389obb.41
        for <linux-iio@vger.kernel.org>; Fri, 31 Oct 2014 08:44:48 -0700 (PDT)
From: George McCollister <george.mccollister@gmail.com>
To: mranostay@gmail.com
Cc: linux-iio@vger.kernel.org,
	George McCollister <george.mccollister@gmail.com>
Subject: [PATCH 1/2] iio: as3935: allocate correct iio_device size
Date: Fri, 31 Oct 2014 10:44:22 -0500
Message-Id: <1414770263-13146-1-git-send-email-george.mccollister@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: George McCollister <george.mccollister@gmail.com>
---
 drivers/iio/proximity/as3935.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index 5e780ef..8349cc0 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -330,7 +330,7 @@ static int as3935_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(st));
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
-- 
2.0.4

