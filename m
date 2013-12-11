Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59696 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750911Ab3LKSpv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Dec 2013 13:45:51 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: lars@metafoo.de, pmeerw@pmeerw.net, o.v.kravchenko@globallogic.com,
	stigge@antcom.de, Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 15/24] iio:dac:ad5755 replaces IIO_ST macro with explicit entries to struct scan_type
Date: Wed, 11 Dec 2013 18:45:33 +0000
Message-Id: <1386787542-19666-16-git-send-email-jic23@kernel.org>
In-Reply-To: <1386787542-19666-1-git-send-email-jic23@kernel.org>
References: <1386787542-19666-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

IIO_ST is going away as it is a pain to maintain.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad5755.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index c494276da4b0..b9719f19d4cd 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -392,7 +392,12 @@ static const struct iio_chan_spec_ext_info ad5755_ext_info[] = {
 		BIT(IIO_CHAN_INFO_OFFSET) |			\
 		BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
 		BIT(IIO_CHAN_INFO_CALIBBIAS),			\
-	.scan_type = IIO_ST('u', (_bits), 16, 16 - (_bits)),	\
+	.scan_type = {						\
+		.sign = 'u',					\
+		.realbits = (_bits),				\
+		.storagebits = 16,				\
+		.shift = 16 - (_bits),				\
+		},						\
 	.ext_info = ad5755_ext_info,				\
 }
 
-- 
1.8.4.2

