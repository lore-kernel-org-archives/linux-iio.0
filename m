Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793349798;
	b=lbZLjOuvpFnEjAMIeR1R2/++y8BKZdHd61CSDDtsOYCtkqu814SgJaF5K9F/Bm0peLIV
	 vA/Bs9eLD6yI8vaq4eyeWD+JkgEa+zYlhU+tcpP9InoIzqzjeqrgwCZjJMhK2jWI45VeX
	 xA1Rx/GM1jdrTrPCk5MqqvGZKbKxGt4exMWhZDdzpMgOt3VN1zpqx2m2miNnW2DW8gjns
	 PvvAfz+jVrLNiDV50UXClq0KiW8Peo15pMixvIDrJDlTws/WUPW5WgxqqU0ljB6aXZvbN
	 ib/Ha2cWVKIMSMHmzTqkQ/awHilJCzfvUw5RjNDhKsiYLHVavBlGJW4nt4d6GjJ1iVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793349798;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L3BzpO5N3vbUEfc5njd6xjAlReJvCRdmIg/2EyPXr58=;
	b=hdPpkQLcF8buzpCx/LMv54Y5Dn1VWDJogJVKx0PnKKTIkL3NGQkCCunyAxy7lWIv6BwJ
	 N6lLPBhQwVvC4VeJEo7gpVem0YW3ZTqAUa1S8kY7ughRVYZRsKxZpvEVRmr1gppj5CGFY
	 T6ujdFxQE/uvaZPy9ArPDYJ20QYuhB2LlECSXyYz90JntnLT4RrrS6r86JMif9N48Yt9b
	 /CNrwWevsH/F00l7VG6AfElF3iEGMHKO2ahcg8RHWNibz5O9F0KpMRtLpPFMR1zQin6J0
	 nKN86Q5lsPsNC52d7MqtJXDKMsGmUDoa6+AzlGbNLHtr3zcqKQ+regO2+ykAFBNP27Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WmhH5hdN;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1A5606A31A;
	Fri, 30 Oct 2026 08:43:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1A5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=WmhH5hdN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=WmhH5hdNiSFHaUJ2gxGUXUnUPfbWv8j6bHMGq9D/9LhxEE6c0k5todTu+IVDzGljPUgPKeA9VnVn2
	 O2HgRiU4TLKhlgbbCfAaHrvu1kq4DUsEhZOThIpltKk9BA4mj9BqByeQq0rb+MaNY7eepp1IMihvEQ
	 N4hM5W3egITfy5pI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66ae4589cc54-400c9;
	Fri, 30 Oct 2026 16:43:08 +0800 (CST)
X-RM-TRANSID:2ee66ae4589cc54-400c9
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae4589a409-565db;
	Fri, 30 Oct 2026 16:43:08 +0800 (CST)
X-RM-TRANSID:2ee66ae4589a409-565db
From: laixiangwu <laixiangwu@cmss.chinamobile.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	laixiangwu <laixiangwu@cmss.chinamobile.com>
Subject: [PATCH] iio: gyro: mpu3050: Fix runtime PM refcount leak in trigger enable path
Date: Fri, 30 Oct 2026 16:43:05 +0800
Message-ID: <20261030084305.1660-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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

mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when
enabling the data ready trigger, but all five error returns in the
enable path return directly without the matching
pm_runtime_put_autosuspend(). The disable path, in contrast, drops
the reference correctly.

As a result, a failed trigger enable leaves the runtime PM usage
counter incremented and the sensor can never runtime suspend. It also
leaves hw_irq_trigger set to true, claiming the hardware IRQ is in
use when it is not.

Add an error label that drops the runtime PM reference and clears
hw_irq_trigger, and check the return value of pm_runtime_get_sync()
like the rest of the driver does.

Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: laixiangwu <laixiangwu@cmss.chinamobile.com>
---
 drivers/iio/gyro/mpu3050-core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011..9c6d5ba82 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -988,20 +988,24 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		return 0;
 	} else {
 		/* Else we're enabling the trigger from this point */
-		pm_runtime_get_sync(mpu3050->dev);
+		ret = pm_runtime_get_sync(mpu3050->dev);
+		if (ret < 0) {
+			pm_runtime_put_noidle(mpu3050->dev);
+			return ret;
+		}
 		mpu3050->hw_irq_trigger = true;
 
 		/* Disable all things in the FIFO */
 		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
 		if (ret)
-			return ret;
+			goto err_put_pm;
 
 		/* Reset and enable the FIFO */
 		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
 				      MPU3050_USR_CTRL_FIFO_EN |
 				      MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
-			return ret;
+			goto err_put_pm;
 
 		mpu3050->pending_fifo_footer = false;
 
@@ -1013,12 +1017,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 				   MPU3050_FIFO_EN_GYRO_ZOUT |
 				   MPU3050_FIFO_EN_FOOTER);
 		if (ret)
-			return ret;
+			goto err_put_pm;
 
 		/* Configure the sample engine */
 		ret = mpu3050_start_sampling(mpu3050);
 		if (ret)
-			return ret;
+			goto err_put_pm;
 
 		/* Clear IRQ flag */
 		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
@@ -1037,10 +1041,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 
 		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
 		if (ret)
-			return ret;
+			goto err_put_pm;
 	}
 
 	return 0;
+
+err_put_pm:
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	mpu3050->hw_irq_trigger = false;
+
+	return ret;
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-- 
2.50.1.windows.1



