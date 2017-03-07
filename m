Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:56672 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbdCGQiQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2017 11:38:16 -0500
From: Colin King <colin.king@canonical.com>
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iio: multiplexer: fix unsigned check with less than zero
Date: Tue,  7 Mar 2017 15:06:31 +0000
Message-Id: <20170307150631.31043-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Comparing a size_t with less than zero is always false as size_t
is unsigned. The intent of the comparison was to check if the size
was -1 (that is, undefined), so use that instead.

Detected by CoverityScan, CID#1415278 ("Unsigned compared against 0")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/iio/multiplexer/iio-mux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 94d40f9b..6c23033 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -61,7 +61,7 @@ static int iio_mux_select(struct mux *mux, int idx)
 
 			cache = &child->ext_info_cache[i];
 
-			if (cache->size < 0)
+			if (cache->size == (size_t)-1)
 				continue;
 
 			ret = iio_write_channel_ext_info(mux->parent, attr,
-- 
2.10.2

