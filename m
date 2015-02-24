Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:32614 "EHLO
	mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973AbbBXJmD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Feb 2015 04:42:03 -0500
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] iio: jsa1212: Constify struct regmap_config
Date: Tue, 24 Feb 2015 10:41:49 +0100
Message-id: <1424770909-7360-2-git-send-email-k.kozlowski@samsung.com>
In-reply-to: <1424770909-7360-1-git-send-email-k.kozlowski@samsung.com>
References: <1424770909-7360-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/iio/light/jsa1212.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
index 29de7e7d9562..3a3af89beaf9 100644
--- a/drivers/iio/light/jsa1212.c
+++ b/drivers/iio/light/jsa1212.c
@@ -308,7 +308,7 @@ static bool jsa1212_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config jsa1212_regmap_config = {
+static const struct regmap_config jsa1212_regmap_config = {
 	.name =  JSA1212_REGMAP_NAME,
 	.reg_bits = 8,
 	.val_bits = 8,
-- 
1.9.1

