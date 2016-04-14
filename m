Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62550 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653AbcDNPti (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 14 Apr 2016 11:49:38 -0400
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Marek Vasut <marex@denx.de>
Cc: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Juergen Borleis <jbe@pengutronix.de>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFT 1/5] iio: mxs-lradc: fix memory leak
Date: Thu, 14 Apr 2016 15:48:25 +0000
Message-Id: <1460648909-2657-2-git-send-email-stefan.wahren@i2se.com>
In-Reply-To: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
References: <1460648909-2657-1-git-send-email-stefan.wahren@i2se.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

After successful touchscreen registration the input device was
never freed. So fix this issue by using devm_input_allocate_device().

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/iio/adc/mxs-lradc.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
index 33051b8..0576953 100644
--- a/drivers/iio/adc/mxs-lradc.c
+++ b/drivers/iio/adc/mxs-lradc.c
@@ -1109,12 +1109,11 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 {
 	struct input_dev *input;
 	struct device *dev = lradc->dev;
-	int ret;
 
 	if (!lradc->use_touchscreen)
 		return 0;
 
-	input = input_allocate_device();
+	input = devm_input_allocate_device(dev);
 	if (!input)
 		return -ENOMEM;
 
@@ -1134,11 +1133,8 @@ static int mxs_lradc_ts_register(struct mxs_lradc *lradc)
 
 	lradc->ts_input = input;
 	input_set_drvdata(input, lradc);
-	ret = input_register_device(input);
-	if (ret)
-		input_free_device(lradc->ts_input);
 
-	return ret;
+	return input_register_device(input);
 }
 
 static void mxs_lradc_ts_unregister(struct mxs_lradc *lradc)
-- 
1.7.9.5

