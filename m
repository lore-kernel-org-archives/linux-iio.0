Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36156 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbeJ0KkO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Oct 2018 06:40:14 -0400
Received: by mail-qk1-f196.google.com with SMTP id q184-v6so1847607qkd.3
        for <linux-iio@vger.kernel.org>; Fri, 26 Oct 2018 19:00:53 -0700 (PDT)
From: Matheus Tavares <matheus.bernardino@usp.br>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH v2 6/6] staging:iio:ad2s90: Check channel type at read_raw
Date: Fri, 26 Oct 2018 23:00:05 -0300
Message-Id: <20181027020005.3140-7-matheus.bernardino@usp.br>
In-Reply-To: <20181027020005.3140-1-matheus.bernardino@usp.br>
References: <20181027020005.3140-1-matheus.bernardino@usp.br>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This patch adds a channel type check at the beginning of the
ad2s90_read_raw function. Since ad2s90 has only one channel, it just
checks if the given channel is the expected one and if not, return
-EINVAL.

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---
 drivers/staging/iio/resolver/ad2s90.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
index 52b656875ed1..24002042a5c5 100644
--- a/drivers/staging/iio/resolver/ad2s90.c
+++ b/drivers/staging/iio/resolver/ad2s90.c
@@ -34,6 +34,9 @@ static int ad2s90_read_raw(struct iio_dev *indio_dev,
 	int ret;
 	struct ad2s90_state *st = iio_priv(indio_dev);
 
+	if (chan->type != IIO_ANGL)
+		return -EINVAL;
+
 	switch (m) {
 	case IIO_CHAN_INFO_SCALE:
 		/* 2 * Pi / (2^12 - 1) ~= 0.001534355 */
-- 
2.18.0
