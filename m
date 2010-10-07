Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:52686 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754440Ab0JGMEr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Oct 2010 08:04:47 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 2/3] staging:iio:sca3000 fix bug due to scan_element directory move.
Date: Thu,  7 Oct 2010 13:10:20 +0100
Message-Id: <1286453421-7584-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
References: <1286453421-7584-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The device found passed to the attr functions is that of the ring
buffer, not the the iio_dev so we need to bounce through one more
hop to get the right address.

Reported-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/sca3000_ring.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index 8186d2b..c872fdd 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -138,7 +138,8 @@ static ssize_t sca3000_show_ring_bpse(struct device *dev,
 {
 	int len = 0, ret;
 	u8 *rx;
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = indio_dev->dev_data;
 
 	mutex_lock(&st->lock);
@@ -168,7 +169,8 @@ static ssize_t sca3000_store_ring_bpse(struct device *dev,
 				      const char *buf,
 				      size_t len)
 {
-	struct iio_dev *indio_dev = dev_get_drvdata(dev);
+	struct iio_ring_buffer *ring = dev_get_drvdata(dev);
+	struct iio_dev *indio_dev = ring->indio_dev;
 	struct sca3000_state *st = indio_dev->dev_data;
 	int ret;
 	u8 *rx;
-- 
1.7.2.2

