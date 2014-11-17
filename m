Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:23632 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751625AbaKQSFM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 17 Nov 2014 13:05:12 -0500
From: Octavian Purdila <octavian.purdila@intel.com>
To: linux-iio@vger.kernel.org
Cc: srinivas.pandruvada@intel.com,
	Octavian Purdila <octavian.purdila@intel.com>
Subject: [RFC 4/8] iio: bmc150: exit early if event / trigger state is not changed
Date: Mon, 17 Nov 2014 19:56:02 +0200
Message-Id: <1416246966-3083-5-git-send-email-octavian.purdila@intel.com>
In-Reply-To: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
References: <1416246966-3083-1-git-send-email-octavian.purdila@intel.com>
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
index ee4afc4..30d7bcd 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -766,7 +766,7 @@ static int bmc150_accel_write_event_config(struct iio_dev *indio_dev,
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret;
 
-	if (state && data->ev_enable_state)
+	if (state == data->ev_enable_state)
 		return 0;
 
 	mutex_lock(&data->mutex);
@@ -1002,6 +1002,18 @@ static int bmc150_accel_data_rdy_trigger_set_state(struct iio_trigger *trig,
 
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

