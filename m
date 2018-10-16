Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0064.hostedemail.com ([216.40.44.64]:56986 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbeJQFvh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2018 01:51:37 -0400
Message-ID: <5717d448daad72d7eb142732ca88e9ed30854088.camel@perches.com>
Subject: Re: [PATCH] staging: iio: ad7280a: Lines should not end with a '('
 - style
From: Joe Perches <joe@perches.com>
To: Giuliano Belinassi <giuliano.belinassi@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Date: Tue, 16 Oct 2018 14:59:08 -0700
In-Reply-To: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
References: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2018-10-16 at 18:09 -0300, Giuliano Belinassi wrote:
> A number of macro calls cause a checkpatch issue:
> 
>     "Lines should not end with a '('"
> 
> This was fixed by moving the first '(' token to the line of the first
> argument.

Please try to make the code more readable instead of
following mindless checkpatch messages.

For instance, this could be shorter, simpler, smaller
object code size, and easier to humans to read as:
---
 drivers/staging/iio/adc/ad7280a.c | 68 +++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..a69ae76b5616 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -701,46 +701,38 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		goto out;
 
 	for (i = 0; i < st->scan_cnt; i++) {
-		if (((channels[i] >> 23) & 0xF) <= AD7280A_CELL_VOLTAGE_6) {
-			if (((channels[i] >> 11) & 0xFFF) >=
-				st->cell_threshhigh)
-				iio_push_event(indio_dev,
-					       IIO_EVENT_CODE(IIO_VOLTAGE,
-							1,
-							0,
-							IIO_EV_DIR_RISING,
-							IIO_EV_TYPE_THRESH,
-							0, 0, 0),
-					       iio_get_time_ns(indio_dev));
-			else if (((channels[i] >> 11) & 0xFFF) <=
-				st->cell_threshlow)
-				iio_push_event(indio_dev,
-					       IIO_EVENT_CODE(IIO_VOLTAGE,
-							1,
-							0,
-							IIO_EV_DIR_FALLING,
-							IIO_EV_TYPE_THRESH,
-							0, 0, 0),
-					       iio_get_time_ns(indio_dev));
+		unsigned int voltage = (channels[i] >> 23) & 0xF;
+		unsigned int val = (channels[i] >> 11) & 0xFFF;
+		u64 code = 0;
+
+		if (voltage <= AD7280A_CELL_VOLTAGE_6) {
+			if (val >= st->cell_threshhigh) {
+				code = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
+						      IIO_EV_DIR_RISING,
+						      IIO_EV_TYPE_THRESH,
+						      0, 0, 0);
+			} else if (val <= st->cell_threshlow) {
+				code = IIO_EVENT_CODE(IIO_VOLTAGE, 1, 0,
+						      IIO_EV_DIR_FALLING,
+						      IIO_EV_TYPE_THRESH,
+						      0, 0, 0);
+			} else {
+				continue;
+			}
 		} else {
-			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
-				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
-							0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_RISING),
-					       iio_get_time_ns(indio_dev));
-			else if (((channels[i] >> 11) & 0xFFF) <=
-				st->aux_threshlow)
-				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
-							0,
-							IIO_EV_TYPE_THRESH,
-							IIO_EV_DIR_FALLING),
-					       iio_get_time_ns(indio_dev));
+			if (val >= st->aux_threshhigh) {
+				code = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_RISING);
+			} else if (val <= st->aux_threshlow) {
+				code = IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
+							    IIO_EV_TYPE_THRESH,
+							    IIO_EV_DIR_FALLING);
+			} else {
+				continue;
+			}
 		}
+		iio_push_event(indio_dev, code, iio_get_time_ns(indio_dev));
 	}
 
 out:
