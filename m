Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.18]:65337 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752959AbbH1WAZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 28 Aug 2015 18:00:25 -0400
From: Hartmut Knaack <knaack.h@gmx.de>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: [PATCH 4/6] iio:dac:m62332: drop unrequired variable
Date: Fri, 28 Aug 2015 23:59:56 +0200
Message-Id: <9a834bd03fd40333cb6e9935e51ecf801c81d38b.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
In-Reply-To: <cover.1440459082.git.knaack.h@gmx.de>
References: <cover.1440459082.git.knaack.h@gmx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

A return variable is not required in _write_raw(), and dropping it reduces
complexity, as well.

Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
---
 drivers/iio/dac/m62332.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index fe750982b502..1b65fc007bce 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -112,21 +112,17 @@ static int m62332_read_raw(struct iio_dev *indio_dev,
 static int m62332_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
-	int ret;
-
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (val < 0 || val > 255)
 			return -EINVAL;
 
-		ret = m62332_set_value(indio_dev, val, chan->channel);
-		break;
+		return m62332_set_value(indio_dev, val, chan->channel);
 	default:
-		ret = -EINVAL;
 		break;
 	}
 
-	return ret;
+	return -EINVAL;
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.4.6

