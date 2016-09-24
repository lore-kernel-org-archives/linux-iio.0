Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63999 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758507AbcIXGaY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Sep 2016 02:30:24 -0400
Subject: [PATCH 6/7] iio: Rename a jump label in iio_scan_el_store()
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
Message-ID: <7d0faf7f-6163-bce6-07fc-840efbbab99a@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:30:08 +0200
MIME-Version: 1.0
In-Reply-To: <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 07:40:59 +0200

Adjust jump labels according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/industrialio-buffer.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 4b8f313..57e201a 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -363,22 +363,21 @@ static ssize_t iio_scan_el_store(struct device *dev,
 	mutex_lock(&indio_dev->mlock);
 	if (iio_buffer_is_active(indio_dev->buffer)) {
 		ret = -EBUSY;
-		goto error_ret;
+		goto unlock;
 	}
 	ret = iio_scan_mask_query(indio_dev, buffer, this_attr->address);
 	if (ret < 0)
-		goto error_ret;
+		goto unlock;
 	if (!state && ret) {
 		ret = iio_scan_mask_clear(buffer, this_attr->address);
 		if (ret)
-			goto error_ret;
+			goto unlock;
 	} else if (state && !ret) {
 		ret = iio_scan_mask_set(indio_dev, buffer, this_attr->address);
 		if (ret)
-			goto error_ret;
+			goto unlock;
 	}
-
-error_ret:
+unlock:
 	mutex_unlock(&indio_dev->mlock);
 
 	return ret < 0 ? ret : len;
-- 
2.10.0

