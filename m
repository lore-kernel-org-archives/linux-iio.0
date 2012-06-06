Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:53122 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094Ab2FFT6b (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 6 Jun 2012 15:58:31 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 2/2] iio: mark parameters with @ in comment
Date: Wed,  6 Jun 2012 21:58:25 +0200
Message-Id: <1339012705-6334-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339012705-6334-1-git-send-email-pmeerw@pmeerw.net>
References: <1339012705-6334-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 include/linux/iio/iio.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 9d9b55a..e3cab18 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -131,10 +131,10 @@ struct iio_chan_spec_ext_info {
 
 /**
  * struct iio_enum - Enum channel info attribute
- * items: An array of strings.
- * num_items: Length of the item array.
- * set: Set callback function, may be NULL.
- * get: Get callback function, may be NULL.
+ * @items: An array of strings.
+ * @num_items: Length of the item array.
+ * @set: Set callback function, may be NULL.
+ * @get: Get callback function, may be NULL.
  *
  * The iio_enum struct can be used to implement enum style channel attributes.
  * Enum style attributes are those which have a set of strings which map to
-- 
1.7.9.5

