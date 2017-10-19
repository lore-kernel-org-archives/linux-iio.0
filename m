Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:54084 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752720AbdJSUGk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Oct 2017 16:06:40 -0400
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, Jon.Brenner@ams.com
Subject: [PATCH 11/13] staging: iio: tsl2x7x: fix alignment of break statements
Date: Thu, 19 Oct 2017 16:06:30 -0400
Message-Id: <20171019200632.25820-12-masneyb@onstation.org>
In-Reply-To: <20171019200632.25820-1-masneyb@onstation.org>
References: <20171019200632.25820-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Correct the alignment of the break statements to match the alignment of
the rest of the code within the case statements.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/tsl2x7x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
index bb9fb60509cf..f12ab1239a46 100644
--- a/drivers/staging/iio/light/tsl2x7x.c
+++ b/drivers/staging/iio/light/tsl2x7x.c
@@ -466,7 +466,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	case tmd2771:
 		if (!(ret & TSL2X7X_STA_ADC_VALID))
 			goto prox_poll_err;
-	break;
+		break;
 	case tsl2572:
 	case tsl2672:
 	case tmd2672:
@@ -474,7 +474,7 @@ static int tsl2x7x_get_prox(struct iio_dev *indio_dev)
 	case tmd2772:
 		if (!(ret & TSL2X7X_STA_PRX_VALID))
 			goto prox_poll_err;
-	break;
+		break;
 	}
 
 	for (i = 0; i < 2; i++) {
-- 
2.13.6

