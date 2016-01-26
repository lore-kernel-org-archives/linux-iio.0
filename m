Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:26656 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933532AbcAZJZz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 26 Jan 2016 04:25:55 -0500
Date: Tue, 26 Jan 2016 12:25:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Marek Belisko <marek@goldelico.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] iio: inkern: fix a NULL dereference on error
Message-ID: <20160126092521.GC15717@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In twl4030_bci_probe() there are some failure paths where we call
iio_channel_release() with a NULL pointer.  (Apparently, that driver can
opperate without a valid channel pointer).  Let's fix it by adding a
NULL check in iio_channel_release().

Fixes: 2202e1fc5a29 ('drivers: power: twl4030_charger: fix link problems when building as module')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 80fbbfd..734a004 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -349,6 +349,8 @@ EXPORT_SYMBOL_GPL(iio_channel_get);
 
 void iio_channel_release(struct iio_channel *channel)
 {
+	if (!channel)
+		return;
 	iio_device_put(channel->indio_dev);
 	kfree(channel);
 }
