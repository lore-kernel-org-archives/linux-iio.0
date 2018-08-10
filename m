Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44817 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeHJWSd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Aug 2018 18:18:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id k21-v6so4975969pff.11
        for <linux-iio@vger.kernel.org>; Fri, 10 Aug 2018 12:47:17 -0700 (PDT)
From: Matthias Kaehlcke <mka@chromium.org>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] iio: adc: qcom-spmi-adc5: Add ADC5_AMUX_THM[24]_100K_PU to rev2 channel list
Date: Fri, 10 Aug 2018 12:47:02 -0700
Message-Id: <20180810194702.144641-1-mka@chromium.org>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Add ADC5_AMUX_THM2_100K_PU and ADC5_AMUX_THM4_100K_PU to the list of
rev2 ADC channels.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/iio/adc/qcom-spmi-adc5.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
index a4299417f3de..1f9298a5c83d 100644
--- a/drivers/iio/adc/qcom-spmi-adc5.c
+++ b/drivers/iio/adc/qcom-spmi-adc5.c
@@ -491,8 +491,12 @@ static const struct adc5_channels adc5_chans_rev2[ADC5_MAX_CHANNEL] = {
 					SCALE_HW_CALIB_PMIC_THERM)
 	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 1,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 1,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_AMUX_THM3_100K_PU] = ADC5_CHAN_TEMP("amux_thm3_100k_pu", 1,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
+	[ADC5_AMUX_THM4_100K_PU] = ADC5_CHAN_TEMP("amux_thm4_100k_pu", 1,
+					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_AMUX_THM5_100K_PU] = ADC5_CHAN_TEMP("amux_thm5_100k_pu", 1,
 					SCALE_HW_CALIB_THERM_100K_PULLUP)
 	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm_100k_pu", 1,
-- 
2.18.0.597.ga71716f1ad-goog
