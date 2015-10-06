Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42997 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbbJFSbr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 6 Oct 2015 14:31:47 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio @ vger . kernel . org" <linux-iio@vger.kernel.org>,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH] iio: bmc150: Fix type of step transfer variable
Date: Tue,  6 Oct 2015 20:31:39 +0200
Message-Id: <1444156299-14316-1-git-send-email-mpa@pengutronix.de>
In-Reply-To: <201510032331.iV9fviPZ%fengguang.wu@intel.com>
References: <201510032331.iV9fviPZ%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

regmap_get_raw_read_max() returns type size_t. Also the later dev_err()
already uses the correct printk format "%zu".

This patch changes the type of 'step' to size_t.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
Hi,

this problem was reported by the kbuild robot. This should fix the warning. I
am not sure if the patches are already in some public tree, otherwise this
could directly be squashed into the commit directly.

Thanks,

Markus


 drivers/iio/accel/bmc150-accel-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 614cf61f0110..dc89cf8b7603 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -891,7 +891,7 @@ static int bmc150_accel_fifo_transfer(struct bmc150_accel_data *data,
 	int ret;
 	int total_length = samples * sample_length;
 	int i;
-	int step = regmap_get_raw_read_max(data->regmap);
+	size_t step = regmap_get_raw_read_max(data->regmap);
 
 	if (!step || step > total_length)
 		step = total_length;
-- 
2.6.0

