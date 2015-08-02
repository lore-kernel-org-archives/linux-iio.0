Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:56901 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbbHBUoI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:08 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 1/7] iio:accel:mma8452: fix _get_hp_filter_index
Date: Sun,  2 Aug 2015 22:43:46 +0200
Message-Id: <0296b82421da1d80a12a6a153e803585bee43cd4.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

To iterate through the available frequencies of mma8452_hp_filter_cutoff[],
the array size of a row of that table needs to be provided to
_get_int_plus_micros_index().

Fixes: 	1e79841a00e46 ("iio: mma8452: Add highpass filter configuration.")

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index e8e2077c7244..245b95fc22be 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -229,7 +229,7 @@ static int mma8452_get_hp_filter_index(struct mma8452_data *data,
 	int i = mma8452_get_odr_index(data);
 
 	return mma8452_get_int_plus_micros_index(mma8452_hp_filter_cutoff[i],
-		ARRAY_SIZE(mma8452_scales[0]), val, val2);
+		ARRAY_SIZE(mma8452_hp_filter_cutoff[0]), val, val2);
 }
 
 static int mma8452_read_hp_filter(struct mma8452_data *data, int *hz, int *uHz)
-- 
2.4.6

