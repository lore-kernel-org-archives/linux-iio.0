Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 17 May 2016 11:02:56 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch v2] iio: humidity: am2315: Remove a stray unlock
Message-ID: <20160517080256.GC11011@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4586F61A4A291F4DA44D32824E7C0F4023597A48@IRSMSX109.ger.corp.intel.com>
List-ID: <linux-iio@vger.kernel.org>

We haven't taken the lock yet so we don't need to unlock here.

Fixes: 0d96d5ead3f7 ('iio: humidity: Add triggered buffer support for AM2315')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
---
v2: update subject

diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
index 3be6d20..1153591 100644
--- a/drivers/iio/humidity/am2315.c
+++ b/drivers/iio/humidity/am2315.c
@@ -165,10 +165,8 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
 	struct am2315_sensor_data sensor_data;
 
 	ret = am2315_read_data(data, &sensor_data);
-	if (ret < 0) {
-		mutex_unlock(&data->lock);
+	if (ret < 0)
 		goto err;
-	}
 
 	mutex_lock(&data->lock);
 	if (*(indio_dev->active_scan_mask) == AM2315_ALL_CHANNEL_MASK) {
