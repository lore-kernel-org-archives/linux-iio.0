Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD38B39060B
	for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 07:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781421367; cv=none; b=h4UDTHzKBW3RDBvo5J74Sb1n96U2GyNXL5gwSRnqnuVmeuLTFL1wn4w+1G9ktobTPcfOmSMfTqvTvyw/F9R+Kz6zfbEcMrBruxMYyJEmaOS2jkCbSKI0EbR66KCUyRqujBfNb/p0/ySzlXIOnFmBsCEQrW9+2Vydc0CsbOukO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781421367; c=relaxed/simple;
	bh=Q/HEefTnk+HMBECsWjuwyiZGiULsgxVX0PT+SNENidA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oE+1j8oND3esCYVTCE7kAGluXjMv7ax6fEURTWOeDxvOfuJGcQgyD+zvi+YnJMaChaF9j7demMqmh9oQUvmCoBwa8JXgU2npE/RGrJCGidIDnNndCW5VD/jz9rFJg0cNAQLZxKrq2aWcnNztEyXkNW+6ZW8o/aw5rkuNV35a7q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUJllCaH; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUJllCaH"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0a5354da1so18918485ad.0
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2026 00:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781421365; x=1782026165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S6W9hVs9rgfrH0Ohbm4YeCJWMFoA5fpt1e9nnZXUhFk=;
        b=TUJllCaHPalQ6HTEeemcsrnicKHTexYHJWpEUCZFPNdcNswY+jrNadiN1FlBVJpMnF
         aW1g2x3Jh1DX6jAWVQ9V88+37S/KwpjkcRc3FtiRW3Q6WVK2Y31C+sjPUmNHOINHzS2+
         giuEedM2aQ9vcP+bugIfNLTwCbxz6/tlLAtx6n0GSewWZVGVkt733kNOUIPB8IxFrXSz
         P6e2LC9WpotOtjYrV6aKbdg3WauPI2OMTgPqAlyEZ6hughLgES6c4kFMdFU3M8SVElUg
         p4SMDFPQSg0Lc7Xt17fKfRGLadtzCFiBqpGoMk5D3qS+25+Kwot9U+Uf/ze3eGDw5rHN
         5sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781421365; x=1782026165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S6W9hVs9rgfrH0Ohbm4YeCJWMFoA5fpt1e9nnZXUhFk=;
        b=HolHOIsYTZ/JkuwrqYbS86rRMrzrJHzWsU4iosAqx3pDb42IKayAY2ZaP1lWNYOq+m
         7j+Gj9e+6ZgUcRs2ifXdpsB/ailClsXNZNNfrcLg+Et/AGg0zgAFvsawzq8OoU3WDZcC
         O1RakplTWoiES2Hlht8YAqvKOzKRQQHNtP4NwDRoEYBqd7eG3WIeSVnrV+NZc7rnanPv
         zVECLrXJARP+IFpqMgfQOXiPUQPZMTaWA9DCR6yFTZEjNjwMPIhOLob2RqzNt7M0C4vW
         wHM6lHaD/jQ7UuoB9reQMCZQtqocnn3VQWDUU9x5vXuH7v23HpzvWXJRzUKc4Mjk423y
         zVew==
X-Forwarded-Encrypted: i=1; AFNElJ/SyqKrVPn9Z2loNl8YpILjXJH+8+nMKIJYfZ+jbRKazJD2aJIfYwTVfaktFllmIhhq//B7zJNUMjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZ8yLFVxO0pb5XokfVF+mUSs6sdESkkecZmBh+KvuRIuth2bi
	WHGrrVXzMHlab4gMaNlUKzCMxrhr4s5Mc71h74EqbObJHfHHnhzpulVX
