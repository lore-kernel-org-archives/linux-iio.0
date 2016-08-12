Return-Path: <jarkko.nikula@linux.intel.com>
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] iio: pressure: bmp280: Fix incorrect pointer access in PM callbacks
Date: Fri, 12 Aug 2016 14:44:31 +0300
Message-Id: <1471002271-11426-1-git-send-email-jarkko.nikula@linux.intel.com>
List-ID: <linux-iio@vger.kernel.org>

BMP280 runtime PM callbacks are incorrectly casting dev_get_drvdata() to
struct bmp280_data * while bmp280_common_probe() sets driver data to
struct iio_dev *. Fix this and get the struct bmp280_data * from private
data of struct iio_dev.

Fixes: 3d838118c6aa ("iio: pressure: bmp280: add power management")
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
For v4.8-rc.
---
 drivers/iio/pressure/bmp280-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6943688e66df..724fefd4af00 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -1079,7 +1079,8 @@ EXPORT_SYMBOL(bmp280_common_remove);
 #ifdef CONFIG_PM
 static int bmp280_runtime_suspend(struct device *dev)
 {
-	struct bmp280_data *data = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
 
 	ret = regulator_disable(data->vdda);
@@ -1090,7 +1091,8 @@ static int bmp280_runtime_suspend(struct device *dev)
 
 static int bmp280_runtime_resume(struct device *dev)
 {
-	struct bmp280_data *data = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct bmp280_data *data = iio_priv(indio_dev);
 	int ret;
 
 	ret = regulator_enable(data->vddd);
-- 
2.8.1
