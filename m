Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.17.12]:63715 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1760283AbcIXG1B (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Sep 2016 02:27:01 -0400
Subject: [PATCH 3/7] iio: Rename a jump label in iio_buffer_store_enable()
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
Message-ID: <7b90323b-2eff-ce51-588a-a9f6c1e5c2ed@users.sourceforge.net>
Date: Sat, 24 Sep 2016 08:26:44 +0200
MIME-Version: 1.0
In-Reply-To: <c11fbb47-1fd3-4e9e-042e-0f271cfef814@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 24 Sep 2016 07:11:32 +0200

Adjust a jump label according to the current Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/iio/industrialio-buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a865af8..6509f0f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -982,7 +982,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	inlist = iio_buffer_is_active(indio_dev->buffer);
 	/* Already in desired state */
 	if (inlist == requested_state)
-		goto done;
+		goto unlock;
 
 	if (requested_state)
 		ret = __iio_update_buffers(indio_dev,
@@ -990,8 +990,7 @@ static ssize_t iio_buffer_store_enable(struct device *dev,
 	else
 		ret = __iio_update_buffers(indio_dev,
 					 NULL, indio_dev->buffer);
-
-done:
+unlock:
 	mutex_unlock(&indio_dev->mlock);
 	return (ret < 0) ? ret : len;
 }
-- 
2.10.0

