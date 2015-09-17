Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35490 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706AbbIQRCf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 17 Sep 2015 13:02:35 -0400
From: Luis de Bethencourt <luis@debethencourt.com>
Date: Thu, 17 Sep 2015 19:02:32 +0200
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 2/2] iio: dac: max5821: Fix module autoload for OF platform
 driver
Message-ID: <20150917170232.GA27487@goodgumbo.baconseed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/iio/dac/max5821.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 28b8748..86e9e11 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -387,6 +387,7 @@ static const struct of_device_id max5821_of_match[] = {
 	{ .compatible = "maxim,max5821" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, max5821_of_match);
 
 static struct i2c_driver max5821_driver = {
 	.driver = {
-- 
2.4.6

