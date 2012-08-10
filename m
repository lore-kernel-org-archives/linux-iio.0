Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 05/22] staging:iio:ad7793: Follow new IIO naming spec
Date: Fri, 10 Aug 2012 18:36:19 +0200
Message-Id: <1344616596-8026-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1344616596-8026-1-git-send-email-lars@metafoo.de>
References: <1344616596-8026-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Make the "in-in_scale_available" attribute follow the new naming spec and
rename it to "in_voltage-voltage_scale_available".

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7793.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
index 3c8d1d4..91cb95c 100644
--- a/drivers/staging/iio/adc/ad7793.c
+++ b/drivers/staging/iio/adc/ad7793.c
@@ -563,8 +563,9 @@ static ssize_t ad7793_show_scale_available(struct device *dev,
 	return len;
 }
 
-static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available, in-in_scale_available,
-			     S_IRUGO, ad7793_show_scale_available, NULL, 0);
+static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available,
+		in_voltage-voltage_scale_available, S_IRUGO,
+		ad7793_show_scale_available, NULL, 0);
 
 static struct attribute *ad7793_attributes[] = {
 	&iio_dev_attr_sampling_frequency.dev_attr.attr,
-- 
1.7.10.4
