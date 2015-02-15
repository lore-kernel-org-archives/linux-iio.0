Return-Path: <tolga.ceylan@gmail.com>
From: Tolga Ceylan <tolga.ceylan@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	tolga.ceylan@gmail.com
Subject: [PATCH 3/3] Staging: iio: meter: ade7854-i2c: code style improvements
Date: Sat, 14 Feb 2015 20:32:45 -0800
Message-Id: <1423974765-1782-3-git-send-email-tolga.ceylan@gmail.com>
In-Reply-To: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com>
References: <1423974765-1782-1-git-send-email-tolga.ceylan@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Code reformatting based on checkpatch.pl with --strict:
Comparison to NULL rewritten as !indio_dev

Signed-off-by: Tolga Ceylan <tolga.ceylan@gmail.com>
---
 drivers/staging/iio/meter/ade7854-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/meter/ade7854-i2c.c b/drivers/staging/iio/meter/ade7854-i2c.c
index 5e6fbe4..4e7a382 100644
--- a/drivers/staging/iio/meter/ade7854-i2c.c
+++ b/drivers/staging/iio/meter/ade7854-i2c.c
@@ -210,7 +210,7 @@ static int ade7854_i2c_probe(struct i2c_client *client,
 	struct iio_dev *indio_dev;
 
 	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*st));
-	if (indio_dev == NULL)
+	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
-- 
2.3.0
