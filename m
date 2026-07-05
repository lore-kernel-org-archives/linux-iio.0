Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78D0258EE9
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 04:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783225658; cv=none; b=kvWKcWsujEDd4nGV3pjG87aw60hLIn3URa0Z3LztbsR0v/DRqt8vFZRAipo2+pA15OBzsgj6X1lNuLjiQ4Al16TGhXcDkJT+1Mj2JH7oCTHXcoIjsOZG6h96OFrIX3MHBIWLzCeYXS3i1xx9rSCWeOm5D/oWuj/cEtLaCMqwysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783225658; c=relaxed/simple;
	bh=xXbqEGBTHdI4gCh+pi+4bWPkKiEcKqIDR6p0WzuoYAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p4ZUbvoz10kYtoowMi7D/S7jY6oWBwDhCBncn7zSMCTCCqjN7yiAWY/E2Kdhev2BSgNrP/BJYnC1+gWM0JsFPpnfQqxMqIoe7c935YLNT+uXoArm8XbwDbQzb0RGPKC4me7gG/ShkO3nwReu81xzEhvQ54imkNKh9MMbHI7kKoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOzP8qP6; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOzP8qP6"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aeb5e85378so2116449e87.1
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 21:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783225655; x=1783830455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vJJ24iBX9cnCE8ZMUdPAOVzOCaT5jrfPS+x2jz5hwlw=;
        b=VOzP8qP6IVGH+UxEU0T1NumTvz2E71zhVGFur1hjxOA6zhk1Yjy0MQtOEbJKRUy2ch
         guIMOc2g6lOhjFXwyNoPYxBwxwnIsdKnDxJH38UHN48ogoDURjyJZ/FvL+LAaytdOt07
         7H3wWD79gPmMUtJzrXhps+gllr6pf+xtMdviDM3uhQtgRvHJCHCtYa6GQGlrGuGvp5IS
         u48F03esV8r5BfueU53p68pKjqS05x/fDqruWsE8mO0BQJXNveH/7VJumeSVZNTjthn9
         lAtHR4G61jXCvOXn1+wUesdMvzMGkV4oA/yop2AVCpVF1fXPtvHM2gXewYdbcfVjVSnG
         VyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783225655; x=1783830455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vJJ24iBX9cnCE8ZMUdPAOVzOCaT5jrfPS+x2jz5hwlw=;
        b=AUCAgWbc1R/ORGec9KIGTyoLY81uYEMDbabngTcz7PbxqJ/NkoPgFFJuED/ZanU6tO
         AcpMl9fAnHyL+tiqA16jey3tpV6nKTej2CDDneFHMJOV3cyMmq+I3MiMGK54dfymr1XY
         dFWckpcAbdFIx3T260CVL2wjOIeCkaFLO3eRYR5VAMLQHgMSeEXtWpYi9Fpz64I78JfJ
         ByrfWtJgr5HfU5mHRPEjenmuKB4C0uL75rSbQ+/B6ifKpvEgcYXFsoTPJZeDdaBgc2YQ
         lKKe0sXBHEuUcl934xJCyPg2BjSRevraE5WZenI5dK5HR4+4vpNo9mXB2gifPOIIY3e3
         NB8A==
X-Forwarded-Encrypted: i=1; AHgh+RoV5D8zkJ1IMHG0OBX6/hWwoZj44XzbtzeSxKEdosg7JNuxg4tc3JXcQ6iYuTusUJgsvY0fpYyCUTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvoT1xWQrCB2PFCJp1SS99QjDIkYwjpMEN9CGrpOkBiV86IuE
	x2wSYN6W6+kJ8ZFPOIm/8MJDjiA1p1g7WjFeo3Wzp1WFaDpBc1HHONJD
X-Gm-Gg: AfdE7ckgP+PbZn4fYf32ysFTRGu6fsYIPsBdY4yX8XPWcNFV9nAhDVbIR7j4E7oxNMU
	PtFJbqYIPktlD287Rz6dYgFfGr9vgLxF3zAkg/BilwUf5YkUzug5/8JliMVflXjREn5IKAObCXQ
	ps14CQhNEt52PNakNR5n34OnIvRTwAVgOscg7hGd8/NbZSR1EXg6uFWmAIg1BJXR6i1m6vCW+s6
	XboVbufKJm078kOfUYslKF9efY4Vnba7hbzfJyYmKi6sOxQFxoxgeE4PxWiA6rvMjk7c9G5mTS6
	/luQEEAb8EOgvEhcJ8N7q6cjVa4jcwoA30ThUWIsMF5QAa5NMNSx/G/VBpTWuGT2N/Jw/vrkkq4
	5j3RqSL9OqujNav7OPHmEqPpM9vfKbe1QaKy/C0yiTpCoJ13Eal/CEmJmLjaro8tyQwgFc5iGhe
	l8W4CwWLew1rT8Fi+fbpz2oLYYUFaxGz5oVbPwoSptMA==
X-Received: by 2002:a05:6512:3d87:b0:5ae:b7d4:7dda with SMTP id 2adb3069b0e04-5aed50b668bmr889740e87.32.1783225654553;
        Sat, 04 Jul 2026 21:27:34 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed1377068sm1798289e87.27.2026.07.04.21.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 21:27:32 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: accel: bmc150: free irq before teardown
Date: Sun,  5 Jul 2026 06:27:31 +0200
Message-Id: <20260705042731.388592-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bmc150_accel_core_probe() requests the interrupt with
devm_request_threaded_irq().  The managed IRQ is released only after the
driver remove callback has returned unless it is freed explicitly.

bmc150_accel_core_remove() currently unregisters the IIO device and
triggers, cleans up the triggered buffer, suspends the chip and disables
the regulators while the IRQ action is still registered.  A late
interrupt can therefore run the hard or threaded handler while the IIO
trigger state is being torn down or after the device has been put into
deep suspend.

Free the IRQ at the start of remove so that no handler is running while
the rest of the driver state and hardware resources are dismantled.

Fixes: 55637c38377a ("iio: bmc150: Split the driver into core and i2c")
Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 2398eb7e12cd..2adddc965650 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1766,6 +1766,9 @@ void bmc150_accel_core_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
+	if (data->irq > 0)
+		devm_free_irq(dev, data->irq, indio_dev);
+
 	iio_device_unregister(indio_dev);
 
 	pm_runtime_disable(dev);
-- 
2.39.5

