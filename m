Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45752 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeKDICt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 03:02:49 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so8909991qkc.12
        for <linux-iio@vger.kernel.org>; Sat, 03 Nov 2018 15:50:08 -0700 (PDT)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v3 1/6] staging:iio:ad2s90: Make read_raw return spi_read's error code
Date: Sat,  3 Nov 2018 19:49:43 -0300
Message-Id: <20181103224948.31014-2-matheus.bernardino@usp.br>
In-Reply-To: <20181103224948.31014-1-matheus.bernardino@usp.br>
References: <20181103224948.31014-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Previously, when spi_read returned an error code inside ad2s90_read_raw,
the code was ignored and IIO_VAL_INT was returned. This patch makes the
function return the error code returned by spi_read when it fails.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 59586947a936..ba55de29ef36 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -36,11 +36,12 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->lock);
 	ret = spi_read(st->sdev, st->rx, 2);
-	if (ret)
-		goto error_ret;
+	if (ret < 0) {
+		mutex_unlock(&st->lock);
+		return ret;
+	}
 	*val = (((u16)(st->rx[0])) << 4) | ((st->rx[1] & 0xF0) >> 4);
 
-error_ret:
 	mutex_unlock(&st->lock);
 
 	return IIO_VAL_INT;
-- 
2.18.0
