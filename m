Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:32875 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753461AbdBRUXu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2017 15:23:50 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so7945118pgj.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2017 12:23:03 -0800 (PST)
Date: Sun, 19 Feb 2017 01:52:40 +0530
From: sayli karnik <karniksayli1995@gmail.com>
To: outreachy-kernel@googlegroups.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/3] staging: iio: ad7152: Add a blank line after a function
 definition
Message-ID: <ddaac235c7d0ea2b1a9218a22b3b1e8f6510215e.1487448326.git.karniksayli1995@gmail.com>
References: <cover.1487448326.git.karniksayli1995@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1487448326.git.karniksayli1995@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch resolves the checkpatch issue:
CHECK: Please use a blank line after function/struct/union/enum declarations.

Signed-off-by: sayli karnik <karniksayli1995@gmail.com>
---
 drivers/staging/iio/cdc/ad7152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 988b89b..2ed6a90 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -244,6 +244,7 @@ static int ad7152_write_raw_samp_freq(struct device *dev, int val)
 
 	return ret;
 }
+
 static int ad7152_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan,
 			    int val,
-- 
2.7.4

