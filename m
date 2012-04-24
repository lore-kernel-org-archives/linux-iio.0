Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-093.synserver.de ([212.40.185.93]:1194 "EHLO
	smtp-out-093.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755850Ab2DXQrW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Apr 2012 12:47:22 -0400
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 09/11] staging:iio:dac:ad5446: Return cached value for 'raw' attribute
Date: Tue, 24 Apr 2012 18:49:39 +0200
Message-Id: <1335286181-20474-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-1-git-send-email-lars@metafoo.de>
References: <1335286181-20474-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

We can not read back the value from the device, but we cache the value anyway so
we might as well return the cached value instead of an error.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/dac/ad5446.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
index 731cd05..9dc67c8 100644
--- a/drivers/staging/iio/dac/ad5446.c
+++ b/drivers/staging/iio/dac/ad5446.c
@@ -229,6 +229,9 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
 	unsigned long scale_uv;
 
 	switch (m) {
+	case IIO_CHAN_INFO_RAW:
+		*val = st->cached_val;
+		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
 		*val =  scale_uv / 1000;
-- 
1.7.9.5

