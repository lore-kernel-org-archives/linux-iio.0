Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yw0-f193.google.com ([209.85.161.193]:35844 "EHLO
	mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757207AbcGJVbk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Jul 2016 17:31:40 -0400
Date: Sun, 10 Jul 2016 14:31:36 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: jic23@kernel.org
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iio: humidity: hdc100x: remove lock on heater
 configuration read
Message-ID: <7509a24ed4958084737c2f7413a63c098d289879.1468180067.git.amsfield22@gmail.com>
References: <cover.1468180067.git.amsfield22@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1468180067.git.amsfield22@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The lock around the read (from global data) of the heater configuration
status is not needed.  Move the lock in IIO_CHAN_INFO_RAW case to only
protect the get measurement function.

Signed-off-by: Alison Schofield <amsfield22@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>
---
 drivers/iio/humidity/hdc100x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
index ad5a12a..8195b0c 100644
--- a/drivers/iio/humidity/hdc100x.c
+++ b/drivers/iio/humidity/hdc100x.c
@@ -193,18 +193,18 @@ static int hdc100x_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW: {
 		int ret;
 
-		mutex_lock(&data->lock);
 		if (chan->type == IIO_CURRENT) {
 			*val = hdc100x_get_heater_status(data);
 			ret = IIO_VAL_INT;
 		} else {
+			mutex_lock(&data->lock);
 			ret = hdc100x_get_measurement(data, chan);
+			mutex_unlock(&data->lock);
 			if (ret >= 0) {
 				*val = ret;
 				ret = IIO_VAL_INT;
 			}
 		}
-		mutex_unlock(&data->lock);
 		return ret;
 	}
 	case IIO_CHAN_INFO_INT_TIME:
-- 
2.1.4

