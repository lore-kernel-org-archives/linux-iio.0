Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mta1.parkeon.com ([91.121.43.66]:43138 "EHLO mta1.parkeon.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753670AbaGKN1k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 11 Jul 2014 09:27:40 -0400
Subject: [PATCH] iio: mma8452: Use correct acceleration units.
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Fri, 11 Jul 2014 14:54:31 +0200
Message-ID: <20140711125431.22109.59659.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The userspace interface for acceleration sensors is documented as using
m/s^2 units [Documentation/ABI/testing/sysfs-bus-iio]

The fullscale raw value for the mma8452 (-2048) corresponds to -2G, -4G or -8G
depending on the seleted mode.

The scale table was converting to G rather than m/s^2.
Change the scaling table to match the documented interface.

Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
---
 drivers/iio/accel/mma8452.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 17aeea1..61eba5a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -111,8 +111,13 @@ static const int mma8452_samp_freq[8][2] = {
 	{6, 250000}, {1, 560000}
 };
 
+/* Hardware has fullscale of -2G, -4G, -8G corresponding to raw value -2048
+ * The userspace interface uses m/s^2 and we declare micro units
+ * So scale factor is given by:
+ * 	g * N * 1000000 / 2048 for N = 2, 4, 8 and g=9.80665
+ */
 static const int mma8452_scales[3][2] = {
-	{0, 977}, {0, 1953}, {0, 3906}
+	{0, 9577}, {0, 19154}, {0, 38307}
 };
 
 static ssize_t mma8452_show_samp_freq_avail(struct device *dev,

