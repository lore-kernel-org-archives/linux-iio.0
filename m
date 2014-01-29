Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:14150 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750936AbaA2FFM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jan 2014 00:05:12 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0500BT6CSNQYB0@mailout1.samsung.com> for
 linux-iio@vger.kernel.org; Wed, 29 Jan 2014 14:05:11 +0900 (KST)
Message-id: <52E88C08.10204@samsung.com>
Date: Wed, 29 Jan 2014 14:05:12 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>, ldewangan@nvidia.com
Subject: [PATCH 2/2] iio: ak8975: Add device name
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/magnetometer/ak8975.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index ae64390..f30f0ee 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -513,6 +513,7 @@ static int ak8975_probe(struct i2c_client *client,
 	indio_dev->channels = ak8975_channels;
 	indio_dev->num_channels = ARRAY_SIZE(ak8975_channels);
 	indio_dev->info = &ak8975_info;
+	indio_dev->name = id->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;

 	err = iio_device_register(indio_dev);
-- 
1.7.9.5

-- 
Best Regards,
