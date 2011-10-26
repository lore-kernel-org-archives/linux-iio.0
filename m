Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:46254 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933623Ab1JZQ1j (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 26 Oct 2011 12:27:39 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, "Maxin B. John" <maxin.john@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 02/10] staging:iio:light:tsl2563 missing setting of id in get id function.
Date: Wed, 26 Oct 2011 17:27:37 +0100
Message-Id: <1319646465-2788-3-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
References: <1319646465-2788-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: "Maxin B. John" <maxin.john@gmail.com>

Signed-off-by: Maxin B. John <maxin.john@gmail.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index be99925..6a17945 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -226,6 +226,8 @@ static int tsl2563_read_id(struct tsl2563_chip *chip, u8 *id)
 	if (ret < 0)
 		return ret;
 
+	*id = ret;
+
 	return 0;
 }
 
-- 
1.7.7

