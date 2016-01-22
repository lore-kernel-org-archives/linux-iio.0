Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33454 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753996AbcAVRt1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 22 Jan 2016 12:49:27 -0500
From: Colin King <colin.king@canonical.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: axp288: remove redundant duplicate const on axp288_adc_channels
Date: Fri, 22 Jan 2016 17:49:22 +0000
Message-Id: <1453484962-25247-1-git-send-email-colin.king@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

duplicate const can be removed, it is redundant. Found by static
analysis using smatch.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/adc/axp288_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
index 0c904ed..7fd2494 100644
--- a/drivers/iio/adc/axp288_adc.c
+++ b/drivers/iio/adc/axp288_adc.c
@@ -46,7 +46,7 @@ struct axp288_adc_info {
 	struct regmap *regmap;
 };
 
-static const struct iio_chan_spec const axp288_adc_channels[] = {
+static const struct iio_chan_spec axp288_adc_channels[] = {
 	{
 		.indexed = 1,
 		.type = IIO_TEMP,
-- 
2.7.0.rc3

