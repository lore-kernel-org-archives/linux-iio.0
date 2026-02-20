Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C5F2ECEA5
	for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617944; cv=none; b=K12rZY4z86EBBcw4VAx4aJDJKTpvhi/3ICd2Ap6UZaVkHu4M7cAcKm1fnhMCFDAdxVRFNaxckZsA+Tzf/mXCr8M6hbvAiRjSul1sxHQnmMQ24fKMb3W+FjJ32O2YBpf2kXdQySmwyq+2BbLKtKAkWYDciI1Y6RJWecjClt1GVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617944; c=relaxed/simple;
	bh=0pAur40aIVokjmvof3QFs4tXl7zzEl7jVb1e9lTygE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozRYkDaPmgqTC88gth4QSJKWpX7OTNSoB/rlMh5ypwtHxA69rMQrXWhvZ4S0K2U7VOQUXlO3TVKi/ZjdDUlMoqW+zk0HPcNJfNe12/8rABsfqEhyGKATGomJmC+M9ID2KdhsxENF4+1KrnNDXM5H0COGzi8dQ92ZeN73iWXfAeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbZavnyL; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbZavnyL"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79628fb5c05so20160727b3.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Feb 2026 12:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771617941; x=1772222741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VvDSAjEuHdFeISLoPILiJTDna5OcaqVB9UyXP3sHwBY=;
        b=hbZavnyLsLYLEjXC0cO+KIojUuR0v+o9pQM98K5CahpuCCEmRwOlp+ktIQDVnK/X5w
         U+6As26v4hVofVTeZEFT0CKw2UHfiLhicM3LrPfAIp5kCSjgVG54ubJ20uQ3zDNBgzX0
         K984CVux+u6LZ2CWeK9m8NCMLC06QdGsfxFvaW3kkcTXJVY+R8n8Zh+K6bpstHydNKiJ
         B64fuTGkDB1DuDKSmicX50Bheeaifb0LOqNoNAgiid/Y8TZpvLarLlm8Qw3kr/5d3/Dn
         hMbs0u0suKFXJn9mGYz7ZMP1Azy2ImU81yQwAjMe9cJFXjcEL2150+LRbda9bBLnFswC
         j4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771617941; x=1772222741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvDSAjEuHdFeISLoPILiJTDna5OcaqVB9UyXP3sHwBY=;
        b=Bi+vnbufcdGLw2Q+oX09FmH9IzQpaYDoPplcov3WtqUyAdsdn2pC/loz2UwOzeXJbA
         K+jrwuXZFjcH69HHW4E3QgFyvwErdpAbWgeP1MbC0Qxx0V6G8uoulKYYSG3HefPJtij8
         5l1goLkk1JPcCE9ILTIHi/lY5TRfVJWwIyx1nV49RlHZ9f4SRc/wMM23Z7ZtToCCeZ7r
         GGShDZxwhGBrm7x4ZUexXA6gTfaFiYoU0d1aiMBdlU9SkiOSbpdiBpLY5k0Mhv8TqWqe
         yVY0uGLNI6rNbBOizEJ2FMM4jFzmzoJmksRUKD+LYpu8o2Fm2+WMKambCoULrherChD3
         7EBg==
X-Forwarded-Encrypted: i=1; AJvYcCXIoCgChbqtO7kH46FXOAQovJ9rgSSoSB3xmje8MDbDl7dhc+M+JSfL6/bABVrgfr5ihk0cNqxFKR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ3+XaO9efDf3RqRph8edWYZMyUJ0S8Ue+ZLOIJ+Yi5QJZGTr5
	gwMW1GsBjEaeMwPc4+XH8Qar5avv+1OytwPHwgBEgr4y7/o/rtoGfilz
X-Gm-Gg: AZuq6aJhJT0u8WmzTrI+YUKRZo/XV8Swn0oOYDCvrtNPbvJxoq0oc9d/xfm/jgjF8k4
	xkWymMDniS9YzT5a8vbhzuQY2NRSu4e5cj+mSCvJw75voACMDEkEsexiqiTrVfbqaaeM0IQs42o
	VlLfEjT+BoVRvMXrNrl3KZcCC0HGAHmTQa9gzDC6OZ97WA4gM6NZZ0ZVDl/k7/fGJSs0m6WK0Jg
	FAzmRpBaim1vP2L01wurQRj3nFEqgJV9zI11MvF/IroD2R6hKmbEFyHUDgqRq86niThVXTI494O
	XaRcKGJ+JFItwGMsTx8tw87syBfFJf+ymJu42/BGuFwMkMYh/oD31KhidMWmatUvQOSyuNvyv0H
	5z0JAjAFiagXTkCG+puvG3bPZEFsJKY2mrQBJktYoN3aL9qRLwN1hzPimbBH7FpCShjazhCpQel
	IOoWkku54q+SPKT7bY1KwUFR7qjLK7924W4ErNiS5G0WLcOCS5FFH/g0tAH1RHNG4BX21mgpO+N
	4QkarUua/m/ssetH+EM21S7uN4CkoL6Sc0f6dgw2Z4=
X-Received: by 2002:a05:690c:6e8c:b0:796:3079:ae1 with SMTP id 00721157ae682-79829149f70mr10878467b3.50.1771617940895;
        Fri, 20 Feb 2026 12:05:40 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd81f73sm898267b3.25.2026.02.20.12.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 12:05:40 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] iio: gyro: mpu3050: Fix resource leak
Date: Fri, 20 Feb 2026 14:05:22 -0600
Message-ID: <20260220200522.19967-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The interrupt handler is setup but only a few lines down if
iio_trigger_register() fails the function returns without properly
releasing the handler:

	ret = request_threaded_irq(irq,
				   mpu3050_irq_handler,
				   mpu3050_irq_thread,
				   irq_trig,
				   mpu3050->trig->name,
				   mpu3050->trig);

...

	ret = iio_trigger_register(mpu3050->trig);
	if (ret)
		return ret;

	indio_dev->trig = iio_trigger_get(mpu3050->trig);

	return 0;
}

Change request_threaded_irq() to devm_request_threaded_irq() to resolve
resource leak and use current API.

Detected by Smatch:
drivers/iio/gyro/mpu3050-core.c:1128 mpu3050_trigger_probe() warn:
'irq' from request_threaded_irq() not released on lines: 1124.

Fixes: 3904b28efb2c7 ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index ee2fcd20545d..eeac4ad47396 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1103,12 +1103,13 @@ static int mpu3050_trigger_probe(struct iio_dev *indio_dev, int irq)
 	if (mpu3050->irq_opendrain)
 		irq_trig |= IRQF_SHARED;
 
-	ret = request_threaded_irq(irq,
-				   mpu3050_irq_handler,
-				   mpu3050_irq_thread,
-				   irq_trig,
-				   mpu3050->trig->name,
-				   mpu3050->trig);
+	ret = devm_request_threaded_irq(dev,
+					irq,
+					mpu3050_irq_handler,
+					mpu3050_irq_thread,
+					irq_trig,
+					mpu3050->trig->name,
+					mpu3050->trig);
 	if (ret) {
 		dev_err(dev, "can't get IRQ %d, error %d\n", irq, ret);
 		return ret;
@@ -1260,8 +1261,6 @@ void mpu3050_common_remove(struct device *dev)
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
 	iio_triggered_buffer_cleanup(indio_dev);
-	if (mpu3050->irq)
-		free_irq(mpu3050->irq, mpu3050);
 	iio_device_unregister(indio_dev);
 	mpu3050_power_down(mpu3050);
 }
-- 
2.53.0

