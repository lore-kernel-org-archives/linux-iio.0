Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58370 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752984AbcJCT1L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Oct 2016 15:27:11 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 01/18] staging:iio:accel:sca3000 Fix a use before setting of the indio_dev->buffer pointer.
Date: Mon,  3 Oct 2016 20:26:45 +0100
Message-Id: <20161003192702.24361-2-jic23@kernel.org>
In-Reply-To: <20161003192702.24361-1-jic23@kernel.org>
References: <20161003192702.24361-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000_ring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
index d1cb9b9cf22b..e5de52d05a5c 100644
--- a/drivers/staging/iio/accel/sca3000_ring.c
+++ b/drivers/staging/iio/accel/sca3000_ring.c
@@ -270,8 +270,8 @@ int sca3000_configure_ring(struct iio_dev *indio_dev)
 		return -ENOMEM;
 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
 
-	indio_dev->buffer->access = &sca3000_ring_access_funcs;
 
+	buffer->access = &sca3000_ring_access_funcs;
 	iio_device_attach_buffer(indio_dev, buffer);
 
 	return 0;
-- 
2.10.0

