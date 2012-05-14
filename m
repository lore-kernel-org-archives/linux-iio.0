Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:42429 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932598Ab2ENW3B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 14 May 2012 18:29:01 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, jic23@kernel.org, marek.belisko@gmail.com,
	shubhrajyoti@ti.com, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 5/9] iio: add check for measurement configuration value passed to hmc5843
Date: Tue, 15 May 2012 00:27:30 +0200
Message-Id: <1337034454-29717-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1337034454-29717-1-git-send-email-pmeerw@pmeerw.net>
References: <1337034454-29717-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 6888e04..57ab4fb 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -281,9 +281,14 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long meas_conf = 0;
-	int error = kstrtoul(buf, 10, &meas_conf);
+	int error;
+
+	error = kstrtoul(buf, 10, &meas_conf);
 	if (error)
 		return error;
+	if (meas_conf >= HMC5843_MEAS_CONF_NOT_USED)
+		return -EINVAL;
+
 	mutex_lock(&data->lock);
 
 	dev_dbg(dev, "set mode to %lu\n", meas_conf);
-- 
1.7.5.4

