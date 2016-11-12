Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55932 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966773AbcKLSTx (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:53 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 22/26] staging: iio: tsl2583: remove comment for tsl2583_probe()
Date: Sat, 12 Nov 2016 13:19:37 -0500
Message-Id: <1478974781-1457-23-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The comment for tsl2583_probe() does not provide any useful value.
This patch removes the comment.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 727ed49..9db191f 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -782,10 +782,6 @@ static const struct iio_info tsl2583_info = {
 	.write_raw = tsl2583_write_raw,
 };
 
-/*
- * Client probe function - When a valid device is found, the driver's device
- * data structure is updated, and initialization completes successfully.
- */
 static int tsl2583_probe(struct i2c_client *clientp,
 			 const struct i2c_device_id *idp)
 {
-- 
2.7.4

