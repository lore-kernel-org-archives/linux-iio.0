Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB0A43F8CA;
	Tue, 14 Jul 2026 09:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021962; cv=none; b=YLxXcA6uwCUf5y8ewo5ZHpfvFpSTgE//bAHVg/1tK0ibUyWD3pWuIKKJfisJOcaWKnJpJCU9jbubuZ1om1KisfdhIzk/Iwu4e/rV9CshrzIYq3bFmM7dHOfcjOVG0xYYdaH544wOJ2K/EBJkijFtcIq5BboQ6g0ZwCgDO3sw83w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021962; c=relaxed/simple;
	bh=lDCh5LeWW3yzIYwpfJj8zsFcn3byd6Whf2soK3F1a2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cIMLXSbbHpgjQ6qcxMRuC0dLngRQRqRt5Hcy2kWhC0IZvRieN3wFujDOIMaTzA+LYgn0/kdtajqv6oyv9x1DJD9rc+dixYN03ZrVnhtHrXSWaEC9IEig6UNHz8HMji7qumJHxCsoerdsJBuw5J+jDGuBuBvMyAI8fm4b4EPIxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: dfca24987f6711f1aa26b74ffac11d73-20260714
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:35dbf3a2-e849-4381-84a7-a8a451e67246,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1dca51743002c71b31434091e6d5125d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dfca24987f6711f1aa26b74ffac11d73-20260714
X-User: lilinmao@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lilinmao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 181777689; Tue, 14 Jul 2026 17:39:13 +0800
From: Linmao Li <lilinmao@kylinos.cn>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Linmao Li <lilinmao@kylinos.cn>
Subject: [PATCH] iio: gyro: mpu3050: Balance runtime PM on trigger enable errors
Date: Tue, 14 Jul 2026 17:39:08 +0800
Message-Id: <20260714093908.380804-1-lilinmao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpu3050_drdy_trigger_set_state() takes a runtime PM reference before
configuring the FIFO and data-ready interrupt. Five configuration failure
paths return without dropping that reference. The IIO trigger core does not
call the disable callback after a failed enable, so each failure increments
the device usage counter permanently.

Use pm_runtime_resume_and_get() to handle resume failures without changing
the usage counter, and drop the reference on subsequent configuration
errors. Only mark the hardware trigger active immediately before enabling
its interrupt, and clear the flag if that operation fails.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Linmao Li <lilinmao@kylinos.cn>
---
 drivers/iio/gyro/mpu3050-core.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..6bee1caadd81 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -988,20 +988,21 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	} else {
 		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
-		mpu3050->hw_irq_trigger = true;
+		ret = pm_runtime_resume_and_get(mpu3050->dev);
+		if (ret)
+			return ret;
 
 		/* Disable all things in the FIFO */
 		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Reset and enable the FIFO */
 		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
 				      MPU3050_USR_CTRL_FIFO_EN |
 				      MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		mpu3050->pending_fifo_footer = false;
 
@@ -1013,12 +1014,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 				   MPU3050_FIFO_EN_GYRO_ZOUT |
 				   MPU3050_FIFO_EN_FOOTER);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Configure the sample engine */
 		ret = mpu3050_start_sampling(mpu3050);
 		if (ret)
-			return ret;
+			goto err_pm_put;
 
 		/* Clear IRQ flag */
 		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
@@ -1035,12 +1036,20 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		if (mpu3050->irq_opendrain)
 			val |= MPU3050_INT_OPEN;
 
+		mpu3050->hw_irq_trigger = true;
 		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
 		if (ret)
-			return ret;
+			goto err_clear_trigger;
 	}
 
 	return 0;
+
+err_clear_trigger:
+	mpu3050->hw_irq_trigger = false;
+err_pm_put:
+	pm_runtime_put_autosuspend(mpu3050->dev);
+
+	return ret;
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-- 
2.25.1

