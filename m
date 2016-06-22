Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:52777 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751600AbcFVTnn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Jun 2016 15:43:43 -0400
From: Luis de Bethencourt <luisbg@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, ciorneiioana@gmail.com,
	afd@ti.com, janani.rvchndrn@gmail.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	Luis de Bethencourt <luisbg@osg.samsung.com>
Subject: [RESEND PATCH v2 2/2] staging: iio: accel: add error check
Date: Wed, 22 Jun 2016 20:43:31 +0100
Message-Id: <1466624611-4494-2-git-send-email-luisbg@osg.samsung.com>
In-Reply-To: <1466624611-4494-1-git-send-email-luisbg@osg.samsung.com>
References: <1466624611-4494-1-git-send-email-luisbg@osg.samsung.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Go to error_ret if sca3000_read_ctrl_reg() failed.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/staging/iio/accel/sca3000_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
index ec12181..b3f6dbf 100644
--- a/drivers/staging/iio/accel/sca3000_core.c
+++ b/drivers/staging/iio/accel/sca3000_core.c
@@ -1046,6 +1046,8 @@ static int sca3000_clean_setup(struct sca3000_state *st)
 
 	/* Disable ring buffer */
 	ret = sca3000_read_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL);
+	if (ret < 0)
+		goto error_ret;
 	ret = sca3000_write_ctrl_reg(st, SCA3000_REG_CTRL_SEL_OUT_CTRL,
 				     (ret & SCA3000_OUT_CTRL_PROT_MASK)
 				     | SCA3000_OUT_CTRL_BUF_X_EN
-- 
2.5.1

