Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbbHLKN4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 06:13:56 -0400
From: Markus Pargmann <mpa@pengutronix.de>
To: Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
	Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 16/20] iio: bmc150: Fix irq checks
Date: Wed, 12 Aug 2015 12:12:41 +0200
Message-Id: <1439374365-20623-17-git-send-email-mpa@pengutronix.de>
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Valid irqs are > 0. This patch fixes the check which fails for the new
spi driver part if no interrupt was given.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/iio/accel/bmc150-accel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel.c b/drivers/iio/accel/bmc150-accel.c
index 4e70f51c2370..fe2d2316158f 100644
--- a/drivers/iio/accel/bmc150-accel.c
+++ b/drivers/iio/accel/bmc150-accel.c
@@ -1660,10 +1660,10 @@ static int bmc150_accel_probe(struct i2c_client *client,
 		return ret;
 	}
 
-	if (client->irq < 0)
+	if (client->irq <= 0)
 		client->irq = bmc150_accel_gpio_probe(client, data);
 
-	if (client->irq >= 0) {
+	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(
 						&client->dev, client->irq,
 						bmc150_accel_irq_handler,
-- 
2.4.6

