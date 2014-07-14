Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56888 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757061AbaGNUiq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Jul 2014 16:38:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/3] iio:kxcjk-1013: Fix endianness in scan_type
Date: Mon, 14 Jul 2014 22:38:37 +0200
Message-Id: <1405370318-19699-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

driver uses i2c_smbus_read_word_data() to the data in the trigger handler and hence
already does endianness conversion; the I2C chip has data in little endian, but the
value is provides in CPU endianness

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index a11588c..ea96170 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -466,7 +466,7 @@ static const struct attribute_group kxcjk1013_attrs_group = {
 		.realbits = 12,						\
 		.storagebits = 16,					\
 		.shift = 4,						\
-		.endianness = IIO_LE,					\
+		.endianness = IIO_CPU,					\
 	},								\
 }
 
-- 
1.9.1

