Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35385 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756483AbcJHQjc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:32 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 04/18] staging:iio:accel:sca3000 Fix clearing of flag + setting of size of scan.
Date: Sat,  8 Oct 2016 17:39:04 +0100
Message-Id: <20161008163918.18758-5-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Not clearing the stuff_to_read flag can lead to a false flag being set
on restarting the buffer if the data was not all read the previous time.

The size of the scan is needed to ensure the function
iio_buffer_read_first_n_outer actually tries to read the data.

This stuff has been broken for some time so not stable material.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 36a52d02ee0e..8af7d83e658d 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -1491,6 +1491,19 @@ error_ret:
  **/
 static int sca3000_hw_ring_preenable(struct iio_dev *indio_dev)
 {
+	/*
+	 * Set stuff to read to indicate no data present.
+	 * Need for cases where the interrupt had fired at the
+	 * end of a cycle, but the data was never read.
+	 */
+	indio_dev->buffer->stufftoread = 0;
+	/*
+	 * Needed to ensure the core will actually read data
+	 * from the device rather than assuming no channels
+	 * are enabled.
+	 */
+	indio_dev->buffer->bytes_per_datum = 6;
+
 	return __sca3000_hw_ring_state_set(indio_dev, 1);
 }
 
-- 
2.10.0

