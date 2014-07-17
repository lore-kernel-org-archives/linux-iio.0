Return-Path: <srinivas.pandruvada@linux.intel.com>
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 6/6] iio: accel: kxcjk-1013: Increment ref counter for indio_dev->trig
Date: Wed, 16 Jul 2014 17:42:34 -0700
Message-Id: <1405557754-19601-6-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

Assigning indio_dev->trig is not a good idea, as this can result in
wrong reference count for trigger device. If assigned, it is better to
increment reference counter by calling iio_trigger_get.
Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
with Jonathan.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/accel/kxcjk-1013.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index f5bb682..40ecf8b 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1020,6 +1020,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 		iio_trigger_set_drvdata(trig, indio_dev);
 		data->trig = trig;
 		indio_dev->trig = trig;
+		iio_trigger_get(indio_dev->trig);
 
 		ret = iio_trigger_register(trig);
 		if (ret)
-- 
1.7.11.7
