Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rama Krishna Phani A <rphani@codeaurora.org>
Subject: [PATCH 2/2] iio:adc:qcom-spmi-vadc silence a long constant warning.
Date: Fri, 30 Dec 2016 18:25:50 +0000
Message-Id: <20161230182550.12038-2-jic23@kernel.org>
In-Reply-To: <20161230182550.12038-1-jic23@kernel.org>
References: <20161230182550.12038-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

It is meant to be long and is only added to an s64.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
---
 drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
index 9da3a8fb7514..244dbbd0d5e0 100644
--- a/drivers/iio/adc/qcom-spmi-vadc.c
+++ b/drivers/iio/adc/qcom-spmi-vadc.c
@@ -101,7 +101,7 @@
 #define KELVINMIL_CELSIUSMIL			273150
 
 #define PMI_CHG_SCALE_1				-138890
-#define PMI_CHG_SCALE_2				391750000000
+#define PMI_CHG_SCALE_2				391750000000LL
 
 #define VADC_CHAN_MIN			VADC_USBIN
 #define VADC_CHAN_MAX			VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM
-- 
2.11.0
