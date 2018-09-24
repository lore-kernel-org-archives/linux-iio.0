Return-Path: <SRS0=HiVk=MG=googlemail.com=martin.blumenstingl@kernel.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] iio: adc: meson-saradc: do not use meson_sar_adc_iio_channels directly
Date: Tue, 25 Sep 2018 00:13:25 +0200
Message-Id: <20180924221326.2871-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180924221326.2871-1-martin.blumenstingl@googlemail.com>
References: <20180924221326.2871-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

In the future we may support two different channel sets:
- one which includes the voltage pads and the temperature sensor output
  (for Meson8, Meson8b and Meson8m2)
- one which only includes the voltage pads (GXBB, GXL, GXM and AXG)

Channel 7 has a special function on all of these platforms. However,
since we will have different channel array definitions we want our code
to always use whatever channels struct iio_dev uses.

No functional changes for now. This is the preparation for adding
temperature sensor support to this driver.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 1c4ba83c0725..809d1230be34 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -854,7 +854,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &meson_sar_adc_iio_channels[7],
+				       &indio_dev->channels[7],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value0);
 	if (ret < 0)
 		goto out;
@@ -862,7 +862,7 @@ static int meson_sar_adc_calib(struct iio_dev *indio_dev)
 	meson_sar_adc_set_chan7_mux(indio_dev, CHAN7_MUX_VDD_MUL3_DIV4);
 	usleep_range(10, 20);
 	ret = meson_sar_adc_get_sample(indio_dev,
-				       &meson_sar_adc_iio_channels[7],
+				       &indio_dev->channels[7],
 				       MEAN_AVERAGING, EIGHT_SAMPLES, &value1);
 	if (ret < 0)
 		goto out;
-- 
2.19.0
