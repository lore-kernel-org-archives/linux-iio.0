Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54054 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751714AbdJSUGh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:37 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 02/13] staging: iio: tsl2x7x: remove unused tsl2x7x_parse_result structure
Date: Thu, 19 Oct 2017 16:06:21 -0400
Message-Id: <20171019200632.25820-3-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The structure tsl2x7x_parse_result is not used so this patch removes its
definition.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index 2dd8c502fd7a..094ab76b5d60 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -142,11 +142,6 @@ enum {
 	TSL2X7X_CHIP_SUSPENDED = 2
 };
 
-struct tsl2x7x_parse_result {
-	int integer;
-	int fract;
-};
-
 /* Per-device data */
 struct tsl2x7x_als_info {
 	u16 als_ch0;
-- 
2.13.6