X-Gm-Gg: Acq92OFFVR02ub99Uxj5EUbKcHH9LODfAJgInyi2+eZX7O/wkDnwMQAJftH8TyeTbYh
	uA6ZmpVq4J2QdPcVWts31GutVFzvxSy+nIrsUahkfVLtffZAoCSp5TsgPJSPiiGIbrtBOxq8Vzp
	F9Jt7l1CBlgKihpYO3mnuIObA/QaBbHMSAejqNNgYN+whqZTEFdtSs+xjE8UgyyyfkpkrueNTTH
	dP7nd4AoaN0ZVx8MoegeGPcNWhGaN0/bMSFmfs3MoIwwl3xuG7STTKc4VHRHhLYVsbk+iV4fi9d
	Q+2EaVSAqNPyMjI3KQtAuFGpKMw3RSwB3o0W9SQmiG+0OTNgj1cIhjbBfKQII5sftfQV4NxBTKg
	Yc+5lcn/RmcY52eEybUYCKKvFzhCBpzBifVrdsFrYzNvJYx6cQ/9vhBflmnFZwEGhYd+7LaiTBn
	8EeI7fXi3m/i112dhig6LMObEY0/sEnLSt1tEvoAQmFRB1ju800QHC9EeZ90Ch4UE=
X-Received: by 2002:a17:902:f552:b0:2c6:6425:b343 with SMTP id d9443c01a7336-2c66425b436mr44729515ad.6.1781421365151;
        Sun, 14 Jun 2026 00:16:05 -0700 (PDT)
Received: from localhost.localdomain ([49.207.217.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac794sm65595295ad.46.2026.06.14.00.16.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Jun 2026 00:16:04 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v1 2/4] iio: gyro: mpu3050: fix runtime PM leak when enabling trigger fails
Date: Sun, 14 Jun 2026 12:45:47 +0530
Message-ID: <20260614071549.81920-3-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260614071549.81920-1-birenpandya@gmail.com>
References: <20260614071549.81920-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpu3050_drdy_trigger_set_state() calls pm_runtime_get_sync() when the
trigger is enabled, but several error paths in the enable branch return
directly without dropping the usage counter again. pm_runtime_get_sync()
increments the usage counter, so every failed enable leaks a runtime PM
reference and the device can no longer autosuspend. The driver state flag
hw_irq_trigger is also left set after a failed enable.

Jump to a common error label that drops the reference and clears
hw_irq_trigger, mirroring the disable path. The success path deliberately
keeps the reference, as the device must stay resumed while the trigger is
active.

Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
---
 drivers/iio/gyro/mpu3050-core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b431..783be9a786df 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -994,14 +994,14 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 		/* Disable all things in the FIFO */
 		ret = regmap_write(mpu3050->map, MPU3050_FIFO_EN, 0);
 		if (ret)
-			return ret;
+			goto err_power_down;
 
 		/* Reset and enable the FIFO */
 		ret = regmap_set_bits(mpu3050->map, MPU3050_USR_CTRL,
 				      MPU3050_USR_CTRL_FIFO_EN |
 				      MPU3050_USR_CTRL_FIFO_RST);
 		if (ret)
-			return ret;
+			goto err_power_down;
 
 		mpu3050->pending_fifo_footer = false;
 
@@ -1013,12 +1013,12 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 				   MPU3050_FIFO_EN_GYRO_ZOUT |
 				   MPU3050_FIFO_EN_FOOTER);
 		if (ret)
-			return ret;
+			goto err_power_down;
 
 		/* Configure the sample engine */
 		ret = mpu3050_start_sampling(mpu3050);
 		if (ret)
-			return ret;
+			goto err_power_down;
 
 		/* Clear IRQ flag */
 		ret = regmap_read(mpu3050->map, MPU3050_INT_STATUS, &val);
@@ -1037,10 +1037,16 @@ static int mpu3050_drdy_trigger_set_state(struct iio_trigger *trig,
 
 		ret = regmap_write(mpu3050->map, MPU3050_INT_CFG, val);
 		if (ret)
-			return ret;
+			goto err_power_down;
 	}
 
 	return 0;
+
+err_power_down:
+	pm_runtime_put_autosuspend(mpu3050->dev);
+	mpu3050->hw_irq_trigger = false;
+
+	return ret;
 }
 
 static const struct iio_trigger_ops mpu3050_trigger_ops = {
-- 
2.50.1 (Apple Git-155)

