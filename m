Return-Path: <SRS0=8F20=CU=canonical.com=colin.king@kernel.org>
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
	linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: remove redundant pointer pdata
Date: Wed, 22 Nov 2017 14:32:11 +0000
Message-Id: <20171122143211.30651-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-iio@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Pointer pdata is being assigned but it is never being used, hence
it is redundant and can be removed. Cleans up clang warning:

drivers/iio/accel/st_accel_core.c:952:3: warning: Value stored to 'pdata'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/accel/st_accel_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 460aa58e0159..6fe995cf16a6 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -920,8 +920,6 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
-	struct st_sensors_platform_data *pdata =
-		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq = adata->get_irq_data_ready(indio_dev);
 	int err;
 
@@ -948,9 +946,6 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 					&adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!pdata)
-		pdata = (struct st_sensors_platform_data *)&default_accel_pdata;
-
 	err = st_sensors_init_sensor(indio_dev, adata->dev->platform_data);
 	if (err < 0)
 		goto st_accel_power_off;
-- 
2.14.1
