Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793764818;
	b=VGYVilsphOXZJXc2jHXJBfYt1ifCWJY65tXqIrRPIbj77sAPOBNd9V1TbBdWdm82iVz8
	 /FDqVK6dGAjtn0GSQC/EYsjhXzBNrHLzIOul8ejD+nv8kOU0froXPHKwHFa3zISqLPm8A
	 QzSAhA2ozdn/3OnLi3PFaVE7ll57wZtNMtgL1l0uw0iyqJUI8uq7uZ602FFpd7qgpz4NQ
	 GdYiPHVgXBL3G1tkS82tNw+OSdvwusEb1TccezZU1/KmNxcrZWKU7gGWpGbF/39GqN7c/
	 Fi3alfra7YfIfppgNGBZhGUxrGeJtl7qXYlTpEcbeXXQu3/ZN9kn6uEh6vlPeFvn/NQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793764818;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=URxPXkf42aAY6gkWDUtC38Jhj7gAxc9VlGiEAt+2XSQ=;
	b=BwX+585Fu2uo73oP28+gPhdsTC5DoaK0WMCfN0xCh4aK7s/UQq2sNEnO4bQMOKLsH8OX
	 itf5pw/PJ+9OLLmXZnc5GlTnC9XB8FzsODCRBB5fJEfJM0rdXqIvvQ7Hvh2eI4amGre73
	 GH47cxxr4f12VPZGKySOn4ckTbRN5Lyfh4QRmcU8M3pHgD72VW9zG15qx6xKRjrQGZ1kp
	 lgXbb+yJq7poKJCmBBmSixIWNNXR/WBU/SqP+3n7JYenInEw26Xqc+LJIhHB+YJfbVSd4
	 0E5/TM0q38XI4Sh6OinjlHLaHGhRxtg+qsCVSy7vfkkRwP0b8jvQ8bxTYeMImE+GypA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pamgqJW6;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA82F606A32D;
	Wed,  4 Nov 2026 04:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA82F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=pamgqJW6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=pamgqJW6HSnSsTAsq2YiQDmWwpYahj1ilNtBmknUySir7e2XUq+g15Dg5CBWniOevh8QAWhCgYmiC
	 GhskY28XEiAAshiVF9fvOmydss5t0NcqwPdT4dSmhNHi6PtAueeKtFeu5cMvNqmQ5t+o1P1nnLONsB
	 9bIgoRpIIBgRPZvg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee96aeaadced95-9ece1;
	Wed, 04 Nov 2026 12:00:15 +0800 (CST)
X-RM-TRANSID:2ee96aeaadced95-9ece1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66aeaadc9e9f-120c2;
	Wed, 04 Nov 2026 12:00:15 +0800 (CST)
X-RM-TRANSID:2ee66aeaadc9e9f-120c2
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v4 2/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Wed,  4 Nov 2026 12:00:07 +0800
Message-ID: <20261104040008.1458-3-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
References: <20261104040008.1458-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: laixiangwu <laixiangwu@cmss.chinamobile.com>

mpu3050_drdy_trigger_enable() calls pm_runtime_get_sync() when
enabling the data ready trigger, but all five error returns in the
enable path return directly without the matching
pm_runtime_put_autosuspend(). The disable path, in contrast, drops
the reference correctly.

As a result, a failed trigger enable leaves the runtime PM usage
counter incremented and the sensor can never runtime suspend. It also
leaves hw_irq_trigger set to true, claiming the hardware IRQ is in
use when it is not.

Use pm_runtime_resume_and_get(), which does not leave the usage
counter incremented when resume fails, and add an error label that
drops the runtime PM reference and clears hw_irq_trigger so that a
failed enable returns with the device in the same state as before
the attempt.

Also propagate the error from the IRQ status read that clears the
data ready flag instead of only printing it, so that a failure
anywhere in the enable path consistently rolls the trigger state
back.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---

Changes in v4:
- propagate the error from the IRQ status read instead of only
  printing it, as suggested by the reviewer.

Changes in v3:
- none; reposted in a new top-level thread.

Changes in v2:
- Rebase the fix on a new precursor patch that splits the enable and
  disable paths of mpu3050_drdy_trigger_set_state() into separate
  helpers, as suggested by the reviewer, so the error label only
  applies to the enable path.
- Use pm_runtime_resume_and_get() instead of pm_runtime_get_sync(),
  as suggested by the reviewer; it also keeps the usage counter
  balanced when the resume fails, so no manual
  pm_runtime_put_noidle() is needed in the caller.

Link: https://lore.kernel.org/r/20261103092002.1332-3-laixiangwu@cmss.chinamobile.com
Link: https://lore.kernel.org/r/20261101092327.197-3-laixiangwu@cmss.chinamobile.com
Link: https://lore.kernel.org/r/20261030084305.1660-1-laixiangwu@cmss.chinamobile.com
 drivers/iio/gyro/mpu3050-core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 62e416df3..ef4c21c71 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -957,20 +957,23 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
 	unsigned int val;
 	int ret;
 
-	pm_runtime_get_sync(mpu3050->dev);
+	ret = pm_runtime_resume_and_get(mpu3050->dev);
+	if (ret)
+		return ret;
+
 	mpu3050->hw_irq_trigger = true;
 
 	/* Disable all things in the FIFO */
 	ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
 	if (ret)
-		return ret;
+		goto err_put_pm;
 
 	/* Reset and enable the FIFO */
 	ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
 			      MPU3050_USR_CTRL_FIFO_EN |
 			      MPU3050_USR_CTRL_FIFO_RST);
 	if (ret)
-		return ret;
+		goto err_put_pm;
 
 	mpu3050->pending_fifo_footer = false;
 
@@ -982,17 +985,17 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
 			   MPU3050_FIFO_EN_GYRO_ZOUT |
 			   MPU3050_FIFO_EN_FOOTER);
 	if (ret)
-		return ret;
+		goto err_put_pm;
 
 	/* Configure the sample engine */
 	ret = mpu3050_start_sampling(mpu3050);
 	if (ret)
-		return ret;
+		goto err_put_pm;
 
 	/* Clear IRQ flag */
 	ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
 	if (ret)
-		dev_err(mpu3050->dev, "error clearing IRQ status\n");
+		goto err_put_pm;
 
 	/* Give us interrupts whenever there is new data ready */
 	val = MPU3050_INT_RAW_RDY_EN;
@@ -1006,9 +1009,15 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
 
 	ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
 	if (ret)
-		return ret;
+		goto err_put_pm;
 
 	return 0;
+
+err_put_pm:
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	mpu3050->hw_irq_trigger = false;
+
+	return ret;
 }
 
 /**
-- 
2.50.1.windows.1



