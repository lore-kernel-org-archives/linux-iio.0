Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 17 May 2016 10:31:33 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Tiberiu Breana <tiberiu.a.breana@intel.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [patch] iio: humidity: Remove a stray unlock
Message-ID: <20160517073133.GA10872@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

We haven't taken the lock yet so we don't need to unlock here.

Fixes: 0d96d5ead3f7 ('iio: humidity: Add triggered buffer support for AM2315')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

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
