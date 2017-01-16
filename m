Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34910 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750834AbdAPT1z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2017 14:27:55 -0500
Date: Mon, 16 Jan 2017 11:27:52 -0800
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: pgoudagunta@nvidia.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: palmas_gpadc: retrieve a valid iio_dev in
 suspend/resume
Message-ID: <20170116192742.GA9521@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The suspend/resume functions were using dev_to_iio_dev() to get
the iio_dev. That only works on IIO dev's.  Use dev_get_drvdata()
for a platform device to get the correct iio_dev.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
---
 drivers/iio/adc/palmas_gpadc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
index 2bbf0c5..7d61b56 100644
--- a/drivers/iio/adc/palmas_gpadc.c
+++ b/drivers/iio/adc/palmas_gpadc.c
@@ -775,7 +775,7 @@ static int palmas_adc_wakeup_reset(struct palmas_gpadc *adc)
 
 static int palmas_gpadc_suspend(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int wakeup = adc->wakeup1_enable || adc->wakeup2_enable;
 	int ret;
@@ -798,7 +798,7 @@ static int palmas_gpadc_suspend(struct device *dev)
 
 static int palmas_gpadc_resume(struct device *dev)
 {
-	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct palmas_gpadc *adc = iio_priv(indio_dev);
 	int wakeup = adc->wakeup1_enable || adc->wakeup2_enable;
 	int ret;
-- 
2.1.4

