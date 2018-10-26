Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41279 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbeJZJUR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 05:20:17 -0400
Received: by mail-qt1-f193.google.com with SMTP id l41-v6so12182004qtl.8
        for <linux-iio@vger.kernel.org>; Thu, 25 Oct 2018 17:45:27 -0700 (PDT)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 1/6] staging:iio:ad2s90: Make read_raw return spi_read's error code
Date: Thu, 25 Oct 2018 21:45:07 -0300
Message-Id: <20181026004512.31012-2-matheus.bernardino@usp.br>
In-Reply-To: <20181026004512.31012-1-matheus.bernardino@usp.br>
References: <20181026004512.31012-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Previously, when spi_read returned an error code inside ad2s90_read_raw,
the code was ignored and IIO_VAL_INT was returned. This patch makes the
function return the error code returned by spi_read when it fails.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 59586947a936..11fac9f90148 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -35,12 +35,15 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
 	mutex_lock(&st->lock);
+
 	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret)
-		goto error_ret;
+	if (ret < 0) {
+		mutex_unlock(&st->lock);
+		return ret;
+	}
+
 	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-error_ret:
 	mutex_unlock(&st->lock);
 
 	return IIO_VAL_INT;
-- 
2.18.0
