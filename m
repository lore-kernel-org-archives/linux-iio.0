Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7291330B15
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 18:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311857; cv=none; b=TZT1dWg+NaYadfczPez+MNbIvvqs3WlAy7mqkDwu0HiEIO/rx4Xch12WwjaVZ9Y9v93DgiCG3J+WQ7dIeBWn8Uo8mrSfLiOthzzW5FvB+UodLLTZIzVfxgWH+Agvc4ABXf8lRP2/Ow/cUbIDwV2rUDFEI4WYRjAudxdVvvr2/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311857; c=relaxed/simple;
	bh=bX8NLRtes9kGdXkVlJaJW/CPhYxygJmJvj/HPFkFD3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJcdm6d4g+oBWsljPUJOrF3FaKahNbVivqkq6a7crihfoxrhFaHyyikNU2I6KAUBZSfuumlbBslS5/J2NHE/l25CSCcumUT7XqNCna9bL1Z4rT1LEHsnQNFiMVzgsWLD+zGZnmShNWf1Efvj1oiyTN07+e94vm22Dtqc3uJYack=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hAetVf3x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hAetVf3x"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-848d21bbaffso8051683b3a.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784311854; x=1784916654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dTCHiwT2E10d/HI/axutsBD0+RAwI0EPUJ73rBwlA7E=;
        b=hAetVf3xwvnYwxEF6lxVqxyfao0r5jK7DjwCPdz8uQ+hapKbsuD+UPZt9/EdKk871H
         DbIjx6mTKnA/2bZ+EIOjgGMnMRr7jGAIVxO2zf7sUQItHWFkD1goLd3v71SBNNA5Nt/i
         iIsx3iYF4IjVFg8Flsmvz0S9dGoGgA2LRlE/addqQm/fIbnYhK/RBQryLmEhtFfJC9wk
         qEij7xJR+DeR6lp1p9pcZDDw9Mpsc/HKcuZ4xNAgpSm/QlVFf3P2Ns9lTkqf03gBxGQm
         WGxP5hocZhWljErHX5dXIJNNu0zTSNVoC0FL+pozGPtaSfJqpt8XqEkYA7BLCpONICs+
         pa1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311854; x=1784916654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dTCHiwT2E10d/HI/axutsBD0+RAwI0EPUJ73rBwlA7E=;
        b=Lxz1VtzY1y/dSzHk+LGhr/7+Wq5MZGoSuISjsmhXfFeDt/YztPp4nj/Oz83XZaprt3
         GRy0L7W13+MWlyamcsGIZGHqLWIdChvZUwYjFKAtz3N778PWjBJuW3QUTc6Lr56j8VBE
         2+CKcB0vWhG0VcFQn4TVoWuV2OpBNNTW7el1ZkUj0suPlrPITwJWHDGgRM0kWv8jHlhw
         hJfijKDXdFwWyMou9kWacO2wOTiryMDXNyKRHX6Mf9gXSmTiVNa9VEoeguVqzO39yv9q
         u2UfW2uUBTkRWJRQI7Gi3whDfyYqUSsYdazeXBrbQYYZ+slIdPmxBC1Hs516ow/TubeI
         qouQ==
X-Forwarded-Encrypted: i=1; AHgh+RrGsDFqHDTKEeCpy+607JjsY08KkzwjVcAlIfM2LOVrTaasGGu6vhtQfYNezJX6Sn0/n+D6HZE8tG4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vmx5qjCHTUBpS+c4t2pxMnlU7vRSDjixm/hA3uaUVQUkkjEE
	JJVupldQFXp6L9Cvin0GV8VaEuUwnwJpKad+hFk+iYJtpYFe2DLtl7IV+NxWkjLL
X-Gm-Gg: AfdE7clSfodHAOO9S3ZIPuQNZuhROq2rvwiaGwlU/qD6VUxnjzxM6wKB7bSDmRSwEfI
	VfpIl67KN3YK6c2GVaEVr7K/98vfPFC5gZlbnbiHEcpvqtN3PX8yF2CRkA9frVwkdilATUoxnkQ
	43TEzaDyxY6HZyFg8jsjyqR+d3AOpraZWUrfG3kQQV25xFhsUXMaLYliCgbi4Wz8z/VOJ/aNeat
	nuKhLPpxYJ01Ydxsg5uj6fEtr4MxePXMLPgO59Fx1dRySbNoWKqW1w/aD/6A0MzJSBpxIjya20B
	8+NhtRXHL3igAhkv/vTNAu8vya5LbEyleKsfzPZQEGoiIodW3HwTrE8jc7BSqGCqkSy7qsYfDYa
	eQ1AwO1IGiF9teZG/k0eV3i9H4+6pef1waeTMdb2o2AGtSZFMiu0oQ5nAEOUdNAptRDtl1+sKQe
	zSolZLDRYB1OAHOR63BS+3PAP5hgCkKgy9
X-Received: by 2002:a05:6a21:4584:b0:3b4:61f:1fec with SMTP id adf61e73a8af0-3c3ad5d572dmr4502171637.2.1784311854063;
        Fri, 17 Jul 2026 11:10:54 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2900a37sm7460574c88.0.2026.07.17.11.10.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 11:10:53 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>
Subject: [PATCH v4] iio: gyro: mpu3050: fix runtime PM leak when enabling trigger fails
Date: Fri, 17 Jul 2026 23:40:48 +0530
Message-ID: <20260717181047.72309-2-birenpandya@gmail.com>
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
---
Changes in v4:
- Reverted stray change converting `mpu3050_read_mem()` kernel-doc to a regular comment.
- Dropped AI assistance tag from the commit message.
Changes in v3:
- Changed to a unified error label instead of individual drops.
Changes in v2:
- Fixed a missed PM release in the first error branch.

 drivers/iio/gyro/mpu3050-core.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index d84e04e4b4314..783be9a786df0 100644
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

