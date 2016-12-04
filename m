Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47172 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752198AbcLDCUW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:22 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 10/19] staging: iio: isl29028: remove unused define ISL29028_DEV_ATTR
Date: Sat,  3 Dec 2016 21:19:34 -0500
Message-Id: <1480817983-32359-11-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The #define ISL29028_DEV_ATTR was not used so this patch removes the
unnecessary code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 8f9295f..0e727ba 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -404,7 +404,6 @@ static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
 				"1 3 5 10 13 20 83 100");
 static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
 
-#define ISL29028_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
 static struct attribute *isl29028_attributes[] = {
 	ISL29028_CONST_ATTR(in_proximity_sampling_frequency_available),
-- 
2.7.4

