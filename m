Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12998 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755909AbaLWNVa (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Dec 2014 08:21:30 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, knaack.h@gmx.de
Cc: lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 05/10] iio: imu: kmx61: Drop unused device parameter
Date: Tue, 23 Dec 2014 15:22:28 +0200
Message-Id: <1419340953-23161-6-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 2652179..332ee67 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -681,7 +681,7 @@ static int kmx61_chip_update_thresholds(struct kmx61_data *data)
 }
 
 static int kmx61_setup_any_motion_interrupt(struct kmx61_data *data,
-					    bool status, u8 device)
+					    bool status)
 {
 	u8 mode;
 	int ret;
@@ -984,7 +984,7 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	if (ret < 0)
 		goto err_unlock;
 
-	ret = kmx61_setup_any_motion_interrupt(data, state, KMX61_ACC);
+	ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, KMX61_ACC);
 		goto err_unlock;
@@ -1070,7 +1070,7 @@ static int kmx61_data_rdy_trigger_set_state(struct iio_trigger *trig,
 	if (data->acc_dready_trig == trig || data->mag_dready_trig == trig)
 		ret = kmx61_setup_new_data_interrupt(data, state, device);
 	else
-		ret = kmx61_setup_any_motion_interrupt(data, state, KMX61_ACC);
+		ret = kmx61_setup_any_motion_interrupt(data, state);
 	if (ret < 0) {
 		kmx61_set_power_state(data, false, device);
 		goto err_unlock;
-- 
1.9.1

