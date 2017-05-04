Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32887 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755564AbdEDSCA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 4 May 2017 14:02:00 -0400
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-iio@vger.kernel.org
Cc: carlo@caione.org, khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 1/3] iio: adc: meson-saradc: mark all meson_sar_adc_data static and const
Date: Thu,  4 May 2017 20:01:34 +0200
Message-Id: <20170504180136.27025-2-martin.blumenstingl@googlemail.com>
In-Reply-To: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
References: <20170504180136.27025-1-martin.blumenstingl@googlemail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

These are only passed as of_device_id.data and never modified. Thus we
can mark them as static const, just like the of_device_id instances
where they are used.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/iio/adc/meson_saradc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
index dd4190b50df6..1cb5df306001 100644
--- a/drivers/iio/adc/meson_saradc.c
+++ b/drivers/iio/adc/meson_saradc.c
@@ -834,17 +834,17 @@ static const struct iio_info meson_sar_adc_iio_info = {
 	.driver_module = THIS_MODULE,
 };
 
-struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
+static struct meson_sar_adc_data meson_sar_adc_gxbb_data = {
 	.resolution = 10,
 	.name = "meson-gxbb-saradc",
 };
 
-struct meson_sar_adc_data meson_sar_adc_gxl_data = {
+static struct meson_sar_adc_data meson_sar_adc_gxl_data = {
 	.resolution = 12,
 	.name = "meson-gxl-saradc",
 };
 
-struct meson_sar_adc_data meson_sar_adc_gxm_data = {
+static struct meson_sar_adc_data meson_sar_adc_gxm_data = {
 	.resolution = 12,
 	.name = "meson-gxm-saradc",
 };
-- 
2.12.2

