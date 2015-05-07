Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, <phani.movva@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 4/5] iio: adc: cc10001: Add delay before setting START bit
Date: Thu, 7 May 2015 18:22:20 -0300
Message-ID: <1431033741-1088-5-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

According to hardware team there should be some delay after
setting channel number, start mode and before setting START.
Add a one microsecond delay for this purpose.

Fixes: 1664f6a5b0c8 ("iio: adc: Cosmic Circuits 10001 ADC driver")
Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/iio/adc/cc10001_adc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index 5302bbb..10c734d 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -102,6 +102,7 @@ static void cc10001_adc_start(struct cc10001_adc_device *adc_dev,
 	val = (channel & CC10001_ADC_CH_MASK) | CC10001_ADC_MODE_SINGLE_CONV;
 	cc10001_adc_write_reg(adc_dev, CC10001_ADC_CONFIG, val);
 
+	udelay(1);
 	val = cc10001_adc_read_reg(adc_dev, CC10001_ADC_CONFIG);
 	val = val | CC10001_ADC_START_CONV;
 	cc10001_adc_write_reg(adc_dev, CC10001_ADC_CONFIG, val);
-- 
2.3.3
