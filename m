Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu1sys200aog102.obsmtp.com ([207.126.144.113]:46860 "EHLO
	eu1sys200aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751993Ab3BZKo1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Feb 2013 05:44:27 -0500
From: Denis CIOCCA <denis.ciocca@st.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org, fengguang.wu@intel.com,
	Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:common: fixed all warning messages about uninitialized variables
Date: Tue, 26 Feb 2013 11:43:46 +0100
Message-Id: <1361875426-5626-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1361875426-5626-1-git-send-email-denis.ciocca@st.com>
References: <1361875426-5626-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Reported-by: Fengguang Wu <fengguang.wu@intel.com>
---
 drivers/iio/common/st_sensors/st_sensors_core.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 0198324..bd33473 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -62,7 +62,7 @@ st_sensors_match_odr_error:
 int st_sensors_set_odr(struct iio_dev *indio_dev, unsigned int odr)
 {
 	int err;
-	struct st_sensor_odr_avl odr_out;
+	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	err = st_sensors_match_odr(sdata->sensor, odr, &odr_out);
@@ -114,7 +114,7 @@ st_sensors_match_odr_error:
 
 static int st_sensors_set_fullscale(struct iio_dev *indio_dev, unsigned int fs)
 {
-	int err, i;
+	int err, i = 0;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	err = st_sensors_match_fs(sdata->sensor, fs, &i);
@@ -139,14 +139,13 @@ st_accel_set_fullscale_error:
 
 int st_sensors_set_enable(struct iio_dev *indio_dev, bool enable)
 {
-	bool found;
 	u8 tmp_value;
 	int err = -EINVAL;
-	struct st_sensor_odr_avl odr_out;
+	bool found = false;
+	struct st_sensor_odr_avl odr_out = {0, 0};
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
 	if (enable) {
-		found = false;
 		tmp_value = sdata->sensor->pw.value_on;
 		if ((sdata->sensor->odr.addr == sdata->sensor->pw.addr) &&
 			(sdata->sensor->odr.mask == sdata->sensor->pw.mask)) {
-- 
1.7.9.5

