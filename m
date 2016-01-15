Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36687 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbcAOQAT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 15 Jan 2016 11:00:19 -0500
Received: by mail-pf0-f194.google.com with SMTP id n128so8668575pfn.3
        for <linux-iio@vger.kernel.org>; Fri, 15 Jan 2016 08:00:19 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH v2 1/2] iio: pressure: mpl115: don't set unused i2c clientdata
Date: Sat, 16 Jan 2016 01:00:02 +0900
Message-Id: <1452873603-17381-1-git-send-email-akinobu.mita@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

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

