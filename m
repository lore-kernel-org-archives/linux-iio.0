Return-Path: <SRS0=giCJ=74=wanadoo.fr=christophe.jaillet@kernel.org>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: peda@axentia.se,
	jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] iio: multiplexer: check memory allocation failure
Date: Sat, 26 Aug 2017 07:49:52 +0200
Message-Id: <20170826054952.1449-1-christophe.jaillet@wanadoo.fr>
List-ID: <linux-iio@vger.kernel.org>

Check memory allocation failures and return -ENOMEM in such cases, as
already done few lines above for another memory allocation.

This avoids NULL pointers dereference.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/iio/multiplexer/iio-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 37ba007f8dca..74831fcd0313 100644
--- a/drivers/iio/multiplexer/iio-mux.c
+++ b/drivers/iio/multiplexer/iio-mux.c
@@ -285,6 +285,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
 	child->ext_info_cache = devm_kzalloc(dev,
 					     sizeof(*child->ext_info_cache) *
 					     num_ext_info, GFP_KERNEL);
+	if (!child->ext_info_cache)
+		return -ENOMEM;
+
 	for (i = 0; i < num_ext_info; ++i) {
 		child->ext_info_cache[i].size = -1;
 
@@ -309,6 +312,9 @@ static int mux_configure_channel(struct device *dev, struct mux *mux,
 
 		child->ext_info_cache[i].data = devm_kmemdup(dev, page, ret + 1,
 							     GFP_KERNEL);
+		if (!child->ext_info_cache[i].data)
+			return -ENOMEM;
+
 		child->ext_info_cache[i].data[ret] = 0;
 		child->ext_info_cache[i].size = ret;
 	}
-- 
2.11.0
