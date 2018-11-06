Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.235]:46321 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbeKGHKQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Nov 2018 02:10:16 -0500
From: Slawomir Stepien <sst@poczta.fm>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v2] staging: iio: adc: ad7280a: do not pass the copy of struct element
Date: Tue,  6 Nov 2018 22:43:08 +0100
Message-Id: <20181106214308.10619-1-sst@poczta.fm>
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no need to pass this parameter since is always a copy of
parameter that is available via st pointer.

Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
Note: this has been rebased on kernel/git/jic23/iio.git testing branch. I hope
      that's OK!

Changes since v1:
* Change my email address
---
 drivers/staging/iio/adc/ad7280a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 89c2c2deca64..fc6237ddb460 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -291,7 +291,7 @@ static int ad7280_read_channel(struct ad7280_state *st, unsigned int devaddr,
 	return (tmp >> 11) & 0xFFF;
 }
 
-static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
+static int ad7280_read_all_channels(struct ad7280_state *st,
 				    unsigned int *array)
 {
 	int i, ret;
@@ -312,7 +312,7 @@ static int ad7280_read_all_channels(struct ad7280_state *st, unsigned int cnt,
 
 	ad7280_delay(st);
 
-	for (i = 0; i < cnt; i++) {
+	for (i = 0; i < st->scan_cnt; i++) {
 		ret = __ad7280_read32(st, &tmp);
 		if (ret)
 			return ret;
@@ -687,7 +687,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 	if (!channels)
 		return IRQ_HANDLED;
 
-	ret = ad7280_read_all_channels(st, st->scan_cnt, channels);
+	ret = ad7280_read_all_channels(st, channels);
 	if (ret < 0)
 		goto out;
 
@@ -791,7 +791,7 @@ static int ad7280_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&st->lock);
 		if (chan->address == AD7280A_ALL_CELLS)
-			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
+			ret = ad7280_read_all_channels(st, NULL);
 		else
 			ret = ad7280_read_channel(st, chan->address >> 8,
 						  chan->address & 0xFF);
-- 
2.19.1
