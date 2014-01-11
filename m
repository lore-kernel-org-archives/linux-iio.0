Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:40342 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751345AbaAKOzA (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 11 Jan 2014 09:55:00 -0500
From: Peter Meerwald <pmeerw@pmeerw.net>
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald <pmeerw@pmeerw.net>,
	kbuild test robot <fengguang.wu@intel.com>
Subject: [PATCH] iio:pressure:mpl3115: Fix sparse cast to restricted __be32 warning
Date: Sat, 11 Jan 2014 15:54:53 +0100
Message-Id: <1389452093-16214-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> drivers/iio/pressure/mpl3115.c:101:46: sparse: cast to restricted __be32
>> drivers/iio/pressure/mpl3115.c:115:46: sparse: cast to restricted __be32

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: kbuild test robot <fengguang.wu@intel.com>
---
 drivers/iio/pressure/mpl3115.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index ac8c8ab..ba6d0c5 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -77,7 +77,7 @@ static int mpl3115_read_raw(struct iio_dev *indio_dev,
 			    int *val, int *val2, long mask)
 {
 	struct mpl3115_data *data = iio_priv(indio_dev);
-	s32 tmp = 0;
+	__be32 tmp = 0;
 	int ret;
 
 	switch (mask) {
-- 
1.8.3.2

