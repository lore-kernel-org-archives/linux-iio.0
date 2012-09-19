Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:22379 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755405Ab2ISG1F (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Sep 2012 02:27:05 -0400
Date: Wed, 19 Sep 2012 09:27:00 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [patch] iio: dac/ad5755: signedness bug in ad5755_setup_pdata()
Message-ID: <20120919062700.GA28864@elgon.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We need "ret" to be signed for the error handling to work correctly.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index e6dbe5f..5db3506 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -451,9 +451,9 @@ static int __devinit ad5755_setup_pdata(struct iio_dev *indio_dev,
 	const struct ad5755_platform_data *pdata)
 {
 	struct ad5755_state *st = iio_priv(indio_dev);
-	unsigned int ret;
 	unsigned int val;
 	unsigned int i;
+	int ret;
 
 	if (pdata->dc_dc_phase > AD5755_DC_DC_PHASE_90_DEGREE ||
 		pdata->dc_dc_freq > AD5755_DC_DC_FREQ_650kHZ ||
