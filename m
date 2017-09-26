Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38854 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753160AbdIZPlx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 26 Sep 2017 11:41:53 -0400
Received: by mail-pg0-f68.google.com with SMTP id m30so6981604pgn.5
        for <linux-iio@vger.kernel.org>; Tue, 26 Sep 2017 08:41:53 -0700 (PDT)
From: Aastha Gupta <aastha.gupta4104@gmail.com>
To: outreachy-kernel@googlegroups.com, hennerich@blackfin.uclinux.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Cc: Aastha Gupta <aastha.gupta4104@gmail.com>
Subject: [PATCH v2 2/2] staging: iio: adc: ad7192: add lock to protect hardware state changes
Date: Tue, 26 Sep 2017 21:11:08 +0530
Message-Id: <1506440468-5081-3-git-send-email-aastha.gupta4104@gmail.com>
In-Reply-To: <1506440468-5081-1-git-send-email-aastha.gupta4104@gmail.com>
References: <1506440468-5081-1-git-send-email-aastha.gupta4104@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The IIO subsystem is redefining iio_dev->mlock to be used by
the IIO core only for protecting device operating mode changes.
ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.

In this driver, private driver lock is being used to protect hardware
state changes as here state variables are being changed.

Signed-off-by: Aastha Gupta <aastha.gupta4104@gmail.com>
---
 drivers/staging/iio/adc/ad7192.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
index 096d29d..609a649 100644
--- a/drivers/staging/iio/adc/ad7192.c
+++ b/drivers/staging/iio/adc/ad7192.c
@@ -511,6 +511,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_SCALE:
 		ret = -EINVAL;
+		mutex_lock(&st->lock);
 		for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++)
 			if (val2 == st->scale_avail[i][1]) {
 				ret = 0;
@@ -524,6 +525,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
 				ad7192_calibrate_all(st);
 				break;
 			}
+		mutex_unlock(&st->lock);
 		break;
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		if (!val) {
-- 
2.7.4

