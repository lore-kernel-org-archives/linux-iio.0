Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:59024 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753698Ab2EQA3o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 May 2012 20:29:44 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 8/9] iio: reorganize hmc5843_set_rate()
Date: Thu, 17 May 2012 02:28:12 +0200
Message-Id: <1337214493-28773-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1337214493-28773-1-git-send-email-pmeerw@pmeerw.net>
References: <1337214493-28773-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 2e1bc6c..97cfac7 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -343,12 +343,13 @@ static s32 hmc5843_set_rate(struct i2c_client *client,
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	u8 reg_val;
 
-	reg_val = (data->meas_conf) |  (rate << HMC5843_RATE_OFFSET);
 	if (rate >= HMC5843_RATE_NOT_USED) {
 		dev_err(&client->dev,
 			"data output rate is not supported\n");
 		return -EINVAL;
 	}
+
+	reg_val = data->meas_conf | (rate << HMC5843_RATE_OFFSET);
 	return i2c_smbus_write_byte_data(client, HMC5843_CONFIG_REG_A, reg_val);
 }
 
-- 
1.7.5.4

