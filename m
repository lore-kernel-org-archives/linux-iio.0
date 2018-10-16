Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38213 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQFCK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 17 Oct 2018 01:02:10 -0400
From: Giuliano Belinassi <giuliano.belinassi@gmail.com>
Date: Tue, 16 Oct 2018 18:09:50 -0300
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad7280a: Lines should not end with a '(' -
 style
Message-ID: <20181016210950.cmx4r4pb2yg5ofpp@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A number of macro calls cause a checkpatch issue:

    "Lines should not end with a '('"

This was fixed by moving the first '(' token to the line of the first
argument.

Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
---
 drivers/staging/iio/adc/ad7280a.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
index 58420dcb406d..f7df987412d7 100644
--- a/drivers/staging/iio/adc/ad7280a.c
+++ b/drivers/staging/iio/adc/ad7280a.c
@@ -725,8 +725,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 		} else {
 			if (((channels[i] >> 11) & 0xFFF) >= st->aux_threshhigh)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
+					       IIO_UNMOD_EVENT_CODE
+							(IIO_TEMP,
 							0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_RISING),
@@ -734,8 +734,8 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
 			else if (((channels[i] >> 11) & 0xFFF) <=
 				st->aux_threshlow)
 				iio_push_event(indio_dev,
-					       IIO_UNMOD_EVENT_CODE(
-							IIO_TEMP,
+					       IIO_UNMOD_EVENT_CODE
+							(IIO_TEMP,
 							0,
 							IIO_EV_TYPE_THRESH,
 							IIO_EV_DIR_FALLING),
-- 
2.19.1
