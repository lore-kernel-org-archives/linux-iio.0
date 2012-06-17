Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: typo in iio_chan_spec.ext_info comment
Date: Sun, 17 Jun 2012 19:03:16 +0200
Message-Id: <1339952599-22105-4-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
References: <1339952599-22105-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
---
 include/linux/iio/iio.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index ae0cad9..2afbb6f 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -214,7 +214,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  * @event_mask:		What events can this channel produce.
  * @ext_info:		Array of extended info attributes for this channel.
  *			The array is NULL terminated, the last element should
- *			have it's name field set to NULL.
+ *			have its name field set to NULL.
  * @extend_name:	Allows labeling of channel attributes with an
  *			informative name. Note this has no effect codes etc,
  *			unlike modifiers.
-- 
1.7.9.5
