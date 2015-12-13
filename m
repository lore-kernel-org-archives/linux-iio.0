Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36503 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbLMJyd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2015 04:54:33 -0500
Date: Sun, 13 Dec 2015 12:54:27 +0300
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	ciorneiioana@gmail.com, cristina.moraru09@gmail.com,
	dan.carpenter@oracle.com, josselin.costanzi@mobile-devices.fr,
	bhaktipriya96@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: iio: accel: Fixed NULL comparison style
Message-ID: <20151213095427.GA6159@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch fixes checkpatch.pl check:
CHECK: Comparison to NULL could be written "!rx_p"
+       if (*rx_p == NULL) {

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 drivers/staging/iio/accel/sca3000_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 20b878d..5339b10 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -48,7 +48,7 @@ static int sca3000_read_data(struct sca3000_state *st,
 		}
 	};
 	*rx_p = kmalloc(len, GFP_KERNEL);
-	if (*rx_p == NULL) {
+	if (!rx_p) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-- 
2.1.4

