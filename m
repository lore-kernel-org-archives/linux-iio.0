Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40018 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbdK0Kyx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Nov 2017 05:54:53 -0500
Received: by mail-wr0-f193.google.com with SMTP id s41so20518291wrc.7
        for <linux-iio@vger.kernel.org>; Mon, 27 Nov 2017 02:54:52 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>
Subject: [PATCH] iio: dummy_evgen: modify the return value check for irq_sim_init()
Date: Mon, 27 Nov 2017 11:54:49 +0100
Message-Id: <20171127105449.27535-1-brgl@bgdev.pl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

As discussed with Marc Zyngier: irq_sim_init() and its devres variant
should return the base of the allocated interrupt range on success
rather than 0. This will be modified later - first, change the way
users handle the return value of these routines.

Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
---
 drivers/iio/dummy/iio_dummy_evgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
index fe8884543da0..efd0005f59b4 100644
--- a/drivers/iio/dummy/iio_dummy_evgen.c
+++ b/drivers/iio/dummy/iio_dummy_evgen.c
@@ -56,7 +56,7 @@ static int iio_dummy_evgen_create(void)
 		return -ENOMEM;
 
 	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
-	if (ret) {
+	if (ret < 0) {
 		kfree(iio_evgen);
 		return ret;
 	}
-- 
2.15.0

