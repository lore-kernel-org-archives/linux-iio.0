Return-Path: <SRS0=XuxN=LK=chromium.org=mka@kernel.org>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Verify channel numbers from DT
Date: Mon, 27 Aug 2018 14:14:53 -0700
Message-Id: <20180827211453.213061-1-mka@chromium.org>
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

The driver only defines a subset of all possible ADC channels. Channel
numbers read from the device tree are accepted as long as they don't
exceed a max value, even when no channel definition exists. Add a
check to abort initialization in this case.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index 9c8e6f9e8248..ab5bec917c0a 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -519,7 +519,8 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
 		return ret;
 	}
 
-	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA) {
+	if (chan > ADC5_PARALLEL_ISENSE_VBAT_IDATA ||
+	    !data->adc_chans[chan].datasheet_name) {
 		dev_err(dev, "%s invalid channel number %d\n", name, chan);
 		return -EINVAL;
 	}
-- 
2.19.0.rc0.228.g281dcd1b4d0-goog
