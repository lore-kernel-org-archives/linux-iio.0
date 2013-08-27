Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:27183 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752724Ab3H0BTa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 26 Aug 2013 21:19:30 -0400
Date: Tue, 27 Aug 2013 04:19:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Grant Likely <grant.likely@linaro.org>,
	Rob Herring <rob.herring@calxeda.com>,
	Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>,
	Graeme Gregory <gg@slimlogic.co.uk>,
	Balaji T K <balajitk@ti.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [patch] iio: adc: twl6030-gpadc: returning success instead of error
Message-ID: <20130827011902.GC17061@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

I've moved the goto down a line after we set the error code.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index a558516..0ea96c0 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -537,8 +537,8 @@ static int twl6030_gpadc_read_raw(struct iio_dev *indio_dev,
 		ret = -ETIMEDOUT;
 		goto err;
 	} else if (timeout < 0) {
-		goto err;
 		ret = -EINTR;
+		goto err;
 	}
 
 	switch (mask) {
