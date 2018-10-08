Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway32.websitewelcome.com ([192.185.145.122]:11734 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726291AbeJIA7S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Oct 2018 20:59:18 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id 38B9F15F4C0
        for <linux-iio@vger.kernel.org>; Mon,  8 Oct 2018 12:23:58 -0500 (CDT)
Date: Mon, 8 Oct 2018 19:23:32 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: cros_ec_accel_legacy: Mark expected switch fall-throughs
Message-ID: <20181008172332.GA29816@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1397962 ("Missing break in switch")
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
