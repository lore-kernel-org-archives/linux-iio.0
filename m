Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-045.synserver.de ([212.40.185.45]:1061 "EHLO
	smtp-out-025.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751897Ab3KYMlj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Nov 2013 07:41:39 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/15] iio:ad5755: Mark transfer buffer as __be32
Date: Mon, 25 Nov 2013 13:41:57 +0100
Message-Id: <1385383327-28181-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1385383327-28181-1-git-send-email-lars@metafoo.de>
References: <1385383327-28181-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fixes the following warnings from sparse:
	drivers/iio/dac/ad5755.c:117:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5755.c:117:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5755.c:117:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5755.c:171:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5755.c:171:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5755.c:171:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5755.c:172:25: warning: incorrect type in assignment (different base types)
	drivers/iio/dac/ad5755.c:172:25:    expected unsigned int [unsigned] [usertype] d32
	drivers/iio/dac/ad5755.c:172:25:    got restricted __be32 [usertype] <noident>
	drivers/iio/dac/ad5755.c:176:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5755.c:176:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5755.c:176:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5755.c:176:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5755.c:176:23: warning: cast to restricted __be32
	drivers/iio/dac/ad5755.c:176:23: warning: cast to restricted __be32

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/dac/ad5755.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index 9a78d5a..bdf302d 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -97,7 +97,7 @@ struct ad5755_state {
 	 */
 
 	union {
-		u32 d32;
+		__be32 d32;
 		u8 d8[4];
 	} data[2] ____cacheline_aligned;
 };
-- 
1.8.0

