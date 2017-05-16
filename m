Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:52784 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752303AbdEPNSb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 May 2017 09:18:31 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v4 5/9] iio: light: rpr0521 whitespace fixes
Date: Tue, 16 May 2017 15:33:32 +0300
Message-Id: <1494938016-8940-5-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1494938016-8940-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1494938016-8940-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Just whitespace change, no functional changes.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index d4d2d8c..da4b374 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -371,6 +371,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 		*val = le16_to_cpu(raw_data);
 
 		return IIO_VAL_INT;
+
 	case IIO_CHAN_INFO_SCALE:
 		mutex_lock(&data->lock);
 		ret = rpr0521_get_gain(data, chan->address, val, val2);
@@ -379,6 +380,7 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 			return ret;
 
 		return IIO_VAL_INT_PLUS_MICRO;
+
 	default:
 		return -EINVAL;
 	}
@@ -398,6 +400,7 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 
 		return ret;
+
 	default:
 		return -EINVAL;
 	}
-- 
1.7.9.5

