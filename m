Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33104 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756344AbbIYRXt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2015 13:23:49 -0400
Received: by pacex6 with SMTP id ex6so111126861pac.0
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2015 10:23:49 -0700 (PDT)
From: Shraddha Barke <shraddha.6596@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Shraddha Barke <shraddha.6596@gmail.com>
Subject: [PATCH 2/2] Staging: iio: cdc: Remove unnecessary dev_info
Date: Fri, 25 Sep 2015 22:53:02 +0530
Message-Id: <1443201782-25863-3-git-send-email-shraddha.6596@gmail.com>
In-Reply-To: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
References: <1443201782-25863-1-git-send-email-shraddha.6596@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove dev_info as the information can be obtained by other means

Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>
---
 drivers/staging/iio/cdc/ad7746.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 55cc8bb..ca7d33f 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -753,8 +753,6 @@ static int ad7746_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
-	dev_info(&client->dev, "%s capacitive sensor registered\n", id->name);
-
 	return 0;
 }
 
-- 
2.1.4

