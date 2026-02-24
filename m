Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF02261B91
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 02:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771900535; cv=none; b=MK/5RtZh9e0RlGbAd/fdTbeq4uMRYEhGzMMXQxYJuYJL6FrpKuXfgqjpO18lIPwQN1bTAGK8sP3IN7HrARpJlEXYOf6FselJaTlWjH4ZKG7smlkJRb21zBggKB5DU9L8WWuXiXCiSGToOwcwwTnhWA4zT/DpFng9hsJxC08vVa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771900535; c=relaxed/simple;
	bh=gYvFshSHeFO4g3kALOTIM0u06mqGXjlapA5rA+UNYK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CevDtByv38hUJHMJtZ2XTnmEOWesOQKe4ekswWAWbYF24dKxRbpe20pMbbRQ9Bir55FVLhDQ8mycdQtEcPtjgrykkpdgXUOO5M9/NlvtBC6KsGd/+BjJYPVV93sPfFGjEC0t8B7yamCn8Fu6S+LOhkPoOn87JJexsyqAlewbcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mX6RXOao; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mX6RXOao"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-794f701a3e6so47821017b3.2
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 18:35:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771900534; x=1772505334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4MU5OJCaPocPPn0n0+lESzz/W1ZYrIATioLMy1y+L4=;
        b=mX6RXOao0SVM56z++x0ueIa1FA9AtWVEhogsJfQZNrWTCZ5P14+t00monlm7EHYHXH
         tpe+RSjPBSkMCLq4zSvD6u0yi+BrIcRUoePYzkJk6iSv7Tv2vex84cI+E5PU+0q2y4VO
         4pBSLhC5TlVF0n/McUezxefJzBSodk7QkIJQqGesY5xU15hdYJoiaQ6atH0x+hUT+pbV
         fxAXCc6KQdsxvK1IFpuwNnSrW/B5lXAdP+f968ogG3hFjso6Q9k8ymX4LWp2UGSZ/of1
         xOVzmGH4fgAI5/rAEuqVDZ46M/jQs8POpTErDQomsot9o8rCu0aBAUZkc44Dbi5q5aCX
         A+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771900534; x=1772505334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M4MU5OJCaPocPPn0n0+lESzz/W1ZYrIATioLMy1y+L4=;
        b=nXr9+D102hJmaExFxkNOI5sUtmS5crAl6jgMGsdBDEymqvFP72lbbFOd4oQU9FKElR
         hehx1kkdipyCZQtexS5bQvZsQEtVws1RdHAI5V1xVyA1eSh20YmrJaI9BXArMZenfrZn
         iZmRDr1SziHwKhJcdyKLWvcrHlKyhjQS6+9C97hFA4fOUuGyxtaKN0PrgGZXt9N23Yue
         cyPNQNrvsdE6BkQ61Jv7s2aMoZo5iPFqAtar/qvz+l0lyGJLf/O/8O+DM5szSQERM5pr
         LtmoLQJbvJY9l9VPvMmMZKZMfJVLwdrFt5QHKO/lxe4w9tbx2K4z5H4UVSb5cDXAZLpI
         5hcA==
X-Forwarded-Encrypted: i=1; AJvYcCUx6sfC+0bmaIzt7Yce679O+ReGd7app0N+q7wMld0OyWp0Ez+Oyr6X2WHlNeWb+XXhg12OVuNgo18=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz31XM08xDaC56TachD6+9mLF+PeO7bx82qA3A1Ct+PGlhDwoSy
	8v6VxS/DT1+MCZpvj0jFnF/Rau1cW0ND95Yzyqbz6mF+1YhRBP1nWUWu
X-Gm-Gg: ATEYQzyvCAHrMauthMRr5cDRslLlbgp3GhXWB3yOy8nmjna/VEvf7qieyQmLhIliaqj
	+9NgCxo0RfypMrbTntlsjZ2KkDSOR6U59GDA6kmth3QIMC5nxRREC2HqTBR2HDbWy8oUvAe7jts
	MAlh85/PwKJ2+9YTj/lpoA3CiOmwW7Z1Hlzehe4s9A8FVXw/kPmf/gDM/N0j8A7+0iJZntiTmnA
	teIQghhNTTCY7FhVGJSF0jBphSymen7Glf+ia0WV2yW9ZiEjAaPQEdUNvxWeOBe7C5BGsbwbdqo
	cbrBLWyngLmaLTAjyptqZ4ORXXf/ENfUcQHeBf7JS45e10JRdr9GJBmKO2Sx2smnNbrvmaG3XOp
	CmyzohPL3Bh9l58uHA0QIaaYCt3bLAiHurzcI3Lg61j+MfZaTy9OIuKxBttPZ0CtTZMvAL+mDBa
	h/21R9k9XCzOIPR4mYvkNIIYR8QNWWo8zVyPeDW+SHrN0gAhBaYHrDbdLcRujDXI0FRp2g+ZHmB
	nXHPMof9Y1ekibupQwsabtNDrykxWwq9Iw=
X-Received: by 2002:a05:690c:67c4:b0:796:3787:39ad with SMTP id 00721157ae682-79828f249a1mr112426477b3.27.1771900533662;
        Mon, 23 Feb 2026 18:35:33 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982d985074sm39585407b3.0.2026.02.23.18.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 18:35:33 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v2 3/4] iio: gyro: mpu3050: Move iio_device_register() to correct location
Date: Mon, 23 Feb 2026 20:35:10 -0600
Message-ID: <20260224023511.274038-4-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260224023511.274038-1-ethantidmore06@gmail.com>
References: <20260224023511.274038-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iio_device_register() should be at the end of the probe function to
prevent race conditions.

Place iio_device_register() at end of probe function and place
iio_device_unregister() accordingly.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index b6e05afbe512..73dc7ea1f075 100644
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
@@ -1231,6 +1225,7 @@ int mpu3050_common_probe(struct device *dev,
 		ret = mpu3050_trigger_probe(indio_dev, irq);
 		if (ret)
 			dev_err(dev, "failed to register trigger\n");
+
 	}
 
 	/* Enable runtime PM */
@@ -1246,9 +1241,20 @@ int mpu3050_common_probe(struct device *dev,
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
@@ -1261,13 +1267,13 @@ void mpu3050_common_remove(struct device *dev)
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

