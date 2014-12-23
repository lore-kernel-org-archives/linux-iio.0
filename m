Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12998 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292AbaLWNVc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Dec 2014 08:21:32 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, knaack.h@gmx.de
Cc: lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 06/10] iio: imu: kmx61: Use false instead of 0 for ev_enable_state
Date: Tue, 23 Dec 2014 15:22:29 +0200
Message-Id: <1419340953-23161-7-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 332ee67..30825cf 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -976,7 +976,7 @@ static int kmx61_write_event_config(struct iio_dev *indio_dev,
 	mutex_lock(&data->lock);
 
 	if (!state && data->motion_trig_on) {
-		data->ev_enable_state = 0;
+		data->ev_enable_state = false;
 		goto err_unlock;
 	}
 
-- 
1.9.1

