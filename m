Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34564 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752150AbcEAUh3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 1 May 2016 16:37:29 -0400
From: "Andrew F. Davis" <afd@ti.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
CC: <linux-iio@vger.kernel.org>, <linux-api@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 05/13] iio: health/afe440x: Fix scan_index assignment
Date: Sun, 1 May 2016 15:36:55 -0500
Message-ID: <1462135023-14445-6-git-send-email-afd@ti.com>
In-Reply-To: <1462135023-14445-1-git-send-email-afd@ti.com>
References: <1462135023-14445-1-git-send-email-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The LED channels are not scannable and so scan_index should
be negative, fix this here.

Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 drivers/iio/health/afe440x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/health/afe440x.h b/drivers/iio/health/afe440x.h
index 544bbab..583d071 100644
--- a/drivers/iio/health/afe440x.h
+++ b/drivers/iio/health/afe440x.h
@@ -125,7 +125,7 @@ struct afe440x_reg_info {
 		.type = IIO_CURRENT,				\
 		.channel = _index,				\
 		.address = _index,				\
-		.scan_index = _index,				\
+		.scan_index = -1,				\
 		.extend_name = _name,				\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |	\
 			BIT(IIO_CHAN_INFO_SCALE),		\
-- 
2.8.1

