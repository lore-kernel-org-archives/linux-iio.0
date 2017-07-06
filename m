Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from gateway30.websitewelcome.com ([192.185.196.18]:25925 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752937AbdGFW5R (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jul 2017 18:57:17 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway30.websitewelcome.com (Postfix) with ESMTP id 7BCF0143BE
        for <linux-iio@vger.kernel.org>; Thu,  6 Jul 2017 17:08:52 -0500 (CDT)
Date: Thu, 6 Jul 2017 17:08:51 -0500
From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
To: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] iio: multiplexer: add NULL check on devm_kzalloc() return
 value
Message-ID: <20170706220851.GA26284@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Check return value from call to devm_kzalloc()
in order to prevent a NULL pointer dereference.

This issue was detected using Coccinelle and the following semantic patch:

@@
expression x;
identifier fld;
@@

* x = devm_kzalloc(...);
  ... when != x == NULL
  x->fld


Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/iio/multiplexer/iio-mux.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/multiplexer/iio-mux.c b/drivers/iio/multiplexer/iio-mux.c
index 37ba007..a8d672b 100644
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
 
-- 
2.5.0

