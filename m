Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49126 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdAQJZZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:25 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 11/15] staging: iio: isl29028: remove unnecessary parenthesis
Date: Tue, 17 Jan 2017 04:24:58 -0500
Message-Id: <20170117092502.6951-12-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
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
index e93077b..bc9c01d 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -327,7 +327,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 			break;
 		}
 
-		if ((val != 125) && (val != 2000)) {
+		if (val != 125 && val != 2000) {
 			dev_err(dev,
 				"%s(): light: Lux scale %d is not in the set {125, 2000}\n",
 				__func__, val);
-- 
2.9.3

