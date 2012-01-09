Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from relay02-haj2.antispameurope.com ([83.246.65.52]:34288 "EHLO
	relay02-haj2.antispameurope.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932255Ab2AIQIq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2012 11:08:46 -0500
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Subject: [PATCH 1/3] staging: iio: core: fix argument of iio_buffer_register (must be const)
Date: Mon,  9 Jan 2012 17:02:52 +0100
Message-Id: <1326124974-7288-1-git-send-email-manuel.stahl@iis.fraunhofer.de>
To: jic23@cam.ac.uk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
---
 drivers/staging/iio/buffer.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/buffer.h b/drivers/staging/iio/buffer.h
index 44593b2..1a35006 100644
--- a/drivers/staging/iio/buffer.h
+++ b/drivers/staging/iio/buffer.h
@@ -197,8 +197,8 @@ int iio_sw_buffer_preenable(struct iio_dev *indio_dev);
 #else /* CONFIG_IIO_BUFFER */
 
 static inline int iio_buffer_register(struct iio_dev *indio_dev,
-					   struct iio_chan_spec *channels,
-					   int num_channels)
+				      const struct iio_chan_spec *channels,
+				      int num_channels)
 {
 	return 0;
 }
-- 
1.7.3.rc1

