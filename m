Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47274 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753274AbcKHK1R (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 05:27:17 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v2 16/23] staging: iio: tsl2583: updated code comment to match what the code does
Date: Tue,  8 Nov 2016 05:16:41 -0500
Message-Id: <1478600208-21153-17-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
References: <1478600208-21153-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If channel 0 does not have any data, then the code sets the lux to zero.
The corresponding comment says that the last value is returned. This
updates the comment to correctly reflect what the code does.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5ef403c..8d9176d 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -221,7 +221,7 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 		goto return_max;
 
 	if (!ch0) {
-		/* have no data, so return LAST VALUE */
+		/* have no data, so return 0 */
 		ret = 0;
 		chip->als_cur_info.lux = 0;
 		goto done;
-- 
2.7.4

