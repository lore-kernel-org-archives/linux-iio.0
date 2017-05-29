Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36889 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751080AbdE2PwM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 11:52:12 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/38] iio:chemical: drop assign iio_info.driver_module and iio_trigger_ops.owner
Date: Mon, 29 May 2017 16:51:23 +0100
Message-Id: <20170529155154.22580-8-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The equivalent of both of these are now done via macro magic when
the relevant register calls are made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/chemical/ams-iaq-core.c    | 1 -
 drivers/iio/chemical/atlas-ph-sensor.c | 2 --
 drivers/iio/chemical/vz89x.c           | 1 -
 3 files changed, 4 deletions(-)

diff --git a/drivers/iio/chemical/ams-iaq-core.c b/drivers/iio/chemical/ams-iaq-core.c
index c948ad2ee9ad..d9e5950ad24a 100644
--- a/drivers/iio/chemical/ams-iaq-core.c
+++ b/drivers/iio/chemical/ams-iaq-core.c
@@ -141,7 +141,6 @@ static int ams_iaqcore_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ams_iaqcore_info = {
 	.read_raw	= ams_iaqcore_read_raw,
-	.driver_module	= THIS_MODULE,
 };
 
 static int ams_iaqcore_probe(struct i2c_client *client,
diff --git a/drivers/iio/chemical/atlas-ph-sensor.c b/drivers/iio/chemical/atlas-ph-sensor.c
index ef761a508630..8c4e05580091 100644
--- a/drivers/iio/chemical/atlas-ph-sensor.c
+++ b/drivers/iio/chemical/atlas-ph-sensor.c
@@ -344,7 +344,6 @@ static int atlas_buffer_predisable(struct iio_dev *indio_dev)
 }
 
 static const struct iio_trigger_ops atlas_interrupt_trigger_ops = {
-	.owner = THIS_MODULE,
 };
 
 static const struct iio_buffer_setup_ops atlas_buffer_setup_ops = {
@@ -499,7 +498,6 @@ static int atlas_write_raw(struct iio_dev *indio_dev,
 }
 
 static const struct iio_info atlas_info = {
-	.driver_module = THIS_MODULE,
 	.read_raw = atlas_read_raw,
 	.write_raw = atlas_write_raw,
 };
diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
index f75eea6822f2..9c9095ba4227 100644
--- a/drivers/iio/chemical/vz89x.c
+++ b/drivers/iio/chemical/vz89x.c
@@ -326,7 +326,6 @@ static int vz89x_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info vz89x_info = {
 	.attrs		= &vz89x_attrs_group,
 	.read_raw	= vz89x_read_raw,
-	.driver_module	= THIS_MODULE,
 };
 
 static const struct vz89x_chip_data vz89x_chips[] = {
-- 
2.13.0

