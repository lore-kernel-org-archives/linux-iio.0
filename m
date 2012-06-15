Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:48641 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753900Ab2FORZb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 15 Jun 2012 13:25:31 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 3/6] iio: iio/machine.h typo
Date: Fri, 15 Jun 2012 19:25:25 +0200
Message-Id: <1339781128-2718-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
References: <1339781128-2718-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 include/linux/iio/machine.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/iio/machine.h b/include/linux/iio/machine.h
index 0b1f19b..400a453 100644
--- a/include/linux/iio/machine.h
+++ b/include/linux/iio/machine.h
@@ -14,7 +14,7 @@
  *			This is matched against the datasheet_name element
  *			of struct iio_chan_spec.
  * @consumer_dev_name:	Name to uniquely identify the consumer device.
- * @consumer_channel:	Unique name used to idenitify the channel on the
+ * @consumer_channel:	Unique name used to identify the channel on the
  *			consumer side.
  */
 struct iio_map {
-- 
1.7.9.5

