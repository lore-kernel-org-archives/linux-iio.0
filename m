Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.11]:61647 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933345AbcIXG3f (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Sep 2016 02:29:35 -0400
Subject: [PATCH 5/7] iio: Rename a jump label in iio_scan_el_ts_store()
To: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <2f1065fe-571a-a519-7b40-4ddf1552b2a6@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:29:19 +0200
MIME-Version: 1.0
In-Reply-To: <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 07:27:26 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/industrialio-buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 376101f..4b8f313 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -409,10 +409,10 @@ static ssize_t iio_scan_el_ts_store(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 	if (iio_buffer_is_active(indio_dev->buffer)) {
 		ret = -EBUSY;
-		goto error_ret;
+		goto unlock;
 	}
 	indio_dev->buffer->scan_timestamp = state;
-error_ret:
+unlock:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret ? ret : len;
-- 
2.10.0

