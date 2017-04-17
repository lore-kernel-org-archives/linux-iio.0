Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34422 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756762AbdDQS2i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Apr 2017 14:28:38 -0400
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] iio: adc: meson-saradc: mark all meson_sar_adc_data static and const
Date: Mon, 17 Apr 2017 20:28:20 +0200
Message-Id: <20170417182820.26670-4-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
References: <20170417182820.26670-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are only passed as of_device_id.data and never modified. Thus we
can mark them as static const, just like the of_device_id instances
where they are used.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index cf13691009ee..8f742b71b165 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -843,31 +843,31 @@ static const struct iio_info meson_sar_adc_iio_info = {
 	.driver_module = THIS_MODULE,
 };
 
-struct meson_sar_adc_data meson_sar_adc_meson8_data = {
+static const struct meson_sar_adc_data meson_sar_adc_meson8_data = {
 	.has_bl30_integration = false,
 	.resolution = 10,
 	.name = "meson-meson8b-saradc",
 };
 
-struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
+static const struct meson_sar_adc_data meson_sar_adc_meson8b_data = {
 	.has_bl30_integration = false,
 	.resolution = 10,
 	.name = "meson-meson8b-saradc",
 };
 
-struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
+static const struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
 	.has_bl30_integration = true,
 	.resolution = 10,
 	.name = "meson-gxbb-saradc",
 };
 
-struct meson_sar_adc_data meson_sar_adc_gxl_data = {
+static const struct meson_sar_adc_data meson_sar_adc_gxl_data = {
 	.has_bl30_integration = true,
 	.resolution = 12,
 	.name = "meson-gxl-saradc",
 };
 
-struct meson_sar_adc_data meson_sar_adc_gxm_data = {
+static const struct meson_sar_adc_data meson_sar_adc_gxm_data = {
 	.has_bl30_integration = true,
 	.resolution = 12,
 	.name = "meson-gxm-saradc",
-- 
2.12.2

