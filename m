Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([87.118.82.44]:47289 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab2FRSdK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 18 Jun 2012 14:33:10 -0400
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Subject: [PATCH] iio staging: fix typos in tsl*: register
Date: Mon, 18 Jun 2012 20:33:06 +0200
Message-Id: <1340044387-2725-7-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
References: <1340044387-2725-1-git-send-email-pmeerw@pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>

---
 drivers/staging/iio/light/tsl2583.c      |    2 +-
 drivers/staging/iio/light/tsl2x7x_core.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
index 5e23ad5..6d2f4c6 100644
--- a/drivers/staging/iio/light/tsl2583.c
+++ b/drivers/staging/iio/light/tsl2583.c
@@ -410,7 +410,7 @@ static int taos_chip_on(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	/* determine als integration regster */
+	/* determine als integration register */
 	als_count = (chip->taos_settings.als_time * 100 + 135) / 270;
 	if (als_count == 0)
 		als_count = 1; /* ensure at least one cycle */
diff --git a/drivers/staging/iio/light/tsl2x7x_core.c b/drivers/staging/iio/light/tsl2x7x_core.c
index 040da4a..fdf75e4 100644
--- a/drivers/staging/iio/light/tsl2x7x_core.c
+++ b/drivers/staging/iio/light/tsl2x7x_core.c
@@ -736,7 +736,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
-	/* determine als integration regster */
+	/* determine als integration register */
 	als_count = (chip->tsl2x7x_settings.als_time * 100 + 135) / 270;
 	if (als_count == 0)
 		als_count = 1; /* ensure at least one cycle */
-- 
1.7.9.5

