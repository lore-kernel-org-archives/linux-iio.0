Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:36089 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751585AbbEYUgL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 25 May 2015 16:36:11 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: rockchip_saradc: add missing MODULE_* data
Date: Mon, 25 May 2015 22:36:58 +0200
Message-ID: <4303804.647s4ZjWfi@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The module-data is currently missing. This includes the license-information
which makes the driver taint the kernel and miss symbols when compiled as
module.

Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/iio/adc/rockchip_saradc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 8d4e019..9c311c1 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -349,3 +349,7 @@ static struct platform_driver rockchip_saradc_driver = {
 };
 
 module_platform_driver(rockchip_saradc_driver);
+
+MODULE_AUTHOR("Heiko Stuebner <heiko@sntech.de>");
+MODULE_DESCRIPTION("Rockchip SARADC driver");
+MODULE_LICENSE("GPL v2");
-- 
2.1.4


