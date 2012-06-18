Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47283 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751905Ab2FRSdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 14:33:09 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: remove extra ; after function definition
Date: Mon, 18 Jun 2012 20:33:03 +0200
Message-Id: <1340044387-2725-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 include/linux/iio/buffer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index fb0fe46..ad4fb1a 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -184,7 +184,7 @@ static inline int iio_buffer_register(struct iio_dev *indio_dev,
 }
 
 static inline void iio_buffer_unregister(struct iio_dev *indio_dev)
-{};
+{}
 
 #endif /* CONFIG_IIO_BUFFER */
 
-- 
1.7.9.5

