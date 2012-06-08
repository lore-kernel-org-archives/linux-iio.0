Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:43446 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754745Ab2FHGyW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 8 Jun 2012 02:54:22 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH 1/2] iio: remove indio_dev pointer from max517_data
Date: Fri,  8 Jun 2012 08:54:17 +0200
Message-Id: <1339138458-22608-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Roland Stigge <stigge@antcom.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/iio/dac/max517.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/dac/max517.c b/drivers/iio/dac/max517.c
index 92c77c8..352abe2 100644
--- a/drivers/iio/dac/max517.c
+++ b/drivers/iio/dac/max517.c
@@ -43,7 +43,6 @@ enum max517_device_ids {
 };
 
 struct max517_data {
-	struct iio_dev		*indio_dev;
 	struct i2c_client	*client;
 	unsigned short		vref_mv[2];
 };
-- 
1.7.9.5

