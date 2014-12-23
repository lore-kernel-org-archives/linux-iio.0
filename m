Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12998 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753650AbaLWNVV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Dec 2014 08:21:21 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, knaack.h@gmx.de
Cc: lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 01/10] iio: imu: kmx61: Save odr_bits for later use
Date: Tue, 23 Dec 2014 15:22:24 +0200
Message-Id: <1419340953-23161-2-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 972424b..fe0cee7 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -465,6 +465,8 @@ static int kmx61_set_odr(struct kmx61_data *data, int val, int val2, u8 device)
 	if (ret < 0)
 		return ret;
 
+	data->odr_bits = odr_bits;
+
 	if (device & KMX61_ACC) {
 		ret = kmx61_set_wake_up_odr(data, val, val2);
 		if (ret)
-- 
1.9.1

