Return-Path: <Ezequiel.Garcia@imgtec.com>
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To: <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
CC: Naidu Tellapati <naidu.tellapati@imgtec.com>, James Hartley
	<james.hartley@imgtec.com>, <phani.movva@imgtec.com>, Ezequiel Garcia
	<ezequiel.garcia@imgtec.com>
Subject: [PATCH 3/5] iio: adc: cc10001: Fix regulator_get_voltage() return value check
Date: Thu, 7 May 2015 18:22:19 -0300
Message-ID: <1431033741-1088-4-git-send-email-ezequiel.garcia@imgtec.com>
In-Reply-To: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
References: <1431033741-1088-1-git-send-email-ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Naidu Tellapati <naidu.tellapati@imgtec.com>

regulator_get_voltage() returns a non-negative value in case of success,
and a negative error in case of error. Let's fix this.

Fixes: 1664f6a5b0c8 ("iio: adc: Cosmic Circuits 10001 ADC driver")
Signed-off-by: Naidu Tellapati <naidu.tellapati@imgtec.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
---
 drivers/iio/adc/cc10001_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/cc10001_adc.c b/drivers/iio/adc/cc10001_adc.c
index cf6c6fb..5302bbb 100644
--- a/drivers/iio/adc/cc10001_adc.c
+++ b/drivers/iio/adc/cc10001_adc.c
@@ -232,7 +232,7 @@ static int cc10001_adc_read_raw(struct iio_dev *indio_dev,
 
 	case IIO_CHAN_INFO_SCALE:
 		ret = regulator_get_voltage(adc_dev->reg);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		*val = ret / 1000;
-- 
2.3.3
