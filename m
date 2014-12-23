Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:12998 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932356AbaLWNVl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Dec 2014 08:21:41 -0500
From: Daniel Baluta <daniel.baluta@intel.com>
To: jic23@kernel.org, knaack.h@gmx.de
Cc: lars@metafoo.de, pmeerw@pmeerw.net, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com
Subject: [PATCH 10/10] iio: imu: kmx61: Use correct base when reading data
Date: Tue, 23 Dec 2014 15:22:33 +0200
Message-Id: <1419340953-23161-11-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We have two IIO devices and we need to adjust the base
when reading data.

Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
---
 drivers/iio/imu/kmx61.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 98369eb..6178cea 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -1210,12 +1210,18 @@ static irqreturn_t kmx61_trigger_handler(int irq, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct kmx61_data *data = kmx61_get_data(indio_dev);
 	int bit, ret, i = 0;
+	u8 base;
 	s16 buffer[8];
 
+	if (indio_dev == data->acc_indio_dev)
+		base = KMX61_ACC_XOUT_L;
+	else
+		base = KMX61_MAG_XOUT_L;
+
 	mutex_lock(&data->lock);
 	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
 			 indio_dev->masklength) {
-		ret = kmx61_read_measurement(data, KMX61_ACC_XOUT_L, bit);
+		ret = kmx61_read_measurement(data, base, bit);
 		if (ret < 0) {
 			mutex_unlock(&data->lock);
 			goto err;
-- 
1.9.1

