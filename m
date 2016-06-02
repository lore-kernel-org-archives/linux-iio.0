Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36309 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189AbcFBKGj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 2 Jun 2016 06:06:39 -0400
From: Colin King <colin.king@canonical.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] iio: dac: fix off-by-one comparison and out-of-bounds write
Date: Thu,  2 Jun 2016 11:06:30 +0100
Message-Id: <1464861990-9155-1-git-send-email-colin.king@canonical.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check on reg is off-by-one, it should be >= rather than >. Fix
this to stop an out-of-bounds write to st->channel_modes[reg].

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/dac/ad5592r-base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5592r-base.c b/drivers/iio/dac/ad5592r-base.c
index 948f600..69bde59 100644
--- a/drivers/iio/dac/ad5592r-base.c
+++ b/drivers/iio/dac/ad5592r-base.c
@@ -525,7 +525,7 @@ static int ad5592r_alloc_channels(struct ad5592r_state *st)
 
 	device_for_each_child_node(st->dev, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > ARRAY_SIZE(st->channel_modes))
+		if (ret || reg >= ARRAY_SIZE(st->channel_modes))
 			continue;
 
 		ret = fwnode_property_read_u32(child, "adi,mode", &tmp);
-- 
2.8.1

