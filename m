Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3195D34EEF9
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 22:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973330; cv=none; b=VNsZML02MdQBOt5ADq4PWg2JwxN19pigkGqjyZ5TBrRZx6tMXbk0ahzeZ/b9M8IqPoI/uWi3wpx9vcm4WN+FKZiosfdIar5czXdXv0s2Kk2QOlP0lZwHtXnhl5nkSKhAHW+ioAGkKnjxeRpokHQ59M+ViEpUTAvjrhrWdbd4Wgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973330; c=relaxed/simple;
	bh=xUpdKh43T9YeuaD6xpCMyHtb10I2PeGwdsS/b4sKsE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh4pPuSGBYuiKK4fTQOfA7mEwA+qPAaS18Hs5kg22nGMYg2/RcI3ohn31AzundN0n37IDWFo2+HMo3vMV4ybrgGls+25Cd+uFqKE5jZTxvhIrjdbm3csg34gpFAyKb+wDfq3y4snu1mJ7SSD2F6F5xmWUDtM9GyqLhhA744TCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9JdhUKr; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9JdhUKr"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79495b1aaa7so55590617b3.1
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973328; x=1772578128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzm4Qzg/QoCTFEcZe5nEpMcr/8uPNivp7yd6Bg08geQ=;
        b=U9JdhUKrb+fwCW1O75ZHlZDmubC9//1SQYLMTEeMJBYjwAhw4UQYq/pSPL4TsjdOEW
         uGXwM7WvZsbrUdXIcU+UbD9Ov48q3401Sr1UhW1LM5BZ9TinJWpi3YrzC8eD+dco61PN
         EV56l9zSTSg5WpRAC+HSmdPf2xhqXnCInbYIyxAlAZDc51WDljB/sTJIttvG7tbsvPjQ
         A4t68CXtzT/5FMBMViYKjmtk0ywoqe8yUL9acn+br0FdG6vS7ub8bJ/maZpxAc4TgE8c
         ghH61XpNjuIQ4ZCb5ESLafwydq6S+ls1OhxpPHy927D+X7AHagsRwQEXtWEEJqo3SrFm
         o3KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973328; x=1772578128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzm4Qzg/QoCTFEcZe5nEpMcr/8uPNivp7yd6Bg08geQ=;
        b=X/RmqotWLGFY886ZbG8isBRvxpzIn8XurGcOCMNr1heEOBafWGrdMESiV+MZec3C6z
         0pZ1gqMYU9vgG9w/pWVwukyA6nc5o42LZzdXV2hkVDUY4AKNutZYgPBX4RPI3XWFWvFn
         vQe3vYp48E3sI32gs4wNduFXB91tWL1TUh5Es+MZTtxLWttq4A+/dgs6AF1iAjI6MoBO
         ANwYOzO5rf4CFEVyiwXngr/Xh+ZgI/A2emvVLmJVVOG1D/BGX4YHlVlCwUVGdhW88Ehd
         80ejzv75GK63NBHH2X6Y1YVVdLloXLy0rEXDC9odtoZDQN1LlSC96PDWG3ZJ+SZDagj8
         OkDw==
X-Forwarded-Encrypted: i=1; AJvYcCUovYphLBlkDeUaaUXVpec74wj8I5zhYienEAiymLlM8ZpytIrsioPIf5bZO7qNN/fNxEyVtyyZgKw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy20BXRr/Rp8nSa8TpJVcKUoSipLvkvEOt4uKpnntoJYcf0RNHw
	1Nb+P5xHBivBRzbalvut8fA6Zg77pW9xgJ0sawkRn00opV06EHZpvwzP
X-Gm-Gg: ATEYQzzgdlOKrBBnOgdHSecoj7rQ+IC4nb5bwZgfaKTQL4Ef92ut+AArjxD6QdTA8LP
	Lss3XErD7+1VYlz9RxPGOGeAg67ExJABFfTgjLZ0Dc86fu3Y9rQBi5wESTdr3IWG263tPvRutd0
	t5R4JVqBiKnmWqiNqhbK1OaV7Ni6qDo5LIjwGD/Jo0MsiTmxUvCIlZDwYgJBrNUBaBhmP8f4Evk
	u+rxG4SUEIFYl1Xi5wAHXc4R868IyrJxzsSxIYfY1EYc/q3P6FvCGlRWcjf3baHRQX8ZxAy90ei
	/A08fOYovIv0TN/q7yAgNChHVw7U/rhU33qZXgyaIb2CRvRJrAC9DV+22wmRN2r0lEPb+pfrqzn
	df7vOz77RuS8DMfGws+WTXa/8wtPH+gL5LURervfU9SH6xj8dJde4kNcAWxMFA3fjG5qn/E4Jl/
	WYX9yfQ+Gw5ewpyDJbg7bJPVlhV7J80r4ssndz5NZlXbHdxk9rSvnsc87egbY9Dz4Fsah4K5C6C
	ZvgmWGTBd6otf/qAMxzHGcc0atVRjh+e/g=
X-Received: by 2002:a05:690c:e363:b0:794:ff4d:91f5 with SMTP id 00721157ae682-79828ef4ab3mr119620267b3.11.1771973328177;
        Tue, 24 Feb 2026 14:48:48 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm48838757b3.24.2026.02.24.14.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:48:47 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 3/4] iio: gyro: mpu3050: Move iio_device_register() to correct location
Date: Tue, 24 Feb 2026 16:48:17 -0600
Message-ID: <20260224224818.2452675-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224224818.2452675-1-ethantidmore06@gmail.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_device_register() should be at the end of the probe function to
prevent race conditions.

Place iio_device_register() at the end of the probe function and place
iio_device_unregister() accordingly.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3: 
- Remove stray change.
- Fix grammar with "the".
v2:
- Patch added to series.

 drivers/iio/gyro/mpu3050-core.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index b6e05afbe512..b590cf6709b4 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1218,12 +1218,6 @@ int mpu3050_common_probe(struct device *dev,
 		goto err_power_down;
 	}
 
-	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(dev, "device register failed\n");
-		goto err_cleanup_buffer;
-	}
-
 	dev_set_drvdata(dev, indio_dev);
 
 	/* Check if we have an assigned IRQ to use as trigger */
@@ -1246,9 +1240,20 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
 
+	ret = iio_device_register(indio_dev);
+	if (ret) {
+		dev_err(dev, "device register failed\n");
+		goto err_iio_device_register;
+	}
+
 	return 0;
 
-err_cleanup_buffer:
+err_iio_device_register:
+	pm_runtime_get_sync(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_disable(dev);
+	if (irq)
+		free_irq(mpu3050->irq, mpu3050->trig);
 	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
 	mpu3050_power_down(mpu3050);
@@ -1261,13 +1266,13 @@ void mpu3050_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct mpu3050 *mpu3050 = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (mpu3050->irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
-	iio_device_unregister(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
 
-- 
2.53.0

