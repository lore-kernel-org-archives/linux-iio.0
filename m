Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:60030 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759911AbbAaAAf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 30 Jan 2015 19:00:35 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@linux.intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [PATCH v3 6/9] iio: bmc150: exit early if event / trigger state is not changed
Date: Sat, 31 Jan 2015 02:00:05 +0200
Message-Id: <1422662408-8149-7-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
References: <1422662408-8149-1-git-send-email-octavian.purdila@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Previous of this patch the check was only done if we enabled the event
and it was already enabled. We can do the same if the event is
disabled and we want to disable it.

The patch also adds the same check on the trigger code.

Signed-off-by: Octavian Purdila <octavian.purdila@intel.com>
---
 drivers/iio/accel/bmc150-accel.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 0873925..f040f40 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -748,7 +748,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state && data->ev_enable_state)
+	if (state == data->ev_enable_state)
 		return 0;
 
 	mutex_lock(&data->mutex);
@@ -984,6 +984,18 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
 	mutex_lock(&data->mutex);
 
+	if (data->motion_trig == trig) {
+		if (data->motion_trigger_on == state) {
+			mutex_unlock(&data->mutex);
+			return 0;
+		}
+	} else {
+		if (data->dready_trigger_on == state) {
+			mutex_unlock(&data->mutex);
+			return 0;
+		}
+	}
+
 	if (!state && data->ev_enable_state && data->motion_trigger_on) {
 		data->motion_trigger_on = false;
 		mutex_unlock(&data->mutex);
-- 
1.9.1

