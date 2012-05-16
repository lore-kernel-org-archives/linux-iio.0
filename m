Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:56425 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751743Ab2EPQXq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 16 May 2012 12:23:46 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/9] iio: change strict_strtoul() to kstrtoul() in hmc5843
Date: Wed, 16 May 2012 18:22:04 +0200
Message-Id: <1337185331-26616-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1337185331-26616-1-git-send-email-pmeerw@pmeerw.net>
References: <1337185331-26616-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/magnetometer/hmc5843.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/hmc5843.c b/drivers/staging/iio/magnetometer/hmc5843.c
index 9725cf8..018d3d8 100644
--- a/drivers/staging/iio/magnetometer/hmc5843.c
+++ b/drivers/staging/iio/magnetometer/hmc5843.c
@@ -202,7 +202,7 @@ static ssize_t hmc5843_set_operating_mode(struct device *dev,
 	s32 status;
 	int error;
 	mutex_lock(&data->lock);
-	error = strict_strtoul(buf, 10, &operating_mode);
+	error = kstrtoul(buf, 10, &operating_mode);
 	if (error) {
 		count = error;
 		goto exit;
@@ -275,7 +275,7 @@ static ssize_t hmc5843_set_measurement_configuration(struct device *dev,
 	struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
 	struct hmc5843_data *data = iio_priv(indio_dev);
 	unsigned long meas_conf = 0;
-	int error = strict_strtoul(buf, 10, &meas_conf);
+	int error = kstrtoul(buf, 10, &meas_conf);
 	if (error)
 		return error;
 	mutex_lock(&data->lock);
@@ -425,7 +425,7 @@ static ssize_t set_range(struct device *dev,
 	unsigned long range = 0;
 	int error;
 	mutex_lock(&data->lock);
-	error = strict_strtoul(buf, 10, &range);
+	error = kstrtoul(buf, 10, &range);
 	if (error) {
 		count = error;
 		goto exit;
-- 
1.7.5.4

