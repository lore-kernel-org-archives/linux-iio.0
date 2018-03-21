Return-Path: <SRS0=kCDT=GL=vanguardiasur.com.ar=hernan@kernel.org>
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hernan@vanguardiasur.com.ar
Subject: [PATCH 07/11] staging: iio: ad7746: Add remove()
Date: Wed, 21 Mar 2018 11:28:55 -0300
Message-Id: <1521642539-4845-8-git-send-email-hernan@vanguardiasur.com.ar>
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

This allows the driver to be probed and removed as a module.

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 815573c..8abba71 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -768,6 +768,15 @@ static int ad7746_probe(struct i2c_client *client,
 	return 0;
 }
 
+static int ad7746_remove(struct i2c_client *client)
+{
+	struct iio_dev *indio_dev = i2c_get_clientdata(client);
+
+	iio_device_unregister(indio_dev);
+
+	return 0;
+}
+
 static const struct i2c_device_id ad7746_id[] = {
 	{ "ad7745", 7745 },
 	{ "ad7746", 7746 },
@@ -792,6 +801,7 @@ static struct i2c_driver ad7746_driver = {
 		.of_match_table = of_match_ptr(ad7746_of_match),
 	},
 	.probe = ad7746_probe,
+	.remove = ad7746_remove,
 	.id_table = ad7746_id,
 };
 module_i2c_driver(ad7746_driver);
-- 
2.7.4
