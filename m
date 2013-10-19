Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:40637 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751549Ab3JSRRr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 19 Oct 2013 13:17:47 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, ldewangan@nvidia.com,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio: Correct description how to convert microtesla to gauss
Date: Sat, 19 Oct 2013 19:17:43 +0200
Message-Id: <1382203063-31141-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

this just fixes the comment; however, I'm not sure if the driver reports
measurements correctly; the raw values are 0.3 uT / LSB; IIO is supposed
to report magnetic fields in Gauss, so the scale should be around 1/300
(ignoring ASA) -- but value and scale are returned as VAL_INT

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 drivers/iio/magnetometer/ak8975.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 7105f22..ff284e5 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -263,7 +263,7 @@ static int ak8975_setup(struct i2c_client *client)
  *
  * HuT = H * 1229/4096, or roughly, 3/10.
  *
- * Since 1uT = 100 gauss, our final scale factor becomes:
+ * Since 1uT = 0.01 gauss, our final scale factor becomes:
  *
  * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
  * Hadj = H * ((ASA + 128) * 30 / 256
-- 
1.8.4.1

