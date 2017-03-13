Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36542 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbdCMJYK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 05:24:10 -0400
Received: by mail-pg0-f66.google.com with SMTP id 25so17513604pgy.3
        for <linux-iio@vger.kernel.org>; Mon, 13 Mar 2017 02:24:09 -0700 (PDT)
Message-ID: <58c66533.42d5620a.3e22a.3a06@mx.google.com>
Date: Mon, 13 Mar 2017 14:53:57 +0530
From: Varsha Rao <rvarsha016@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Barry Song <21cnbao@gmail.com>, linux-iio@vger.kernel.org
Cc: outreachy-kernel@googlegroups.com
Subject: [PATCH 2/2] staging: iio: adis16240: Modify existing comment.
References: <cover.1489395260.git.rvarsha016@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1489395260.git.rvarsha016@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Modify the existing comment to reflect the changes from mlock to
txrx_lock.

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/staging/iio/accel/adis16240.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/accel/adis16240.c b/drivers/staging/iio/accel/adis16240.c
index c182b2d..aa3030c 100644
--- a/drivers/staging/iio/accel/adis16240.c
+++ b/drivers/staging/iio/accel/adis16240.c
@@ -231,7 +231,7 @@ static ssize_t adis16240_read_12bit_signed(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct adis *st = iio_priv(indio_dev);
 
-	/* Take the iio_dev status lock */
+	/* Take adis txrx_lock to protect sensor state */
 	mutex_lock(&st->txrx_lock);
 	ret =  adis16240_spi_read_signed(dev, attr, buf, 12);
 	mutex_unlock(&st->txrx_lock);
-- 
2.9.3

