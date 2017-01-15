Return-Path: <SRS0=FTiJ=Y5=gmail.com=amsfield22@kernel.org>
Date: Sat, 14 Jan 2017 19:51:52 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: afd@ti.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: health: afe4403: retrieve a valid iio_dev in
 suspend/resume
Message-ID: <20170115035141.GA19547@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The suspend/resume functions were using dev_to_iio_dev() to get
the iio_dev. That only works on IIO dev's.  Replace it with spi
functions to get the correct iio_dev.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/health/afe4403.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 9a08146..6bb23a4 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -422,7 +422,7 @@ MODULE_DEVICE_TABLE(of, afe4403_of_match);
 
 static int __maybe_unused afe4403_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	int ret;
 
@@ -443,7 +443,7 @@ static int __maybe_unused afe4403_suspend(struct device *dev)
 
 static int __maybe_unused afe4403_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = spi_get_drvdata(to_spi_device(dev));
 	struct afe4403_data *afe = iio_priv(indio_dev);
 	int ret;
 
-- 
2.1.4
