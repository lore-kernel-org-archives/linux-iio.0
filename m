Return-Path: <weiyj_lk@163.com>
From: weiyj_lk@163.com
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	linux-iio@vger.kernel.org
Subject: [PATCH -next] iio: pressure: bmp280: fix wrong pointer passed to PTR_ERR()
Date: Thu, 14 Jul 2016 11:06:11 +0000
Message-Id: <1468494371-23371-1-git-send-email-weiyj_lk@163.com>
In-Reply-To: <1468487141-20016-1-git-send-email-weiyj_lk@163.com>
References: <1468487141-20016-1-git-send-email-weiyj_lk@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

PTR_ERR should access the value just tested by IS_ERR, otherwise
the wrong error code will be returned.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/iio/pressure/bmp280-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index 6943688..94e27b2 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -970,7 +970,7 @@ int bmp280_common_probe(struct device *dev,
 	data->vdda = devm_regulator_get(dev, "vdda");
 	if (IS_ERR(data->vdda)) {
 		dev_err(dev, "failed to get VDDA regulator\n");
-		ret = PTR_ERR(data->vddd);
+		ret = PTR_ERR(data->vdda);
 		goto out_disable_vddd;
 	}
 	ret = regulator_enable(data->vdda);
