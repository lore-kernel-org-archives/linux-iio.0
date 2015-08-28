Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.15]:65139 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856AbbH1WAW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 18:00:22 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 3/6] iio:dac:m62332: use ARRAY_SIZE
Date: Fri, 28 Aug 2015 23:59:55 +0200
Message-Id: <20f1a555b8a1d2f7967041de85ee4335b1ff549d.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Make use of ARRAY_SIZE to prevent buffer issues.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/dac/m62332.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index c61720de8606..fe750982b502 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -62,8 +62,8 @@ static int m62332_set_value(struct iio_dev *indio_dev,
 			goto out;
 	}
 
-	res = i2c_master_send(client, outbuf, 2);
-	if (res >= 0 && res != 2)
+	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
+	if (res >= 0 && res != ARRAY_SIZE(outbuf))
 		res = -EIO;
 	if (res < 0)
 		goto out;
@@ -212,7 +212,7 @@ static int m62332_probe(struct i2c_client *client,
 	/* establish that the iio_dev is a child of the i2c device */
 	indio_dev->dev.parent = &client->dev;
 
-	indio_dev->num_channels = M62332_CHANNELS;
+	indio_dev->num_channels = ARRAY_SIZE(m62332_channels);
 	indio_dev->channels = m62332_channels;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &m62332_info;
-- 
2.4.6

