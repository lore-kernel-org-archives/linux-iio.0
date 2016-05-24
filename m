Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34506 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbcEXTQZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 May 2016 15:16:25 -0400
Date: Tue, 24 May 2016 12:16:23 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] iio: adc: ad7266: claim direct mode during sensor read
Message-ID: <c023a9f4a7d9015a225f1ebedd998687da770e9b.1464115008.git.amsfield22@gmail.com>
References: <cover.1464115008.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1464115008.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Driver was checking for direct mode but not locking it down.
Use iio_device_claim_direct_mode() to guarantee device stays
in direct mode.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/adc/ad7266.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 21e19b6..01240ae 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -154,12 +154,11 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 
 	switch (m) {
 	case IIO_CHAN_INFO_RAW:
-		if (iio_buffer_enabled(indio_dev))
-			return -EBUSY;
-
-		ret = ad7266_read_single(st, val, chan->address);
+		ret = iio_device_claim_direct_mode(indio_dev);
 		if (ret)
 			return ret;
+		ret = ad7266_read_single(st, val, chan->address);
+		iio_device_release_direct_mode(indio_dev);
 
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
-- 
2.1.4

