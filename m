Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58386 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753307AbcJCT1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:12 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 07/18] staging:iio:accel:sca3000 drop some unused variables.
Date: Mon,  3 Oct 2016 20:26:51 +0100
Message-Id: <20161003192702.24361-8-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 57ae5584d146..39da74008786 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -155,23 +155,19 @@
  * struct sca3000_state - device instance state information
  * @us:			the associated spi device
  * @info:			chip variant information
- * @interrupt_handler_ws:	event interrupt handler for all events
  * @last_timestamp:		the timestamp of the last event
  * @mo_det_use_count:		reference counter for the motion detection unit
  * @lock:			lock used to protect elements of sca3000_state
  *				and the underlying device state.
- * @bpse:			number of bits per scan element
  * @tx:			dma-able transmit buffer
  * @rx:			dma-able receive buffer
  **/
 struct sca3000_state {
 	struct spi_device		*us;
 	const struct sca3000_chip_info	*info;
-	struct work_struct		interrupt_handler_ws;
 	s64				last_timestamp;
 	int				mo_det_use_count;
 	struct mutex			lock;
-	int				bpse;
 	/* Can these share a cacheline ? */
 	u8				rx[384] ____cacheline_aligned;
 	u8				tx[6] ____cacheline_aligned;
@@ -1443,7 +1439,6 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 		goto error_ret;
 	ret = sca3000_write_reg(st, SCA3000_REG_ADDR_MODE,
 				(st->rx[0] & SCA3000_MODE_PROT_MASK));
-	st->bpse = 11;
 
 error_ret:
 	mutex_unlock(&st->lock);
-- 
2.10.0

