Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45342 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753544AbeDSOHL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 19 Apr 2018 10:07:11 -0400
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH 48/61] staging: iio: adc: simplify getting .drvdata
Date: Thu, 19 Apr 2018 16:06:18 +0200
Message-Id: <20180419140641.27926-49-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We should get drvdata from struct device directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy. Please apply individually.

 drivers/staging/iio/adc/ad7606_par.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
index 3eb6f8f312dd..a34c2a1d5373 100644
--- a/drivers/staging/iio/adc/ad7606_par.c
+++ b/drivers/staging/iio/adc/ad7606_par.c
@@ -18,8 +18,7 @@
 static int ad7606_par16_read_block(struct device *dev,
 				   int count, void *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	insw((unsigned long)st->base_address, buf, count);
@@ -34,8 +33,7 @@ static const struct ad7606_bus_ops ad7606_par16_bops = {
 static int ad7606_par8_read_block(struct device *dev,
 				  int count, void *buf)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct ad7606_state *st = iio_priv(indio_dev);
 
 	insb((unsigned long)st->base_address, buf, count * 2);
-- 
2.11.0

