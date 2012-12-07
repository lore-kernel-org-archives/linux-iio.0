Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:46453 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753532Ab2LGPZP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Dec 2012 10:25:15 -0500
From: Marek Vasut <marex@denx.de>
To: linux-iio@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/4] iio: mxs: Remove unused fields from mxs_lradc
Date: Fri,  7 Dec 2012 16:24:51 +0100
Message-Id: <1354893893-26338-2-git-send-email-marex@denx.de>
In-Reply-To: <1354893893-26338-1-git-send-email-marex@denx.de>
References: <1354893893-26338-1-git-send-email-marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Remove unused "enable" field from struct mxs_lradc. This seems to be
remnant of early development.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/staging/iio/adc/mxs-lradc.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
index 67abf50..6249957 100644
--- a/drivers/staging/iio/adc/mxs-lradc.c
+++ b/drivers/staging/iio/adc/mxs-lradc.c
@@ -85,8 +85,6 @@ struct mxs_lradc {
 
 	struct mutex		lock;
 
-	uint8_t			enable;
-
 	struct completion	completion;
 };
 
-- 
1.7.10.4

