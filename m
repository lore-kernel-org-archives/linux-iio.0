Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:40557 "EHLO
        mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932089AbdJJQPh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Oct 2017 12:15:37 -0400
Message-Id: <e46d722561e1d2288ff8f421332c0499e38a2dcb.1507651877.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 10 Oct 2017 18:15:34 +0200
Subject: [PATCH] iio: Drop duplicate forward declaration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Commit 5f420b42079c ("staging:iio: Add extended IIO channel info") added
a forward declaration for struct iio_dev to <linux/iio/iio.h> but forgot
to remove an existing forward declaration further down originating from
commit 7ae8cf627558 ("staging: iio: chrdev.h rationalization").

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 include/linux/iio/iio.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 50cae85..20b6134 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -365,7 +365,6 @@ static inline bool iio_channel_has_available(const struct iio_chan_spec *chan,
 #define INDIO_MAX_RAW_ELEMENTS		4
 
 struct iio_trigger; /* forward declaration */
-struct iio_dev;
 
 /**
  * struct iio_info - constant information about device
-- 
2.11.0

