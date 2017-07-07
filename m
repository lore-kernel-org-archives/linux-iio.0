Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway34.websitewelcome.com ([192.185.148.104]:24448 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750903AbdGGFQ1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jul 2017 01:16:27 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id 0E7621BC080
        for <linux-iio@vger.kernel.org>; Thu,  6 Jul 2017 23:53:12 -0500 (CDT)
Date: Thu, 6 Jul 2017 23:53:11 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() and
 devm_kmemdup() return values
Message-ID: <20170707045311.GA4535@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170706235151.Horde.0bV02ctiQ59WNlX28lLjSHX@gator4166.hostgator.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check return values from call to devm_kzalloc() and devm_kmemup()
in order to prevent a NULL pointer dereference.

This issue was detected using Coccinelle and the following semantic patch:

@@
expression x;
identifier fld;
@@

* x = devm_kzalloc(...);
   ... when != x == NULL
   x->fld

Cc: Peter Rosin <peda@axentia.se>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Add NULL check on devm_kmemup() return value.

 drivers/iio/multiplexer/iio-mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 37ba007..74831fc 100644
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
2.5.0

