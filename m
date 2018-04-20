Return-Path: <SRS0=w7IO=HJ=ispras.ru=khoroshilov@kernel.org>
From: Alexey Khoroshilov <khoroshilov@ispras.ru>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ldv-project@linuxtesting.org,
	sil2review@lists.osadl.org
Subject: [PATCH] iio: adc: ad799x: Fix error handling in ad799x_probe()
Date: Fri, 20 Apr 2018 23:54:22 +0300
Message-Id: <1524257662-6185-1-git-send-email-khoroshilov@ispras.ru>
List-ID: <linux-iio@vger.kernel.org>

In case of errors in write/read config, st->vref is left undisabled.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
Fixes: 0f7ddcc1bff1 ("iio:adc:ad799x: Write default config on probe and reset alert status on probe")
---
 drivers/iio/adc/ad799x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index e1da67d5ee22..9e61720db7ea 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -814,10 +814,10 @@ static int ad799x_probe(struct i2c_client *client,
 
 	ret = ad799x_write_config(st, st->chip_config->default_config);
 	if (ret < 0)
-		goto error_disable_reg;
+		goto error_disable_vref;
 	ret = ad799x_read_config(st);
 	if (ret < 0)
-		goto error_disable_reg;
+		goto error_disable_vref;
 	st->config = ret;
 
 	ret = iio_triggered_buffer_setup(indio_dev, NULL,
-- 
2.7.4
