Return-Path: <SRS0=axIo=C4=gmail.com=arvind.yadav.cs@kernel.org>
From: Arvind Yadav <arvind.yadav.cs@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	samuel@sortiz.org
Cc: linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH 3/3] staging: irda: Remove unnecessary 'err' initialization.
Date: Thu, 30 Nov 2017 21:13:36 +0530
Message-Id: <1512056616-21065-4-git-send-email-arvind.yadav.cs@gmail.com>
In-Reply-To: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1512056616-21065-1-git-send-email-arvind.yadav.cs@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Here, variable 'err' is already initialised. So no need to reinitialize.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/staging/irda/drivers/pxaficp_ir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/irda/drivers/pxaficp_ir.c b/drivers/staging/irda/drivers/pxaficp_ir.c
index a97ce04..6c77370 100644
--- a/drivers/staging/irda/drivers/pxaficp_ir.c
+++ b/drivers/staging/irda/drivers/pxaficp_ir.c
@@ -807,7 +807,6 @@ static int pxa_irda_start(struct net_device *dev)
 	 * Open a new IrLAP layer instance.
 	 */
 	si->irlap = irlap_open(dev, &si->qos, "pxa");
-	err = -ENOMEM;
 	if (!si->irlap)
 		goto err_irlap;
 
-- 
2.7.4
