Return-Path: <cristina.opriceana@gmail.com>
Date: Fri, 24 Jul 2015 16:23:43 +0300
From: Cristina Opriceana <cristina.opriceana@gmail.com>
To: jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	daniel.baluta@intel.com
Subject: [PATCH 5/6] include: linux: iio: Fix function parameter name in
 kernel doc
Message-ID: <7461b4e6114a382e8669e132a8ef29c232b376c1.1437737942.git.cristina.opriceana@gmail.com>
References: <cover.1437737942.git.cristina.opriceana@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1437737942.git.cristina.opriceana@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Fix buffer name from kernel doc according to the function parameter.

Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
---
 include/linux/iio/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
index 26fb8f6..fad5867 100644
--- a/include/linux/iio/consumer.h
+++ b/include/linux/iio/consumer.h
@@ -100,7 +100,7 @@ void iio_channel_stop_all_cb(struct iio_cb_buffer *cb_buff);
 
 /**
  * iio_channel_cb_get_channels() - get access to the underlying channels.
- * @cb_buff:		The callback buffer from whom we want the channel
+ * @cb_buffer:		The callback buffer from whom we want the channel
  *			information.
  *
  * This function allows one to obtain information about the channels.
-- 
1.9.1
