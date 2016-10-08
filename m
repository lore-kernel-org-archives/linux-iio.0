Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35380 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756250AbcJHQjb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:39:31 -0400
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 03/18] staging:iio:accel:sca3000 drop sca3000_register_ring_funcs
Date: Sat,  8 Oct 2016 17:39:03 +0100
Message-Id: <20161008163918.18758-4-jic23@kernel.org>
In-Reply-To: <20161008163918.18758-1-jic23@kernel.org>
References: <20161008163918.18758-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This was needed when the buffer support was optional. Pointless wrapper
now so drop it.

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/staging/iio/accel/sca3000.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/iio/accel/sca3000.c b/drivers/staging/iio/accel/sca3000.c
index 62ab1aef2528..36a52d02ee0e 100644
--- a/drivers/staging/iio/accel/sca3000.c
+++ b/drivers/staging/iio/accel/sca3000.c
@@ -1504,11 +1504,6 @@ static const struct iio_buffer_setup_ops sca3000_ring_setup_ops = {
 	.postdisable = &sca3000_hw_ring_postdisable,
 };
 
-static void sca3000_register_ring_funcs(struct iio_dev *indio_dev)
-{
-	indio_dev->setup_ops = &sca3000_ring_setup_ops;
-}
-
 /**
  * sca3000_clean_setup() get the device into a predictable state
  *
@@ -1631,7 +1626,7 @@ static int sca3000_probe(struct spi_device *spi)
 		if (ret)
 			goto error_unregister_dev;
 	}
-	sca3000_register_ring_funcs(indio_dev);
+	indio_dev->setup_ops = &sca3000_ring_setup_ops;
 	ret = sca3000_clean_setup(st);
 	if (ret)
 		goto error_free_irq;
-- 
2.10.0

