Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56890 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757064AbaGNUiq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Jul 2014 16:38:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: [PATCH 3/3] iio:bma180: Fix scale factors to report correct acceleration units
Date: Mon, 14 Jul 2014 22:38:38 +0200
Message-Id: <1405370318-19699-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The userspace interface for acceleration sensors is documented as using
m/s^2 units [Documentation/ABI/testing/sysfs-bus-iio]

The fullscale raw values for the BMA80 corresponds to -/+ 1, 1.5, 2, etc G
depending on the selected mode.

The scale table was converting to G rather than m/s^2.
Change the scaling table to match the documented interface.

See commit 71702e6e, iio: mma8452: Use correct acceleration units,
for a related fix.

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
---
 drivers/iio/accel/bma180.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index a7e68c8..b1c7ab4 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -74,7 +74,7 @@
 #define BMA180_FLP_FREQ_AVAILABLE \
 	"10 20 40 75 150 300"
 #define BMA180_SCALE_AVAILABLE \
-	"0.000130 0.000190 0.000250 0.000380 0.000500 0.000990 0.001980"
+	"0.001275 0.001863 0.002452 0.003727 0.004903 0.009709 0.019417"
 
 struct bma180_data {
 	struct i2c_client *client;
@@ -94,7 +94,7 @@ enum bma180_axis {
 };
 
 static int bw_table[] = { 10, 20, 40, 75, 150, 300 }; /* Hz */
-static int scale_table[] = { 130, 190, 250, 380, 500, 990, 1980 };
+static int scale_table[] = { 1275, 1863, 2452, 3727, 4903, 9709, 19417 };
 
 static int bma180_get_acc_reg(struct bma180_data *data, enum bma180_axis axis)
 {
-- 
1.9.1

