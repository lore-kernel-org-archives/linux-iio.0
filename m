Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-128.synserver.de ([212.40.185.128]:1372 "EHLO
	smtp-out-123.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751194Ab2FEQNM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 5 Jun 2012 12:13:12 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Michael Hennerich <michael.hennerich@analog.com>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] staging:iio:ad7606: Re-add missing scale attribute
Date: Tue,  5 Jun 2012 18:16:31 +0200
Message-Id: <1338912991-26095-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 50ac23be ("staging:iio:adc:ad7606 add local define for chan_spec
structures.") accidentally removed the scale info_mask flag. This patch
adds it back again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/adc/ad7606_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
index 10ab6dc..a13afff 100644
--- a/drivers/staging/iio/adc/ad7606_core.c
+++ b/drivers/staging/iio/adc/ad7606_core.c
@@ -235,7 +235,8 @@ static const struct attribute_group ad7606_attribute_group_range = {
 		.indexed = 1,					\
 		.channel = num,					\
 		.address = num,					\
-		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT,	\
+		.info_mask = IIO_CHAN_INFO_RAW_SEPARATE_BIT |	\
+				IIO_CHAN_INFO_SCALE_SHARED_BIT, \
 		.scan_index = num,				\
 		.scan_type = IIO_ST('s', 16, 16, 0),		\
 	}
-- 
1.7.10

