Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1523CCFB4
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051523; cv=none; b=VHvki31qrTyglWPOl2KvbXpekSZCIx8n/y30FavpVFnONPrtYa70mKiyKNrNrdecOLNqJGT6JZOYHR1JS8+ro0XN2aMmqLMdirqnrxNd+RMmF0WYJfD50i10tkD2LLkBg5JW0X0kr6uckEBU76RSLu3dH2MBhhM8sR5cA9tLrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051523; c=relaxed/simple;
	bh=FqBG1uSwhCIFSXKTiWQI1z3GWzWpo6s5egdT0gjQQjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yebi9HL4oDg3f14vo878qOPyhe/Kbp46p0BmQZ5vPs5/+xs24m99aLboHcD7jFfLJO2Nc93ySTn/Fg4OEeXtFp/kLOH0GPSZWsR/liAV70MV6/ME7nx53p/fvc1UJUOKQXg7ULj2rtzdnPIBehQ9vVMhKfZ4FvUPMBoeDVI+WO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKSmFiR8; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKSmFiR8"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a86cb123e0so1394968e87.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051520; x=1780656320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AU1BToDPYq1VyvVsi3Mxkvs2hOYoBg+fWm8ow1e5Ta0=;
        b=FKSmFiR8M1v1Wyu3tK3fCldb3aJEEiaF6K8ecx9wNL8Z0L8+sxn6sQ+/NRDTzzPmuA
         GeOVl5ROPfglTHVuniHL8KIx7YqgbpPyHFfSLIEyJ2iPyun+8y94l1xRt9yDI//g0igi
         j8QAjx9dTAJibNGcL5rWf9J8s+/mTX9rItABimt2sgN8+nWp3XroqXsh8PZzRURBBSmy
         vA0efgO3FONj1pCe8ukffMezhpeQ26G/8ZYdNvOZ9QHr7B/QoHW69kVyrwvnWu+ZT7lE
         guh8G4O+oUkEfH6iRA7MJtfB2VC/9Z+b8xNEcWo9ljAfigu+X42+nNRfkwoB14ei6QmS
         aEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051520; x=1780656320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AU1BToDPYq1VyvVsi3Mxkvs2hOYoBg+fWm8ow1e5Ta0=;
        b=iniUhe5hceP0aY/gMM8axsL66/YnM7+ucoDa3qeqLsG5tA8GKXNpWgvZ1f3B2vriYy
         VFCUx0ncMlcpnThqdQoL/A6sNcAWsXSLdQTejFrobuTb+jrAKEFB8FSMgz3UfdjgVO8c
         i6L8tX5kzUu0tauMz/BKqt+1qeKX8dgvs/ie75gLP+6lJisW9hZFZV81gpHSxP834mUg
         lHrTy5G0IHPFItgMmRkfQ2xzZ9gJNEccSH58HSC0xqwAiHsl2UgN05uv/NL2F4sy1Y5E
         IZBWIEbSxU2J8he8NOeZRWGx8oiQpBttg3l9OhSd1RudJFCJnHgc67e65fADiHkenzYD
         0JRg==
X-Forwarded-Encrypted: i=1; AFNElJ+EEj2Nh9TEXSVoqwfhB/wQT/+Hxiojtmdl5uzY7MvPnCL0FEn7XMYJ8Y9gpL74CCia7WPAvHPbCu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRMLY7JBi7suZmT4XqTFTkm6X+z/lB7RRcaQi+ombeFzGc+KjU
	z6qczMGZfDZ48gumy/7AxUc5za44iGHb5T/oflsRXW97P1iPXP415OcY
X-Gm-Gg: Acq92OHqtorEaKCMCTPo83X7YsmT2iNclCTlRkQINppOVV9GrV1Z9KJkkoLn0lMC483
	0GCB73VX2gdqqgEEj3uy4L/2+RV5mR7B76TNvx+sR8bqsjl14q+Gbtgt2GK6PvwHmvnWyw73lHf
	Wrf+RRATTxMqq5dU5N7nAjxyINArFwRwXL8vn7lwNqz/TrJrFii096hZ9fERd1w0FnC+uzc+Iz7
	So6KUimNY4yS8qVZFcw4PXmmlSYrBLMZ8U/KUuDhQYWxtqqZ0s7sRt7tkDiJ0Jc2SiAFkD5OH4A
	Lom/1knUJ6rCkJ6A6FZYPhnMd98M11WQz6/r+5Y/53nhB/kioysuiK/0o8xvnTa9LxIpN7ylLpf
	Guicgy27yQpJi15M3GC6lHkevEZBIwAdvS6OKWqufCwYI/BA5oWOdeokAoLTN+y7EU8wGNNahiJ
	JUfmQcR/DOkuMK9YyAlLYp5xDVBAwlkuEcaCYjm/9vrhexjk4x21SAPXw=
X-Received: by 2002:a05:6512:2210:b0:5a8:bd9c:a2e1 with SMTP id 2adb3069b0e04-5aa594652cfmr310683e87.2.1780051519854;
        Fri, 29 May 2026 03:45:19 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b071d25sm205269e87.18.2026.05.29.03.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:18 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: accel: bmi088-accel: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:44:56 +0500
Message-Id: <81bee2d03a2a915c0837f61e407856db80aa98b9.1780050609.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
In-Reply-To: <cover.1780050609.git.sozdayvek@gmail.com>
References: <cover.1780050609.git.sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The probe path calls pm_runtime_enable() and then registers the IIO device with iio_device_register().  If registration fails, the function returns the error directly without calling pm_runtime_disable(), leaving the runtime PM enable_count unbalanced.  On the next bind attempt the core warns with "Unbalanced pm_runtime_enable".

Switch to devm_pm_runtime_enable() so the enable is automatically undone when the device is unbound, regardless of whether the rest of probe (or the bus remove callback) succeeds.  This makes the error path correct without adding a new goto label.

With the runtime PM teardown now handled by the devm action, the manual pm_runtime_disable() and pm_runtime_set_suspended() calls in bmi088_accel_core_remove() become redundant and are dropped.  The hardware-level power_down() call is kept so the chip is placed in suspend mode before the regmap goes away.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/accel/bmi088-accel-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
index c7da90af0d2d..0fd840d85a15 100644
--- a/drivers/iio/accel/bmi088-accel-core.c
+++ b/drivers/iio/accel/bmi088-accel-core.c
@@ -573,7 +573,9 @@ int bmi088_accel_core_probe(struct device *dev, struct regmap *regmap,
 	/* Enable runtime PM */
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_suspended(dev);
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 	/* We need ~6ms to startup, so set the delay to 6 seconds */
 	pm_runtime_set_autosuspend_delay(dev, 6000);
 	pm_runtime_use_autosuspend(dev);
@@ -595,8 +597,6 @@ void bmi088_accel_core_remove(struct device *dev)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
 	bmi088_accel_power_down(data);
 }
 EXPORT_SYMBOL_NS_GPL(bmi088_accel_core_remove, "IIO_BMI088");
-- 
2.43.0

