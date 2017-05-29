Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 23/38] iio:proximity: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Mon, 29 May 2017 16:51:39 +0100
Message-Id: <20170529155154.22580-24-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/proximity/as3935.c                    | 2 --
 drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 1 -
 drivers/iio/proximity/srf04.c                     | 1 -
 drivers/iio/proximity/srf08.c                     | 1 -
 drivers/iio/proximity/sx9500.c                    | 2 --
 5 files changed, 7 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index aa0d0be1a608..3b008af2e3aa 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -197,7 +197,6 @@ static int as3935_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info as3935_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &as3935_attribute_group,
 	.read_raw = &as3935_read_raw,
 };
@@ -223,7 +222,6 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
 }
 
 static const struct iio_trigger_ops iio_interrupt_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static void as3935_event_work(struct work_struct *work)
diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
index 36c1ddc251aa..4d56f67b24c6 100644
--- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
+++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
@@ -249,7 +249,6 @@ static irqreturn_t lidar_trigger_handler(int irq, void *private)
 }
 
 static const struct iio_info lidar_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = lidar_read_raw,
 };
 
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index e37667f933b3..09c7b9c095b0 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -203,7 +203,6 @@ static int srf04_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info srf04_iio_info = {
-	.driver_module		= THIS_MODULE,
 	.read_raw		= srf04_read_raw,
 };
 
diff --git a/drivers/iio/proximity/srf08.c b/drivers/iio/proximity/srf08.c
index 49316cbf7c60..ef7bd2b83a0e 100644
--- a/drivers/iio/proximity/srf08.c
+++ b/drivers/iio/proximity/srf08.c
@@ -329,7 +329,6 @@ static const struct iio_chan_spec srf08_channels[] = {
 static const struct iio_info srf08_info = {
 	.read_raw = srf08_read_raw,
 	.attrs = &srf08_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int srf08_probe(struct i2c_client *client,
diff --git a/drivers/iio/proximity/sx9500.c b/drivers/iio/proximity/sx9500.c
index 9ea147f1a50d..6905bd4ed4d5 100644
--- a/drivers/iio/proximity/sx9500.c
+++ b/drivers/iio/proximity/sx9500.c
@@ -615,7 +615,6 @@ static const struct attribute_group sx9500_attribute_group = {
 };
 
 static const struct iio_info sx9500_info = {
-	.driver_module = THIS_MODULE,
 	.attrs = &sx9500_attribute_group,
 	.read_raw = &sx9500_read_raw,
 	.write_raw = &sx9500_write_raw,
@@ -650,7 +649,6 @@ static int sx9500_set_trigger_state(struct iio_trigger *trig,
 
 static const struct iio_trigger_ops sx9500_trigger_ops = {
 	.set_trigger_state = sx9500_set_trigger_state,
-	.owner = THIS_MODULE,
 };
 
 static irqreturn_t sx9500_trigger_handler(int irq, void *private)
-- 
2.13.0
