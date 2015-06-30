Return-Path: <vlad.dogaru@intel.com>
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org,
	knaack.h@gmx.de
Cc: Vlad Dogaru <vlad.dogaru@intel.com>
Subject: [PATCH 1/2] iio: sx9500: rework error handling of raw readings
Date: Tue, 30 Jun 2015 14:20:58 +0300
Message-Id: <1435663259-21998-2-git-send-email-vlad.dogaru@intel.com>
In-Reply-To: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com>
References: <1435663259-21998-1-git-send-email-vlad.dogaru@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Fix error handling so that we can power the chip down even if a raw read
fails.

Reported-by: Hartmut Knaack <knaack.h@gmx.de>
Signed-off-by: Vlad Dogaru <vlad.dogaru@intel.com>
---
 drivers/iio/proximity/sx9500.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 2042e37..ba1cbbe 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -329,27 +329,29 @@ static int sx9500_read_proximity(struct sx9500_data *data,
 	else
 		ret = sx9500_wait_for_sample(data);
 
-	if (ret < 0)
-		return ret;
-
 	mutex_lock(&data->mutex);
 
-	ret = sx9500_read_prox_data(data, chan, val);
 	if (ret < 0)
-		goto out;
+		goto out_dec_data_rdy;
 
-	ret = sx9500_dec_chan_users(data, chan->channel);
+	ret = sx9500_read_prox_data(data, chan, val);
 	if (ret < 0)
-		goto out;
+		goto out_dec_data_rdy;
 
 	ret = sx9500_dec_data_rdy_users(data);
 	if (ret < 0)
+		goto out_dec_chan;
+
+	ret = sx9500_dec_chan_users(data, chan->channel);
+	if (ret < 0)
 		goto out;
 
 	ret = IIO_VAL_INT;
 
 	goto out;
 
+out_dec_data_rdy:
+	sx9500_dec_data_rdy_users(data);
 out_dec_chan:
 	sx9500_dec_chan_users(data, chan->channel);
 out:
-- 
1.9.1
