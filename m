Return-Path: <SRS0=XxgT=AL=posteo.de=martink@kernel.org>
From: Martin Kepplinger <martink@posteo.de>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kepplinger <martink@posteo.de>
Subject: [PATCH] iio: adc: dln2-adc: initialize local struct before using it
Date: Sun, 10 Sep 2017 14:45:01 +0200
Message-Id: <20170910124501.30829-1-martink@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

struct data is defined and declared locally. Initiliazation has to be done
manually, so let's add that.

Signed-off-by: Martin Kepplinger <martink@posteo.de>
---

This is more of a question actually! Did you have in mind that data is
not initialized here? If so, please drop this patch. This is just in case
you implicitely expected data to be zero.


 drivers/iio/adc/dln2-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/dln2-adc.c b/drivers/iio/adc/dln2-adc.c
index ab8d6aed5085..452330075b67 100644
--- a/drivers/iio/adc/dln2-adc.c
+++ b/drivers/iio/adc/dln2-adc.c
@@ -489,7 +489,7 @@ static irqreturn_t dln2_adc_trigger_h(int irq, void *p)
 	struct {
 		__le16 values[DLN2_ADC_MAX_CHANNELS];
 		int64_t timestamp_space;
-	} data;
+	} data = { 0 };
 	struct dln2_adc_get_all_vals dev_data;
 	struct dln2_adc *dln2 = iio_priv(indio_dev);
 	const struct dln2_adc_demux_table *t;
-- 
2.11.0
