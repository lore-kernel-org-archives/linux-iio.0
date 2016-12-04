Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47162 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752479AbcLDCUX (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:23 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 18/19] staging: iio: isl29028: remove unnecessary parenthesis
Date: Sat,  3 Dec 2016 21:19:42 -0500
Message-Id: <1480817983-32359-19-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

isl29028_write_raw() contains unnecessary parenthesis when checking to
see if the passed in lux scale is valid. This patch removes the
unnecessary parenthesis.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index bda5183..ae6896f 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -330,7 +330,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		if ((val != 125) && (val != 2000)) {
+		if (val != 125 && val != 2000) {
 			dev_err(dev,
 				"%s(): light: Lux scale %d is not in the set {125, 2000}\n",
 				__func__, val);
-- 
2.7.4

