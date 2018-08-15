Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway21.websitewelcome.com ([192.185.45.191]:20296 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729386AbeHOTkw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Aug 2018 15:40:52 -0400
Received: from cm15.websitewelcome.com (cm15.websitewelcome.com [100.42.49.9])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id 3053140437363
        for <linux-iio@vger.kernel.org>; Wed, 15 Aug 2018 11:24:20 -0500 (CDT)
Date: Wed, 15 Aug 2018 11:23:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] iio: health: max30102: Mark expected switch fall-throughs
Message-ID: <20180815162349.GA3458@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Notice that in this particular case, I placed the "fall through"
annotation at the bottom of the case, which is what GCC is expecting
to find.

Addresses-Coverity-ID: 1458342 ("Missing break in switch")
Addresses-Coverity-ID: 1458345 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/iio/health/max30102.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 15ccadc..3e29562 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -282,9 +282,11 @@ static int max30102_read_measurement(struct max30102_data *data,
 	switch (measurements) {
 	case 3:
 		MAX30102_COPY_DATA(2);
-	case 2: /* fall-through */
+		/* fall through */
+	case 2:
 		MAX30102_COPY_DATA(1);
-	case 1: /* fall-through */
+		/* fall through */
+	case 1:
 		MAX30102_COPY_DATA(0);
 		break;
 	default:
-- 
2.7.4
