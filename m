Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40405 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbeGUUev (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 21 Jul 2018 16:34:51 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so12753566wma.5
        for <linux-iio@vger.kernel.org>; Sat, 21 Jul 2018 12:40:58 -0700 (PDT)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-amlogic@lists.infradead.org,
        linux-iio@vger.kernel.org
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] iio: adc: meson-saradc: add support for the Meson8m2 SoCs
Date: Sat, 21 Jul 2018 21:40:49 +0200
Message-Id: <20180721194049.23265-3-martin.blumenstingl@googlemail.com>
In-Reply-To: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
References: <20180721194049.23265-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The SAR ADC on Meson8m2 behaves identical to the one found in the
Meson8b SoCs. Add a separate compatible string because the temperature
sensor logic (not supported yet) differs between Meson8 and Meson8m2
(however, it's the same for Meson8b and Meson8m2).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index 2948909f3ee3..da2d16dfa63e 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -922,6 +922,11 @@ static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
 	.name = "meson-meson8b-saradc",
 };
 
+static const struct meson_sar_adc_data meson_sar_adc_meson8m2_data = {
+	.param = &meson_sar_adc_meson8_param,
+	.name = "meson-meson8m2-saradc",
+};
+
 static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
 	.param = &meson_sar_adc_gxbb_param,
 	.name = "meson-gxbb-saradc",
@@ -951,6 +956,10 @@ static const struct of_device_id meson_sar_adc_of_match[] = {
 		.compatible = "amlogic,meson8b-saradc",
 		.data = &meson_sar_adc_meson8b_data,
 	},
+	{
+		.compatible = "amlogic,meson8m2-saradc",
+		.data = &meson_sar_adc_meson8m2_data,
+	},
 	{
 		.compatible = "amlogic,meson-gxbb-saradc",
 		.data = &meson_sar_adc_gxbb_data,
-- 
2.18.0

