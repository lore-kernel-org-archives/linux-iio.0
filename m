Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35418 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756723AbcJHQjf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:35 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 11/18] staging:iio:accel:sca3000: Fix off by one error in axis due to IIO_NO_MOD
Date: Sat,  8 Oct 2016 17:39:11 +0100
Message-Id: <20161008163918.18758-12-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Given the introduction of IIO_NO_MOD was prior to the first submission
prior to IIO entering staging this has been broken for a while.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index e951be35a18a..859394f8d8af 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -933,16 +933,17 @@ static int sca3000_read_event_value(struct iio_dev *indio_dev,
 {
 	int ret, i;
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int num = chan->channel2;
+
 	switch (info) {
 	case IIO_EV_INFO_VALUE:
 		mutex_lock(&st->lock);
-		ret = sca3000_read_ctrl_reg(st, sca3000_addresses[num][1]);
+		ret = sca3000_read_ctrl_reg(st,
+					    sca3000_addresses[chan->address][1]);
 		mutex_unlock(&st->lock);
 		if (ret < 0)
 			return ret;
 		*val = 0;
-		if (num == 1)
+		if (chan->channel2 == IIO_MOD_Y)
 			for_each_set_bit(i, (unsigned long *)&ret,
 					 ARRAY_SIZE(st->info->mot_det_mult_y))
 				*val += st->info->mot_det_mult_y[i];
@@ -972,12 +973,11 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
 				     int val, int val2)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
-	int num = chan->channel2;
 	int ret;
 	int i;
 	u8 nonlinear = 0;
 
-	if (num == IIO_MOD_Y) {
+	if (chan->channel2 == IIO_MOD_Y) {
 		i = ARRAY_SIZE(st->info->mot_det_mult_y);
 		while (i > 0)
 			if (val >= st->info->mot_det_mult_y[--i]) {
@@ -994,7 +994,9 @@ static int sca3000_write_event_value(struct iio_dev *indio_dev,
 	}
 
 	mutex_lock(&st->lock);
-	ret = sca3000_write_ctrl_reg(st, sca3000_addresses[num][1], nonlinear);
+	ret = sca3000_write_ctrl_reg(st,
+				     sca3000_addresses[chan->address][1],
+				     nonlinear);
 	mutex_unlock(&st->lock);
 
 	return ret;
@@ -1160,8 +1162,6 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
-	int num = chan->channel2;
-
 	/* read current value of mode register */
 	mutex_lock(&st->lock);
 
@@ -1189,7 +1189,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 			if (ret < 0)
 				goto error_ret;
 			/* only supporting logical or's for now */
-			ret = !!(ret & sca3000_addresses[num][2]);
+			ret = !!(ret & sca3000_addresses[chan->address][2]);
 		}
 		break;
 	default:
@@ -1305,7 +1305,8 @@ static int sca3000_write_event_config(struct iio_dev *indio_dev,
 	case IIO_MOD_X:
 	case IIO_MOD_Y:
 	case IIO_MOD_Z:
-		ret = sca3000_motion_detect_set_state(indio_dev, chan->channel2,
+		ret = sca3000_motion_detect_set_state(indio_dev,
+						      chan->address,
 						      state);
 		break;
 	default:
-- 
2.10.0

