Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:47710 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaBDJQK (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Feb 2014 04:16:10 -0500
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N0G0005MSEOTZ40@mailout3.samsung.com> for
 linux-iio@vger.kernel.org; Tue, 04 Feb 2014 18:16:00 +0900 (KST)
Message-id: <52F0AFD0.50104@samsung.com>
Date: Tue, 04 Feb 2014 18:16:00 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, ldewangan@nvidia.com,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Myungjoo Ham <myungjoo.ham@samsung.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH RESEND 2/2] iio: ak8975: Add device name
Content-type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


This patch add device name.

Signed-off-by: Beomho Seo <beomho.seo@samsung.com>
---
 drivers/iio/magnetometer/ak8975.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 0542354..74866d1 100644
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
