Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:58101 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752751AbaAJV7Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 10 Jan 2014 16:59:25 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/5] iio:magnetometer:mag3110: Report busy in _read_raw() / write_raw() when buffer is enabled
Date: Fri, 10 Jan 2014 22:59:19 +0100
Message-Id: <1389391163-9622-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

individual reads are not permitted concurrently with buffered reads

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 drivers/iio/magnetometer/mag3110.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/magnetometer/mag3110.c b/drivers/iio/magnetometer/mag3110.c
index 4b65b6d..b88cb44 100644
--- a/drivers/iio/magnetometer/mag3110.c
+++ b/drivers/iio/magnetometer/mag3110.c
@@ -154,6 +154,9 @@ static int mag3110_read_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (iio_buffer_enabled(indio_dev))
+			return -EBUSY;
+
 		switch (chan->type) {
 		case IIO_MAGN: /* in 0.1 uT / LSB */
 			ret = mag3110_read(data, buffer);
@@ -199,6 +202,9 @@ static int mag3110_write_raw(struct iio_dev *indio_dev,
 	struct mag3110_data *data = iio_priv(indio_dev);
 	int rate;
 
+	if (iio_buffer_enabled(indio_dev))
+		return -EBUSY;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		rate = mag3110_get_samp_freq_index(data, val, val2);
-- 
1.8.3.2

