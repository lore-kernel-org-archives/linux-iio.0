Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47186 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752481AbcLDCUX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 17/19] staging: iio: isl29028: remove out of memory log message
Date: Sat,  3 Dec 2016 21:19:41 -0500
Message-Id: <1480817983-32359-18-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If the call to devm_iio_device_alloc() fails, then isl29028_probe()
logs a message saying that memory cannot be allocated. The user's system
most likely has larger issues at this point. This patch removes that
error message since the error code is passed on and the message is not
necessary.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 3f01ad1..bda5183 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -507,10 +507,8 @@ static int isl29028_probe(struct i2c_client *client,
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation fails\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	chip = iio_priv(indio_dev);
 
-- 
2.7.4

