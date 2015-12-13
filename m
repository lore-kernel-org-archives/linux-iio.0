Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:38012 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbbLMNnX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2015 08:43:23 -0500
Date: Sun, 13 Dec 2015 16:43:17 +0300
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	ciorneiioana@gmail.com, cristina.moraru09@gmail.com,
	dan.carpenter@oracle.com, josselin.costanzi@mobile-devices.fr,
	bhaktipriya96@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Staging: iio: accel: Fixed NULL comparison style
Message-ID: <20151213134223.GA3495@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The variable u8 **rx_p, is a pointer-to-pointer and hence the check should
be "if (!*rx_p)" and not "if (!rx_p)".
In the earlier version, checkpatch.pl gave the following check, which was
buggy:
CHECK: Comparison to NULL could be written "!rx_p"
+       if (*rx_p == NULL) {

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 Changes in v2:
        -Replaced "if (!rx_p)" with "if (!*rx_p)"
 
 drivers/staging/iio/accel/sca3000_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 5339b10..1920dc60 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -48,7 +48,7 @@ static int sca3000_read_data(struct sca3000_state *st,
 		}
 	};
 	*rx_p = kmalloc(len, GFP_KERNEL);
-	if (!rx_p) {
+	if (!*rx_p) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-- 
2.1.4

