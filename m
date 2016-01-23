Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:47564 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbcAWTdS (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 Jan 2016 14:33:18 -0500
From: Colin King <colin.king@canonical.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: iio: adc: fix indent on break statement
Date: Sat, 23 Jan 2016 19:33:10 +0000
Message-Id: <1453577590-12177-1-git-send-email-colin.king@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Fix indent warning when building with gcc 6:
drivers/staging/iio/adc/ad7192.c:239:4: warning: statement is indented
  as if it were guarded by... [-Wmisleading-indentation]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 9221103..92f2b72 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -236,7 +236,7 @@ static int ad7192_setup(struct ad7192_state *st,
 			st->mclk = pdata->ext_clk_hz;
 		else
 			st->mclk = AD7192_INT_FREQ_MHZ;
-			break;
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
-- 
2.7.0.rc3

