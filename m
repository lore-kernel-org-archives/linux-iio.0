Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp03.smtpout.orange.fr ([80.12.242.125]:41345 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935001AbdCVQjm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 12:39:42 -0400
From: Olivier Leveque <o_leveque@orange.fr>
To: lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org
Cc: Olivier Leveque <o_leveque@orange.fr>
Subject: [PATCH] staging: iio: resolver: ad2s1210: Coding style fix
Date: Wed, 22 Mar 2017 17:37:11 +0100
Message-Id: <1490200631-4415-1-git-send-email-o_leveque@orange.fr>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Apply proper indentation in order to follow the linux kernel coding style

Signed-off-by: Olivier Leveque <o_leveque@orange.fr>
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
1.9.1

