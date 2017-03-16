Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpauth-dc2.online.net ([62.210.16.40]:60916 "EHLO
        smtpauth-dc2-1.online.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751321AbdCPO2w (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 16 Mar 2017 10:28:52 -0400
From: Miguel Robles <miguel.robles@farole.net>
To: knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Miguel Robles <miguel.robles@farole.net>
Subject: [PATCH] Staging: iio: resolver: Fix warning, statements should start on a tabstop
Date: Thu, 16 Mar 2017 15:28:29 +0100
Message-Id: <1489674509-9641-1-git-send-email-miguel.robles@farole.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Fix checkpatch warning:
Statements should start on a tabstop.

Signed-off-by: Miguel Robles <miguel.robles@farole.net>
---
 drivers/staging/iio/resolver/ad2s1210.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
index 90b57c0..a6a8393 100644
--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -490,8 +490,8 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
 		ad2s1210_set_mode(MOD_VEL, st);
 		break;
 	default:
-	       ret = -EINVAL;
-	       break;
+		ret = -EINVAL;
+		break;
 	}
 	if (ret < 0)
 		goto error_ret;
-- 
2.7.4

