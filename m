Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49098 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751177AbdAQJZY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:24 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 10/15] staging: iio: isl29028: remove out of memory log message
Date: Tue, 17 Jan 2017 04:24:57 -0500
Message-Id: <20170117092502.6951-11-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
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
index be1fc4a..e93077b 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -488,10 +488,8 @@ static int isl29028_probe(struct i2c_client *client,
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
-	if (!indio_dev) {
-		dev_err(&client->dev, "iio allocation fails\n");
+	if (!indio_dev)
 		return -ENOMEM;
-	}
 
 	chip = iio_priv(indio_dev);
 
-- 
2.9.3

