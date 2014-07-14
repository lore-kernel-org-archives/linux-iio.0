Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56884 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757046AbaGNUiq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 Jul 2014 16:38:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 1/3] iio:kxcjk-1013: Correct error messages
Date: Mon, 14 Jul 2014 22:38:36 +0200
Message-Id: <1405370318-19699-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 72a6dbb..a11588c 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -144,7 +144,7 @@ static int kxcjk1013_chip_ack_intr(struct kxcjk1013_data *data)
 
 	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error writing reg_int_rel\n");
+		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
 		return ret;
 	}
 
@@ -183,7 +183,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
 	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL1,
 					ret);
 	if (ret < 0) {
-		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
+		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
 		return ret;
 	}
 
@@ -337,7 +337,7 @@ static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
 	ret = i2c_smbus_read_word_data(data->client, reg);
 	if (ret < 0) {
 		dev_err(&data->client->dev,
-			"failed to read accel_%c registers\n", 'x' + axis);
+			"failed to read accel_%c register\n", 'x' + axis);
 		return ret;
 	}
 
-- 
1.9.1

