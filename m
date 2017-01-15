Return-Path: <SRS0=FTiJ=Y5=gmail.com=amsfield22@kernel.org>
Date: Sat, 14 Jan 2017 19:52:50 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: afd@ti.com, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: health: afe4404: retrieve a valid iio_dev in
 suspend/resume
Message-ID: <20170115035241.GA19555@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

The suspend/resume functions were using dev_to_iio_dev() to get
the iio_dev. That only works on IIO dev's.  Replace it with i2c
functions to get the correct iio_dev.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/health/afe4404.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 4526640..964f523 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -428,7 +428,7 @@ MODULE_DEVICE_TABLE(of, afe4404_of_match);
 
 static int __maybe_unused afe4404_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret;
 
@@ -449,7 +449,7 @@ static int __maybe_unused afe4404_suspend(struct device *dev)
 
 static int __maybe_unused afe4404_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
 	struct afe4404_data *afe = iio_priv(indio_dev);
 	int ret;
 
-- 
2.1.4
