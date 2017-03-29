Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36235 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932545AbdC2Mda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 29 Mar 2017 08:33:30 -0400
From: simran singhal <singhalsimran0@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 4/4] iio: light: si1145: Replace ternary operator with min macro
Date: Wed, 29 Mar 2017 18:03:11 +0530
Message-Id: <1490790791-5694-5-git-send-email-singhalsimran0@gmail.com>
In-Reply-To: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
References: <1490790791-5694-1-git-send-email-singhalsimran0@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use macro min() to get the minimum of two values for brevity and
readability.

Signed-off-by: simran singhal <singhalsimran0@gmail.com>
---
 drivers/iio/light/si1145.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index 096034c..e7ad6fb 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -557,7 +557,7 @@ static int si1145_set_chlist(struct iio_dev *indio_dev, unsigned long scan_mask)
 	data->scan_mask = scan_mask;
 	ret = si1145_param_set(data, SI1145_PARAM_CHLIST, reg);
 
-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }
 
 static int si1145_measure(struct iio_dev *indio_dev,
-- 
2.7.4

