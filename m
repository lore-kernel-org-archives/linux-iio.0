Return-Path: <bhaktipriya96@gmail.com>
Date: Sun, 13 Dec 2015 18:15:13 +0300
From: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org, ciorneiioana@gmail.com,
	cristina.moraru09@gmail.com, dan.carpenter@oracle.com,
	josselin.costanzi@mobile-devices.fr, bhaktipriya96@gmail.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] Staging: iio: accel: Fixed NULL comparison style
Message-ID: <20151213151513.GA5059@Karyakshetra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The variable u8 **rx_p, is a pointer-to-pointer and hence the check
should
be "if (!*rx_p)" and not "if (!rx_p)".
In the earlier version, checkpatch.pl gave the following check, which
was incorrect:
CHECK: Comparison to NULL could be written "!rx_p"
+       if (*rx_p == NULL) {

Signed-off-by: Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
---
 Changes in v3:
        - Replaced "if (!rx_p)" with "if (!*rx_p)"
	- Changes are made on the original code

 drivers/staging/iio/accel/sca3000_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 20b878d..1920dc60 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -48,7 +48,7 @@ static int sca3000_read_data(struct sca3000_state *st,
 		}
 	};
 	*rx_p = kmalloc(len, GFP_KERNEL);
-	if (*rx_p == NULL) {
+	if (!*rx_p) {
 		ret = -ENOMEM;
 		goto error_ret;
 	}
-- 
2.1.4
