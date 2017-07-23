Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55668 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755393AbdGWQ0q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Jul 2017 12:26:46 -0400
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: linux-iio@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH 33/45] staging:iio:meter: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Sun, 23 Jul 2017 17:26:15 +0100
Message-Id: <20170723162627.22534-34-Jonathan.Cameron@huawei.com>
In-Reply-To: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
References: <20170723162627.22534-1-Jonathan.Cameron@huawei.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/staging/iio/meter/ade7753.c         | 1 -
 drivers/staging/iio/meter/ade7754.c         | 1 -
 drivers/staging/iio/meter/ade7758_core.c    | 1 -
 drivers/staging/iio/meter/ade7758_trigger.c | 1 -
 drivers/staging/iio/meter/ade7759.c         | 1 -
 drivers/staging/iio/meter/ade7854.c         | 1 -
 6 files changed, 6 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index ce26abdeab92..98993f8b85bf 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -561,7 +561,6 @@ static const struct attribute_group ade7753_attribute_group = {
 
 static const struct iio_info ade7753_info = {
 	.attrs = &ade7753_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ade7753_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index be0df3fe4230..3a1e342d75fb 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -601,7 +601,6 @@ static const struct attribute_group ade7754_attribute_group = {
 
 static const struct iio_info ade7754_info = {
 	.attrs = &ade7754_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ade7754_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 40498af4dc46..7b7ffe5ed186 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -827,7 +827,6 @@ static const struct iio_info ade7758_info = {
 	.attrs = &ade7758_attribute_group,
 	.read_raw = &ade7758_read_raw,
 	.write_raw = &ade7758_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ade7758_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/meter/ade7758_trigger.c b/drivers/staging/iio/meter/ade7758_trigger.c
index 5b35a7f08f4f..1f0d1a0cf889 100644
--- a/drivers/staging/iio/meter/ade7758_trigger.c
+++ b/drivers/staging/iio/meter/ade7758_trigger.c
@@ -53,7 +53,6 @@ static int ade7758_trig_try_reen(struct iio_trigger *trig)
 }
 
 static const struct iio_trigger_ops ade7758_trigger_ops = {
-	.owner = THIS_MODULE,
 	.set_trigger_state = &ade7758_data_rdy_trigger_set_state,
 	.try_reenable = &ade7758_trig_try_reen,
 };
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 1691760339da..7639e90d1c94 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -493,7 +493,6 @@ static const struct attribute_group ade7759_attribute_group = {
 
 static const struct iio_info ade7759_info = {
 	.attrs = &ade7759_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ade7759_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
index 70612da64a8b..90d07cdca4b8 100644
--- a/drivers/staging/iio/meter/ade7854.c
+++ b/drivers/staging/iio/meter/ade7854.c
@@ -530,7 +530,6 @@ static const struct attribute_group ade7854_attribute_group = {
 
 static const struct iio_info ade7854_info = {
 	.attrs = &ade7854_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
-- 
2.13.3

