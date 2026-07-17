Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8DE379C22
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310631; cv=none; b=SETx7vw0CawNan/uq3sWHxmQJPNZh57JWhrc14QzvyndINSAEooON8N46f6/en2dvLY/ex5ISg36VzKU4/Ig6Er9bUcnKX5jWG9Tu0HOpycjFxdVJMWM43xWlRs2qJjvthNwuki8EzrxixtWosgcGk/872zVklmmAhrN8lNrUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310631; c=relaxed/simple;
	bh=NNEIZKXo9Gk0gdXnGdTbnSnR3Wi7bJIrBopUTtp6W74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NiuWkMFDJ+VT2r8YWswhYBJ5MvdE35zT4+b0psva9HlTB80zJI2c0Sonunq1v65kGPKNKFw8PF51qldlR02IifppjGCBut6hNn9GgAWeRNlntfqEyxnwRYuowruqba3V+ukWAqL0tKzyI/V4bxEoHiAfP8bpzIGC7aqFCmUqrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPUKznDm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPUKznDm"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9c26a5fb98so1392790a12.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 10:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784310630; x=1784915430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P50P6HDMmVOibCPLHmatcmF4wTn2RT68qvoNI7ZMC3A=;
        b=MPUKznDmRm4c40aiTtlrMLogvB/PfljLACHol1g1e9o8yt5YhcmzfW+VUDXjSEsKf4
         xFFycl1iXdAijloWFGkCn79DjU6oKTYWS8yHwWWCagXJtH3800yfB1cWuuXIN+Sj9gX2
         EgcCaSXqHDdb1P7E5oDuQWyQ4mR0gJu3GOZyrrBXa0f9+Vuoi5xPbDdgRyj0nrUrRJMP
         k5U/+L7iTpGFfhy87fawddkUHpuuWCJ7zDfMA2NerwL88SOdvWr4Dj79g8TjkzX1c41T
         lQRde+1NvNefOFA1Xdo+R/ml8ZfsO16TVRsW0ISgu3DLOu06q5X/werstTqc9ppbNab3
         Ii/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784310630; x=1784915430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P50P6HDMmVOibCPLHmatcmF4wTn2RT68qvoNI7ZMC3A=;
        b=EI0TtwKCZfaMzbEOyryBxmdyzNzSykJ1MDMITN56uCYUDFtAf5AqLy8AFbjOOO6ikK
         ro3CGRamLFiP5a6aNnyKscgdS0yV204lw1eWAPV5qKFi1xcXaY5xewLp3bed8uV6dQ/M
         TpwKChCdmnVyQjH38LBe6fGVSNB7zoHtR6aeXJbKbUFeKce9twPhkPrAls1wrZ5xAARa
         RnnuT91ip0RPb3xHRhqlX0hn/fFRXBdFllrNmSUe86MZjpqmOHDGG+gX7dzViY2n/DOb
         QovsFCd0Ha3UrIrhDp7fGUquG2vFlvrwc4WjLxApi3pym81bRFF4/mygBOwc3pTgufrU
         LImQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq78IR1u+b9fzryjaN53ekHJ0mgs8/yOCtoaKYcC0WOdyesrROqTCWjmp7gMiSGym5FvuuhQTypE34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAf9Xl57iTxDBYUo9qoYsuhopkBuN2iU1hKJ6YwyfJKO2AH+Rp
	sOqLgkbBDfX7yJfO+HSyVos33MTuY28mthIEZQIGcT3rb4TdC8KifQBZFhuMMxV4
X-Gm-Gg: AfdE7cmCuUjlANz761Oh3tiet76s9Z/ZpZdBrUblqmJhmClOb+m13EakN1UOMYY+BgY
	aTwMT5S6vSG0+lLJFj3qbDUyvqifWlzdExiBkPXn5pDfJerXPR9hqT8i0eaxy3Pfj9a/2lHEiQ9
	AKepLzh0Ew9ixBEs/s4yUEqyijEIcOFQINI4JUezI9q54v/NZA7WepBdMLzq98xLjNK/MIH7Jjk
	SF4OqvAoZLHbVwN0/4OMeUkDOHT2qy5xA+mGL1mQjNEXKPg5TTRc45+libpFtnKH9/JsZPHb8gO
	YbUIxmpwfQ5cjCWX1WExYnnsCRVk1Aew/Q6b/P9CVNK7BPZMDXSu0dWIh7zirtrIoYd2mMJUNvr
	amewIGqWHsxFFpPQ3i9Bj8Ls0xcH/CNt5iRxDhg40h2upFqR9/3oEDMc0lW+FPmtFixeZJDZtQk
	WQyHywwVgfpmhZ8NNam76ellQ5YOydFkmt
X-Received: by 2002:a05:6a20:7484:b0:3b3:3506:cf3f with SMTP id adf61e73a8af0-3c38d8cf13dmr8712801637.1.1784310630009;
        Fri, 17 Jul 2026 10:50:30 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cd764fsm7634392c88.12.2026.07.17.10.50.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 10:50:29 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v3] iio: gyro: mpu3050: fix runtime PM leak when enabling trigger fails
Date: Fri, 17 Jul 2026 23:20:22 +0530
Message-ID: <20260717175021.70834-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260614071549.81920-3-birenpandya@gmail.com>
References: <20260614071549.81920-3-birenpandya@gmail.com>
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
 drivers/iio/gyro/mpu3050-core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b4314..1f23e700a0dae 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -761,7 +761,7 @@ static const struct iio_info mpu3050_info = {
 	.attrs = &mpu3050_attribute_group,
 };
 
-/**
+/*
  * mpu3050_read_mem() - read MPU-3050 internal memory
  * @mpu3050: device to read from
  * @bank: target bank
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

