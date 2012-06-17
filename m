Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/4] iio: remove extra ; after function definition
Date: Sun, 17 Jun 2012 19:03:18 +0200
Message-Id: <1339952599-22105-6-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
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
