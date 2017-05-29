Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 29/38] staging:iio:frequency: drop assign iio_info.driver_module
Date: Mon, 29 May 2017 16:51:45 +0100
Message-Id: <20170529155154.22580-30-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent of this is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/frequency/ad9832.c | 1 -
 drivers/staging/iio/frequency/ad9834.c | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 6da46ede7ee0..c73eff1f8d73 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -290,7 +290,6 @@ static const struct attribute_group ad9832_attribute_group = {
 
 static const struct iio_info ad9832_info = {
 	.attrs = &ad9832_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad9832_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 995acdd7c942..4c6d4043903e 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -381,12 +381,10 @@ static const struct attribute_group ad9833_attribute_group = {
 
 static const struct iio_info ad9834_info = {
 	.attrs = &ad9834_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_info ad9833_info = {
 	.attrs = &ad9833_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad9834_probe(struct spi_device *spi)
-- 
2.13.0
