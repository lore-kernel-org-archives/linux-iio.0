Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from onstation.org ([52.200.56.107]:47162 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbcLDCUV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Dec 2016 21:20:21 -0500
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
Subject: [PATCH 06/19] staging: iio: isl29028: made alignment of variables in struct isl29028_chip consistent
Date: Sat,  3 Dec 2016 21:19:30 -0500
Message-Id: <1480817983-32359-7-git-send-email-masneyb@onstation.org>
In-Reply-To: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
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
index d5b069e..fe8814b 100644
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
 	bool				suspended;
 };
-- 
2.7.4

