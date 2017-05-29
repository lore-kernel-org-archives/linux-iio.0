Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 28/38] staging:iio:cdc: drop assign iio_info.driver_module
Date: Mon, 29 May 2017 16:51:44 +0100
Message-Id: <20170529155154.22580-29-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/cdc/ad7150.c | 1 -
 drivers/staging/iio/cdc/ad7152.c | 1 -
 drivers/staging/iio/cdc/ad7746.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7150.c b/drivers/staging/iio/cdc/ad7150.c
index a6f249e9c1e1..2fe916c48848 100644
--- a/drivers/staging/iio/cdc/ad7150.c
+++ b/drivers/staging/iio/cdc/ad7150.c
@@ -569,7 +569,6 @@ static const struct attribute_group ad7150_event_attribute_group = {
 
 static const struct iio_info ad7150_info = {
 	.event_attrs = &ad7150_event_attribute_group,
-	.driver_module = THIS_MODULE,
 	.read_raw = &ad7150_read_raw,
 	.read_event_config = &ad7150_read_event_config,
 	.write_event_config = &ad7150_write_event_config,
diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index dc6ecd824365..ac7b724ddde5 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -445,7 +445,6 @@ static const struct iio_info ad7152_info = {
 	.read_raw = ad7152_read_raw,
 	.write_raw = ad7152_write_raw,
 	.write_raw_get_fmt = ad7152_write_raw_get_fmt,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec ad7152_channels[] = {
diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index cdcb4fccf3fe..a124853a05f0 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -667,7 +667,6 @@ static const struct iio_info ad7746_info = {
 	.attrs = &ad7746_attribute_group,
 	.read_raw = ad7746_read_raw,
 	.write_raw = ad7746_write_raw,
-	.driver_module = THIS_MODULE,
 };
 
 /*
-- 
2.13.0
