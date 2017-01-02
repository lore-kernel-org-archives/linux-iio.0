Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from tarvos.retrosnub.co.uk ([217.168.153.95]:60340 "EHLO
        tarvos.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933925AbdABT26 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 2 Jan 2017 14:28:58 -0500
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH 06/11] iio:buffer:iio_push_to_buffers_with_timestamp fix kernel-doc.
Date: Mon,  2 Jan 2017 19:28:29 +0000
Message-Id: <20170102192834.26546-7-jic23@kernel.org>
In-Reply-To: <20170102192834.26546-1-jic23@kernel.org>
References: <20170102192834.26546-1-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Wrong start of kernel doc comment /* -> /**

Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 include/linux/iio/buffer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index cd77ed14eb7f..8c915c2c18f1 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -163,7 +163,7 @@ void iio_buffer_init(struct iio_buffer *buffer);
 
 int iio_push_to_buffers(struct iio_dev *indio_dev, const void *data);
 
-/*
+/**
  * iio_push_to_buffers_with_timestamp() - push data and timestamp to buffers
  * @indio_dev:		iio_dev structure for device.
  * @data:		sample data
-- 
2.11.0

