Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:50642 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755128AbcKJJ00 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 10 Nov 2016 04:26:26 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v3 24/28] staging: iio: tsl2583: remove comment for tsl2583_probe()
Date: Thu, 10 Nov 2016 04:26:00 -0500
Message-Id: <1478769964-7065-25-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
References: <1478769964-7065-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The comment for tsl2583_probe() does not provide any useful value.
This patch removes the comment.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 68b77b8..bbef8ea 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -778,10 +778,6 @@ static const struct iio_info tsl2583_info = {
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

