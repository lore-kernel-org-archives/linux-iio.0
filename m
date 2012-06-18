Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47279 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab2FRSdJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 14:33:09 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/4] iio: typo in iio_chan_spec.ext_info comment
Date: Mon, 18 Jun 2012 20:33:01 +0200
Message-Id: <1340044387-2725-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

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

