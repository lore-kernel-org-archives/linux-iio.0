Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793697614;
	b=XsgZrpExv10G+wBSWLkGjrnkeRdgUBvKDP2b4MTNeAD3JCHIH/uGPJgI5ySuDDjkgm4j
	 HdF4ExDN51RG7ljAC2EE5YhEyK5otZLpaQHWRkOoAOMoQ6Rq1PywchrrrTUoRwtdyMAFm
	 usKfcih0PNT9YmIm8PeVeUpbWKp3jDGOgzBMx66Ix1h2xETdUK56Hnr97U4VH8y7nctwB
	 cXAmVcHyVrV7iAggdOMYtea8hbKEyXqo9gOUCVG61NPdRnDxLUCMaOpxWp6hty9uyu3cz
	 GDum66SzsZ0nbyCKtvQ/F7uoCI9llXdFTugv+ltRnOk+mYFp3528mWo+7gC7tOGCNMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793697614;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TZHbUSdkUBb+ZI6wuGpXqeof9jscdgINriK8/nkPpvc=;
	b=Z4IX16Z5cDdzSQa95q3r7Au9ns32jdf8Ed0BjGLZ33Bfqm2bFcywEHfrmjEajPXFasmZ
	 pHr1I1sUhI/I/WMzO4IeIM45cpBVBvJAtmh8zdaiDj23BQeg/Vq+isnhf+KIsZFhTABUb
	 LbLSaL6+4wwa68UMJKWYZXLNLlZ1WueBj9ARexf7gK7qcoC7Ecd3k+57Dcx3WXHTvTwGm
	 8EKp2AXIgRMNNw0sAVG457C40dsV3mRCfbhtZRGaBC0XgV17STRnPEKZG+bIPtczv00Of
	 HDBWB7yLV3xt5ftIpzPMJx7SAPrt2G9H/8dBW69i+Gfh1lE3Zyx8rGH6sbovWpXkCKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Bl6IzJ6l;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDCE606A332;
	Tue,  3 Nov 2026 09:20:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFDCE606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Bl6IzJ6l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Bl6IzJ6lCZ/oHkZjk/H2XAtpYOE/r2umzKLSEcIBQP7X0F56dUurnzTjLYPsL9A6ciNFd9ih/1tjp
	 WMfZeeVWZJ70mbqQoLkeumg/SomLWyI+vrKoGRIxjEZi89WAFABSLun4EQ65fxL1TvoRgND+PgkxqC
	 nxoZ3niuuKNvoWqw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56ae9a74a9ce-90bb3;
	Tue, 03 Nov 2026 17:20:10 +0800 (CST)
X-RM-TRANSID:2ee56ae9a74a9ce-90bb3
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae9a744004-f3e40;
	Tue, 03 Nov 2026 17:20:10 +0800 (CST)
X-RM-TRANSID:2ee66ae9a744004-f3e40
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH v3 2/2] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Tue,  3 Nov 2026 17:20:02 +0800
Message-ID: <20261103092002.1332-3-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
References: <20261103092002.1332-1-laixiangwu@cmss.chinamobile.com>
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

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---

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

Link: https://lore.kernel.org/r/20261101092327.197-3-laixiangwu@cmss.chinamobile.com
Link: https://lore.kernel.org/r/20261030084305.1660-1-laixiangwu@cmss.chinamobile.com
 drivers/iio/gyro/mpu3050-core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d966911ab..fc305564d 100644
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
 
@@ -982,12 +985,12 @@ static int mpu3050_drdy_trigger_enable(struct mpu3050 *mpu3050)
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



