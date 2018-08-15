Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.45.191]:40934 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729931AbeHOTbq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 15:31:46 -0400
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 4D873400DEBAB
        for <linux-iio@vger.kernel.org>; Wed, 15 Aug 2018 11:38:54 -0500 (CDT)
Date: Wed, 15 Aug 2018 11:38:52 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: accel: cros_ec_accel_legacy: Mark expected switch
 fall-throughs
Message-ID: <20180815163852.GA4910@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1462408 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/accel/cros_ec_accel_legacy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
index 063e89e..d609654 100644
--- a/drivers/iio/accel/cros_ec_accel_legacy.c
+++ b/drivers/iio/accel/cros_ec_accel_legacy.c
@@ -385,8 +385,10 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
 		switch (i) {
 		case X:
 			ec_accel_channels[X].scan_index = Y;
+			/* fall through */
 		case Y:
 			ec_accel_channels[Y].scan_index = X;
+			/* fall through */
 		case Z:
 			ec_accel_channels[Z].scan_index = Z;
 		}
-- 
2.7.4
