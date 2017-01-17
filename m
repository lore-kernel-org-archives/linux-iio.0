Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:48986 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750968AbdAQJZO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 17 Jan 2017 04:25:14 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH v2 01/15] staging: iio: isl29028: made alignment of variables in struct isl29028_chip consistent
Date: Tue, 17 Jan 2017 04:24:48 -0500
Message-Id: <20170117092502.6951-2-masneyb@onstation.org>
In-Reply-To: <20170117092502.6951-1-masneyb@onstation.org>
References: <20170117092502.6951-1-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The alignment of the variables in the struct isl29028_chip is not
consistent. This changes all of the variables to use consistent
alignment to improve the code readability.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29028.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
index 1de81f5..4cce663 100644
--- a/drivers/staging/iio/light/isl29028.c
+++ b/drivers/staging/iio/light/isl29028.c
@@ -67,13 +67,13 @@ enum isl29028_als_ir_mode {
 };
 
 struct isl29028_chip {
-	struct mutex		lock;
-	struct regmap		*regmap;
+	struct mutex			lock;
+	struct regmap			*regmap;
 
-	unsigned int		prox_sampling;
-	bool			enable_prox;
+	unsigned int			prox_sampling;
+	bool				enable_prox;
 
-	int			lux_scale;
+	int				lux_scale;
 	enum isl29028_als_ir_mode	als_ir_mode;
 };
 
-- 
2.9.3

