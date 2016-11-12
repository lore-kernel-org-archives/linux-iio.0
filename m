Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:55932 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966806AbcKLSTu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 12 Nov 2016 13:19:50 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH v4 14/26] staging: iio: tsl2583: updated code comment to match what the code does
Date: Sat, 12 Nov 2016 13:19:29 -0500
Message-Id: <1478974781-1457-15-git-send-email-masneyb@onstation.org>
In-Reply-To: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
References: <1478974781-1457-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If channel 0 does not have any data, then the code sets the lux to zero.
The corresponding comment says that the last value is returned. This
updates the comment to correctly reflect what the code does. It also
clarifies the comment about why 0 is returned.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2583.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 52a39a6..dbb7f6a 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -221,7 +221,11 @@ static int tsl2583_get_lux(struct iio_dev *indio_dev)
 		goto return_max;
 
 	if (!ch0) {
-		/* have no data, so return LAST VALUE */
+		/*
+		 * The sensor appears to be in total darkness so set the
+		 * calculated lux to 0 and return early to avoid a division by
+		 * zero below when calculating the ratio.
+		 */
 		ret = 0;
 		chip->als_cur_info.lux = 0;
 		goto done;
-- 
2.7.4

