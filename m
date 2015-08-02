Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:59918 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751876AbbHBUoI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 2 Aug 2015 16:44:08 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Martin Fuzzey <mfuzzey@parkeon.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	martink@posteo.de
Subject: [PATCH 3/7] iio:accel:mma8452: pass up real error code
Date: Sun,  2 Aug 2015 22:43:48 +0200
Message-Id: <cbf8195dee344145ca006a09650ba0da10613c09.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
In-Reply-To: <cover.1438483410.git.knaack.h@gmx.de>
References: <cover.1438483410.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Pass up the error code provided by functions.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/accel/mma8452.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 153f26bc88dc..1463392f679c 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -343,7 +343,7 @@ static int mma8452_set_hp_filter_frequency(struct mma8452_data *data,
 
 	i = mma8452_get_hp_filter_index(data, val, val2);
 	if (i < 0)
-		return -EINVAL;
+		return i;
 
 	reg = i2c_smbus_read_byte_data(data->client,
 				       MMA8452_HP_FILTER_CUTOFF);
@@ -369,7 +369,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		i = mma8452_get_samp_freq_index(data, val, val2);
 		if (i < 0)
-			return -EINVAL;
+			return i;
 
 		data->ctrl_reg1 &= ~MMA8452_CTRL_DR_MASK;
 		data->ctrl_reg1 |= i << MMA8452_CTRL_DR_SHIFT;
@@ -378,7 +378,7 @@ static int mma8452_write_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_SCALE:
 		i = mma8452_get_scale_index(data, val, val2);
 		if (i < 0)
-			return -EINVAL;
+			return i;
 		data->data_cfg &= ~MMA8452_DATA_CFG_FS_MASK;
 		data->data_cfg |= i;
 		return mma8452_change_config(data, MMA8452_DATA_CFG,
-- 
2.4.6

