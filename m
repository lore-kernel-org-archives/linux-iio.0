Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18599 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754991AbaGQAhB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 Jul 2014 20:37:01 -0400
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/6] iio: accel: kxcjk-1013: Fix setting frequency
Date: Wed, 16 Jul 2014 17:42:29 -0700
Message-Id: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix issue with setting of 12.5 and 6.25 HZ. The match of val2 fails.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 72a6dbb..4702aeb 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -98,7 +98,7 @@ static const struct {
 	int val2;
 	int odr_bits;
 } samp_freq_table[] = { {0, 781000, 0x08}, {1, 563000, 0x09},
-			{3, 125000, 0x0A}, {6, 25000, 0x0B}, {12, 5000, 0},
+			{3, 125000, 0x0A}, {6, 250000, 0x0B}, {12, 500000, 0},
 			{25, 0, 0x01}, {50, 0, 0x02}, {100, 0, 0x03},
 			{200, 0, 0x04}, {400, 0, 0x05}, {800, 0, 0x06},
 			{1600, 0, 0x07} };
-- 
1.7.11.7

