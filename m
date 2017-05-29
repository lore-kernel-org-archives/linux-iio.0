Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 31/38] staging:iio:ad5933: drop assign iio_info.driver_module
Date: Mon, 29 May 2017 16:51:47 +0100
Message-Id: <20170529155154.22580-32-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/impedance-analyzer/ad5933.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 3d539eeb0e26..2b28fb9c0048 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -575,7 +575,6 @@ static int ad5933_read_raw(struct iio_dev *indio_dev,
 static const struct iio_info ad5933_info = {
 	.read_raw = ad5933_read_raw,
 	.attrs = &ad5933_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad5933_ring_preenable(struct iio_dev *indio_dev)
-- 
2.13.0
