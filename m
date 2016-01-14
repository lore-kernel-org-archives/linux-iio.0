Return-Path: <akinobu.mita@gmail.com>
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: pressure: mpl115: don't set unused i2c clientdata
Date: Fri, 15 Jan 2016 01:30:17 +0900
Message-Id: <1452789018-16255-1-git-send-email-akinobu.mita@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

mpl115 sets i2c clientdata, but it is not used anywhere.  So remove it.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/pressure/mpl115.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index f5ecd6e..3e1e3353 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -163,7 +163,6 @@ static int mpl115_probe(struct i2c_client *client,
 	data->client = client;
 	mutex_init(&data->lock);
 
-	i2c_set_clientdata(client, indio_dev);
 	indio_dev->info = &mpl115_info;
 	indio_dev->name = id->name;
 	indio_dev->dev.parent = &client->dev;
-- 
2.5.0
