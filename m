Return-Path: <SRS0=MmtQ=AY=wanadoo.fr=christophe.jaillet@kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	sre@kernel.org,
	wsa@the-dreams.de,
	kishon@ti.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 3/3] iio: adc: twl4030: Return an error if we can not enable the vusb3v1 regulator in 'twl4030_madc_probe()'
Date: Sat, 23 Sep 2017 08:06:20 +0200
Message-Id: <128d2bb662f174ed84c61dc268940bd87878f0d1.1506146101.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4bcd315895de7135369e6e0d2402fc2794f2ee99.1506146101.git.christophe.jaillet@wanadoo.fr>
References: <4bcd315895de7135369e6e0d2402fc2794f2ee99.1506146101.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1506146101.git.christophe.jaillet@wanadoo.fr>
References: <cover.1506146101.git.christophe.jaillet@wanadoo.fr>
List-ID: <linux-iio@vger.kernel.org>

If we can not enable the regulator, go through the error handling path
instead of silently continuing.

Fixes: 7cc97d77ee8a ("iio: adc: twl4030: Fix ADC[3:6] readings")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is highly speculative.
I don't find logical to return an error if we don't find the 'vusb3v1'
regulator, but continue if we find it, but can't enable it.
Returning an error if both cases (i.e. failing 'devm_regulator_get()' or
'regulator_enable)' seems the usual pattern in all the .probe functions
with a 'regulator_enable()' call have looked at (~ 10 of them taken
randomly)
---
 drivers/iio/adc/twl4030-madc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
index 32db23d9a483..e3cfb91bffc6 100644
--- a/drivers/iio/adc/twl4030-madc.c
+++ b/drivers/iio/adc/twl4030-madc.c
@@ -893,8 +893,10 @@ static int twl4030_madc_probe(struct platform_device *pdev)
 	}
 
 	ret = regulator_enable(madc->usb3v1);
-	if (ret)
+	if (ret) {
 		dev_err(madc->dev, "could not enable 3v1 bias regulator\n");
+		goto err_i2c;
+	}
 
 	ret = iio_device_register(iio_dev);
 	if (ret) {
-- 
2.11.0
