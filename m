Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64430 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434AbbHBUoG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:06 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 4/7] iio:accel:mma8452: check values to be written
Date: Sun,  2 Aug 2015 22:43:49 +0200
Message-Id: <35eaf1398b5b084bf611a1d5c024d98068531b93.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check values to be written to the device for valid lower and upper bounds.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma8452.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1463392f679c..516b6108d5f8 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -471,15 +471,17 @@ static int mma8452_write_thresh(struct iio_dev *indio_dev,
 
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
-		return mma8452_change_config(data, MMA8452_TRANSIENT_THS,
-					     val & MMA8452_TRANSIENT_THS_MASK);
+		if (val < 0 || val > MMA8452_TRANSIENT_THS_MASK)
+			return -EINVAL;
+
+		return mma8452_change_config(data, MMA8452_TRANSIENT_THS, val);
 
 	case IIO_EV_INFO_PERIOD:
 		steps = (val * USEC_PER_SEC + val2) /
 				mma8452_transient_time_step_us[
 					mma8452_get_odr_index(data)];
 
-		if (steps > 0xff)
+		if (steps < 0 || steps > 0xff)
 			return -EINVAL;
 
 		return mma8452_change_config(data, MMA8452_TRANSIENT_COUNT,
-- 
2.4.6

