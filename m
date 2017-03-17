Return-Path: <SRS0=zfXb=22=gmail.com=karniksayli1995@kernel.org>
Date: Fri, 17 Mar 2017 20:41:11 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH] staging: iio: meter: ade7758_core: Replace mlock with
 driver's private lock
Message-ID: <20170317151110.GA26848@sayli-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

iio_dev->mlock should be used by the IIO core only for protecting
device operating mode changes. ie. Changes between INDIO_DIRECT_MODE,
INDIO_BUFFER_* modes.
Replace mlock with a lock in the device's global data to protect
hardware state changes.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/meter/ade7758_core.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7758_core.c b/drivers/staging/iio/meter/ade7758_core.c
index 99c89e6..1723eb8 100644
--- a/drivers/staging/iio/meter/ade7758_core.c
+++ b/drivers/staging/iio/meter/ade7758_core.c
@@ -522,13 +522,14 @@ static int ade7758_read_raw(struct iio_dev *indio_dev,
 			    int *val2,
 			    long mask)
 {
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->buf_lock);
 		ret = ade7758_read_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->buf_lock);
 		return ret;
 	default:
 		return -EINVAL;
@@ -541,15 +542,16 @@ static int ade7758_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
 {
+	struct ade7758_state *st = iio_priv(indio_dev);
 	int ret;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (val2)
 			return -EINVAL;
-		mutex_lock(&indio_dev->mlock);
+		mutex_lock(&st->buf_lock);
 		ret = ade7758_write_samp_freq(&indio_dev->dev, val);
-		mutex_unlock(&indio_dev->mlock);
+		mutex_unlock(&st->buf_lock);
 		return ret;
 	default:
 		return -EINVAL;
-- 
2.7.4
