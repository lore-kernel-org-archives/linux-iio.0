Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506Ab3LKSpw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:52 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 19/24] iio:dac:mcp4725 drop specification of scan type as unused in this driver.
Date: Wed, 11 Dec 2013 18:45:37 +0000
Message-Id: <1386787542-19666-20-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain so the simplest path with
this driver is to not specify the unused scan type.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/mcp4725.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4725.c b/drivers/iio/dac/mcp4725.c
index 9f57ae84ab89..7d9f5c31d2fc 100644
--- a/drivers/iio/dac/mcp4725.c
+++ b/drivers/iio/dac/mcp4725.c
@@ -209,7 +209,6 @@ static const struct iio_chan_spec mcp4725_channel = {
 	.channel	= 0,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
-	.scan_type	= IIO_ST('u', 12, 16, 0),
 	.ext_info	= mcp4725_ext_info,
 };
 
-- 
1.8.4.2

