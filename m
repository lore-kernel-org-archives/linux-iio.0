Return-Path: <SRS0=UbNB=62=huawei.com=Jonathan.Cameron@kernel.org>
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 15/45] iio:health: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:25:57 +0100
Message-Id: <20170723162627.22534-16-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/health/afe4403.c  | 2 --
 drivers/iio/health/afe4404.c  | 2 --
 drivers/iio/health/max30100.c | 1 -
 drivers/iio/health/max30102.c | 1 -
 4 files changed, 6 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 6bb23a49e81e..a739fff01c6b 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -309,7 +309,6 @@ static const struct iio_info afe4403_iio_info = {
 	.attrs = &afe440x_attribute_group,
 	.read_raw = afe4403_read_raw,
 	.write_raw = afe4403_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t afe4403_trigger_handler(int irq, void *private)
@@ -354,7 +353,6 @@ static irqreturn_t afe4403_trigger_handler(int irq, void *private)
 }
 
 static const struct iio_trigger_ops afe4403_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 #define AFE4403_TIMING_PAIRS			\
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 964f5231a831..11910922e655 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -328,7 +328,6 @@ static const struct iio_info afe4404_iio_info = {
 	.attrs = &afe440x_attribute_group,
 	.read_raw = afe4404_read_raw,
 	.write_raw = afe4404_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static irqreturn_t afe4404_trigger_handler(int irq, void *private)
@@ -355,7 +354,6 @@ static irqreturn_t afe4404_trigger_handler(int irq, void *private)
 }
 
 static const struct iio_trigger_ops afe4404_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 /* Default timings from data-sheet */
diff --git a/drivers/iio/health/max30100.c b/drivers/iio/health/max30100.c
index 849d71747f9f..91aef5df24a1 100644
--- a/drivers/iio/health/max30100.c
+++ b/drivers/iio/health/max30100.c
@@ -420,7 +420,6 @@ static int max30100_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info max30100_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = max30100_read_raw,
 };
 
diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 839b875c29b9..203ffb9cad6a 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -381,7 +381,6 @@ static int max30102_read_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info max30102_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = max30102_read_raw,
 };
 
-- 
2.13.3
