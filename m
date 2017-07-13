Return-Path: <SRS0=xZFW=6Q=redhat.com=hdegoede@kernel.org>
From: Hans de Goede <hdegoede@redhat.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150: Always restore device to normal mode after suspend-resume
Date: Thu, 13 Jul 2017 15:13:41 +0200
Message-Id: <20170713131341.7585-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

After probe we would put the device in normal mode, after a runtime
suspend-resume we would put it back in normal mode. But for a regular
suspend-resume we would only put it back in normal mode if triggers
or events have been requested.  This is not consistent and breaks
reading raw values after a suspend-resume.

This commit changes the regular resume path to also unconditionally put
the device back in normal mode, fixing reading of raw values not working
after a regular suspend-resume cycle.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 6b5d3be283c4..807299dd45eb 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -193,7 +193,6 @@ struct bmc150_accel_data {
 	struct regmap *regmap;
 	int irq;
 	struct bmc150_accel_interrupt interrupts[BMC150_ACCEL_INTERRUPTS];
-	atomic_t active_intr;
 	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
 	struct mutex mutex;
 	u8 fifo_mode, watermark;
@@ -493,11 +492,6 @@ static int bmc150_accel_set_interrupt(struct bmc150_accel_data *data, int i,
 		goto out_fix_power_state;
 	}
 
-	if (state)
-		atomic_inc(&data->active_intr);
-	else
-		atomic_dec(&data->active_intr);
-
 	return 0;
 
 out_fix_power_state:
@@ -1710,8 +1704,7 @@ static int bmc150_accel_resume(struct device *dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
 	mutex_lock(&data->mutex);
-	if (atomic_read(&data->active_intr))
-		bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
+	bmc150_accel_set_mode(data, BMC150_ACCEL_SLEEP_MODE_NORMAL, 0);
 	bmc150_accel_fifo_set_mode(data);
 	mutex_unlock(&data->mutex);
 
-- 
2.13.0
