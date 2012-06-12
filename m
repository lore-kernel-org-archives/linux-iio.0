Return-Path: <pmeerw@pmeerw.net>
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH RESEND 3/4] iio: mark struct iio_enum elements with @ in comment
Date: Tue, 12 Jun 2012 14:42:25 +0200
Message-Id: <1339504946-16171-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net>
References: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

From: Peter Meerwald <p.meerwald@bct-electronic.com>

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>

---
 include/linux/iio/iio.h |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 44b9660..a35aa58 100644
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
1.7.5.4
