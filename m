Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 33/38] iio:resolver: drop assignment of iio_info.driver_module
Date: Mon, 29 May 2017 16:51:49 +0100
Message-Id: <20170529155154.22580-34-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

The equivalent is now done via macro magic when
the relevant register call is made.  The actual structure
elements will shortly go away.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/resolver/ad2s1200.c | 1 -
 drivers/staging/iio/resolver/ad2s1210.c | 1 -
 drivers/staging/iio/resolver/ad2s90.c   | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1200.c b/drivers/staging/iio/resolver/ad2s1200.c
index a37e199225f4..aa62c64e9bc4 100644
--- a/drivers/staging/iio/resolver/ad2s1200.c
+++ b/drivers/staging/iio/resolver/ad2s1200.c
@@ -98,7 +98,6 @@ static const struct iio_chan_spec ad2s1200_channels[] = {
 
 static const struct iio_info ad2s1200_info = {
 	.read_raw = ad2s1200_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad2s1200_probe(struct spi_device *spi)
diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index a6a8393d6664..e27f559f3535 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -638,7 +638,6 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
 static const struct iio_info ad2s1210_info = {
 	.read_raw = ad2s1210_read_raw,
 	.attrs = &ad2s1210_attribute_group,
-	.driver_module = THIS_MODULE,
 };
 
 static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index b2270908f26f..59586947a936 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -48,7 +48,6 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info ad2s90_info = {
 	.read_raw = ad2s90_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 static const struct iio_chan_spec ad2s90_chan = {
-- 
2.13.0
