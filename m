Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993527;
	b=EYtSXPVrYSRZHwG/PKulbkwaVJFEu+9rjCP0p4OYryPOtZuwsbMB4ZT7uc2Xi6PsaE6e
	 B+HuPJnHvbIUEjObM9+hAxulicokAiXaaXT99a5HMLuDm1fXr8bx4FUhTQ6mDRb1XdT6N
	 qSkJZjhIC4QM8eQT/YXyuX/PUu46uAicl//CSKaO/JKRwQmIDQnWBW6pZbfLBoNF1Q1fL
	 dXg6tN6Ec6cLsaANyUxCUg/6X6CGN5ZbvDZl8KngE86Kf4T7OSx7HiM09eEBrSb/W7Dgy
	 BULKTxJsD0AwdP6o49SKVj2SxDUuYF1UyUPDa0BwGkvUwYIHYbVyUYXAleTyuL1ds7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=Iw0r9KyM9yE8+UHLOBvRU3eF9rfoOEr06pAaRlmDbAI=;
	b=NSM0kepp5Hvu1xhewfZ3vJr2OTd37gyAeF6KLqMOlj7+MiBOVn9n6HPdDRN2bkuADPbI
	 bGXLNZcS3YSNsfmGinKHFT7MS9cisE3tVqLf5t+8DOSc/BGQzxyvzi4rJ0I4LEw2cpNrO
	 E8N1DTVwrwj/bTdowAluEVrMwgMBGCneFRNWKp4VMzwovzouPvoSvv8+NONV8e5rqeE8H
	 Ez8/H+SnQpTwMoayh4F9Ph1Q3qoLerp2Gvwb7s8Pe9dV6KahJOgB5fKhV/JDoXdvSVbe3
	 zHR2qg2dJfUiBXF75E1ln2XHFLv/iqRRGDD37HrioyVWkeg72zR89nyhadsF/zCCehQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JOLCqPsW;
	arc=none smtp.remote-ip=209.85.208.198
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81E606A32D
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 19:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CE81E606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dbalint.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JOLCqPsW
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-3ab382d911fso4751591fa.1
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 11:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793993525; x=1794598325; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Iw0r9KyM9yE8+UHLOBvRU3eF9rfoOEr06pAaRlmDbAI=;
        b=JOLCqPsWEhNqvFOx3/qaiUcFebdO112TNKsSqX2AFW5xG81g+8535F24cncdWzB9d0
         NijKGrQduJPe8aMZlBWGmexK/h2h9cay7gxZ+wMrq9yQFHgl5dyvrlANHcgvLKcvvap1
         VTOUupmkJEuDGKnveoP7c4sVve4o9I3+FO/NpJq3+9+VtTbYRMjXilKh7JvuN1L5yK1+
         RD9+bTKAEOaS239HwvTaWfCn6WDPcXnKNPEHYIJmJ2w+QA4UaVoP4BROpNoAi2/uWIMF
         FjpLb4UydY+jEPABvttUBtOrdZ4+9Fp0ssgtVfwhUiVLHBKUiF6jsdrf2fc/6Ue1cfMP
         pa+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993525; x=1794598325;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iw0r9KyM9yE8+UHLOBvRU3eF9rfoOEr06pAaRlmDbAI=;
        b=y1jdULuUcK5r0bf7KRk3WTrB5Jn2o1/y0svGYOHVKq7dP0wi90I0NPjdjXWFvTmCHf
         mx//p/LcZ+DW6cmk4uP7dlXW/03xfrjqr9geLWOC/0a00VWZrvBR9IPLS2mnE7t5/rbX
         X/2Ko0H+IwmGcrA9SVR0oN7SG4EGpNe/cvFucKoIe5lcyaTmEr7L83Rl2cwrWi7pfbyK
         xbyecIA6l2ycRGifyt+tcnXyYI1UHUOMt1RZieii3e01oZWJl98demhFbRAaWppiTQR+
         iKxklrbYXcBpU7Za6n0pIelMlqOp8aXSRM1YIPoazhBnqvZE5vghLLTmGefTldLC6s0h
         acvw==
X-Gm-Message-State: APuU4Z8N+Ho9GdDiY7ci54GquriH+szvVmyjGARJc9+3p/xYuSJmKhH0
	S4Jkkx32IvhO80LC86bCl+gqTXNkAjoYRaIkY1NlCm9HbudZcFu0pjtwpqGfbXvmPE8IbcgC3az
	wei57N0rcwA==
X-Received: from ljgi21.prod.google.com ([2002:a2e:8095:0:b0:3ac:f040:c4e9])
 (user=dbalint job=prod-delivery.src-stubby-dispatcher) by 2002:a05:651c:31d1:b0:3a9:7e4d:7fc5
 with SMTP id 38308e7fff4ca-3acf3b2f8cemr7731911fa.18.1793993524757; Fri, 06
 Nov 2026 11:32:04 -0800 (PST)
Date: Fri,  6 Nov 2026 19:31:14 +0000
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106193129.43493-1-dbalint@google.com>
Subject: [PATCH v1 0/3] Introduce cros_ec power monitoring
From: Daniel Balint <dbalint@google.com>
To: Jonathan Cameron <jic23@kernel.org>, Benson Leung <bleung@chromium.org>, Lee Jones <lee@kernel.org>, 
	Tzung-Bi Shih <tzungbi@kernel.org>
Cc: linux-iio@vger.kernel.org, chrome-platform@lists.linux.dev, 
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Daniel Balint <dbalint@google.com>
Content-Type: text/plain; charset="UTF-8"

This series adds the ChromeOS EC On-Device Power Monitoring 
(cros_ec_pwrmon) driver to read onboard power-monitoring ADCs,
such as PAC194x, wired through the embedded controller (EC).

Several ChromeOS platforms are equipped with onboard ADCs that are
connected to the EC via I2C bus. The driver interfaces with the EC
via the existing EC_CMD_PWRMON host command API (and EC_MKBP_EVENT_PWRMON
events) to manage ADC accumulation and expose accumulated per-rail energy
through an IIO sysfs attribute.

The driver is only loaded when the underlying hardware feature is present.
The series also fixes alignment padding in EC_CMD_PWRMON definitions.

Daniel Balint (3):
  platform/chrome: cros_ec: fix alignment of ec_params_pwrmon
  iio: adc: add cros_ec_pwrmon driver
  mfd: cros_ec: load cros_ec_pwrmon on supported ECs

 .../ABI/testing/sysfs-bus-iio-cros-ec         |  13 +
 MAINTAINERS                                   |   7 +
 drivers/iio/adc/Kconfig                       |  11 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/cros_ec_pwrmon.c              | 333 ++++++++++++++++++
 drivers/mfd/cros_ec_dev.c                     |   9 +
 .../linux/platform_data/cros_ec_commands.h    |   2 +
 7 files changed, 376 insertions(+)
 create mode 100644 drivers/iio/adc/cros_ec_pwrmon.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.455.g6c5a503b38-goog

