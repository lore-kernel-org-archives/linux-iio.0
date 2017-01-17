Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:49002 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751000AbdAQJZS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:18 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 05/15] staging: iio: isl29028: remove unused define ISL29028_DEV_ATTR
Date: Tue, 17 Jan 2017 04:24:52 -0500
Message-Id: <20170117092502.6951-6-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The #define ISL29028_DEV_ATTR was not used so this patch removes the
unnecessary code.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index d05d761..7074e62 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -391,7 +391,6 @@ static IIO_CONST_ATTR(in_proximity_sampling_frequency_available,
 				"1 3 5 10 13 20 83 100");
 static IIO_CONST_ATTR(in_illuminance_scale_available, "125 2000");
 
-#define ISL29028_DEV_ATTR(name) (&iio_dev_attr_##name.dev_attr.attr)
 #define ISL29028_CONST_ATTR(name) (&iio_const_attr_##name.dev_attr.attr)
 static struct attribute *isl29028_attributes[] = {
 	ISL29028_CONST_ATTR(in_proximity_sampling_frequency_available),
-- 
2.9.3

