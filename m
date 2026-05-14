Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9719C3D1ABC
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778798789; cv=none; b=mNB8yDc/mVulXq6Q71y+626Z/i9tzs3igF2Y7KbRyYygVj2IZUSWNu6qQRFKsIpHcmdTI5e4tinUF4R09ZCx/UOhAU1QiGC6pHOHxgdaa0T3i8X0cJmDiRC9Iu8bEi7vsygwZ5i93DSfPZKMSZpzRP7opTGaxbBzOVtUipD+xkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778798789; c=relaxed/simple;
	bh=/qpTndcQcsSMTbBh2g/Dq1Edd2Lq9Y46ZytiK3Q6898=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=npkej7tv2pOu/b42L9Lk7bfvpHLZmrEXMzQstIDiUq5+52vy56wYrEQHWxiDgr6o0PAEvWvMeW04UsbUR0yP1F57hAmVbnhWzATNaAb9ZAS1aINwVAFHiqJAVwOdRCUCVGRX4QzesvFZOsQMPCKdFfH4ENXtlQkaJSQUvW2VeaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTfbbZl/; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTfbbZl/"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488b150559bso66932935e9.1
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 15:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778798785; x=1779403585; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eYrTvT8XGfhOtNqMi4pNf6wVMIheUqf8s/MFC+uDco=;
        b=hTfbbZl/xpINJixLnDgVBieT9NCANNUIPRkfP4m9b0n7w47OwZ+N0oQ5FGE79//P5a
         DuI/om6xC3vl4hs+WONYqjgN+/RUUQwnA1kZPzq/LOgITuh5A6CjcHGDhJPUJI76roda
         C2hePwIsOyAAjqmws9nlf7J/a4BRiAYxUBmMeOPtaBQpOLORe07dYvcTTKykOZC0uA9t
         x9J0aUXCRUOWGdf8lkRFJqhDh399z02UcZOI5eAgNPJwsaQZ0mGKzouvSU/YNoQ5pSfm
         /idiwPDOdOAxu4K1AjZo3Vq83DfOT3BpEXWky2cahA8Vr37SRtoQqgoopOrM1UejJnQj
         93WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778798785; x=1779403585;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eYrTvT8XGfhOtNqMi4pNf6wVMIheUqf8s/MFC+uDco=;
        b=SY0GIX/WaVJEeIdBhG72oPYk+dIuaoESouhc1EOCEcZd28/9LzlTxH/pgqoVh2e5Iv
         hveKpmWAgq5iRjf2jSM6asNjhqyJCbfURGTlwV1nI3Wdm1Hn4RS6KNsFD2I9omTwadbf
         5x7ye2obNtsjDpL0mSW4yeUxi2eiPMHFtKdfBBnl1kfhg7iRIbaRh9cbua0Utikk2Dpw
         1iwzW1m7+oD5LAC+nUiqoBQX2BL5FVVvitwAy1jYbuSzIhp0ZtFlrj8FLTSuoCLVm1Ym
         BOpNq/mOfp03L9NLYxTrLaIc5jHeFH/NY1PABH8IoOCl6mmWGMQ1PeNjeKhLbdGvq0Lx
         K70w==
X-Gm-Message-State: AOJu0YwdKwmUPJnT4hxKJ1f2Yr0cTfUqmwtC0fvbe7iUsuwi1WZkPQSV
	UMj1RjZiPfzy35VXJIDj3I4tK0jKV+defKfYkTkoMPH2laPiCvIEOvw4
X-Gm-Gg: Acq92OEwZQUKPA4aU4+Tw3/RzKNBtK5wzRB2GpNbZFZOvV4P6c+WBvSwGpyP3YI0mjS
	8UfTTgEfRQmQr710ZPlzn7EDc3e8nA1veWua0RRbVY6VDp+F3l/YzyQEiz+wHx0YQ4EnkHAw/pz
	V8/JmR0DCHNtXTcgmv8Hll/pagNwwmZEEf8vbmLeT0fED1rRQl/aKS7BbQ7QB53X7v+FdNs80Bb
	lpkx/DqPpSrHXLiAc/j+m7lWJv3CJZ1L5uBGCJXSB6Rwn01iSFn8iORPeS2B4ytDAiH9FP8nuaI
	lOpNKeJC2soO7UfxgPojQlWIBAawPllVSBjXxuDXYjn5d7czP2nCsubKyyc7YTWOncO2RdVOwYq
	lbekzgXb5PzF2Go0j5W5YUqISYFi6qH2e+8aAjAmmvgJ8a4KQD4ZBWP5u5Ri302/Q/hAJiYJAAF
	2PnSj6wr0+LSqiupITBZfdE8jnpA==
X-Received: by 2002:a05:600c:698d:b0:48f:e230:2a1c with SMTP id 5b1f17b1804b1-48fe6631158mr15651015e9.31.1778798784371;
        Thu, 14 May 2026 15:46:24 -0700 (PDT)
Received: from [192.168.17.180] ([89.205.126.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537ccf5sm21332055e9.14.2026.05.14.15.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 15:46:23 -0700 (PDT)
From: =?utf-8?q?=D0=94=D0=B0=D0=BC=D1=98=D0=B0=D0=BD_=D0=93=D0=B5=D0=BE_=D1=80=D0=B3=D0=B8=D0=B5=D0=B2=D1=81=D0=BA=D0=B8?= <gdamjan@gmail.com>
Date: Fri, 15 May 2026 00:46:00 +0200
Subject: [PATCH] iio: buffer: only set IRQF_ONESHOT when thread handler is
 provided
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260515-patch-iio-buffer-v1-1-667dac4e55e5@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMyw5AMBBA0V+RWZuk3o9fEYu2powF0pZIxL8rl
 mdx7wWOLJODNrrA0sGO1yUgiSPQk1xGQh6CIRVpKYokw016PSHzimo3hixmTTHUWjZ5VdYQss2
 S4fNbdv1vt6uZtH8/cN8PGLCg2XQAAAA=
X-Change-ID: 20260513-patch-iio-buffer-395d8ca94768
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?=D0=94=D0=B0=D0=BC=D1=98=D0=B0=D0=BD_=D0=93=D0=B5=D0=BE=D1=80=D0=B3=D0=B8=D0=B5=D0=B2=D1=81=D0=BA=D0=B8?= <gdamjan@gmail.com>
X-Mailer: b4 0.15.2

iio_triggered_buffer_setup_ext() unconditionally passes IRQF_ONESHOT to
iio_alloc_pollfunc(), even when the caller provides no thread function.
This causes a warning in __setup_irq() when the trigger is later
attached:

  WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4ee/0x700

IRQF_ONESHOT keeps the IRQ masked until the threaded handler completes,
but with no threaded handler this is semantically wrong. Only set the
flag when a thread function is actually provided.

Assisted-by: GitHub Copilot CLI:claude-opus-4-6
Signed-off-by: Дамјан Георгиевски <gdamjan@gmail.com>
---
This patch is a safety fix for how the Industrial I/O (IIO) subsystem handles
interrupts when setting up a triggered buffer.

It changes the flags passed to iio_alloc_pollfunc to ensure that the IRQF_ONESHOT
flag is only applied when a threaded interrupt handler actually exists.

Full disclosure, I got the warning on my laptop, and got Claude to debug
it. The explanation it gave sounds reasonable to me, but I'm not
personally familiar with the actual code.
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 9bf75dee7ff8..40eea3a44724 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(h,
 						 thread,
-						 IRQF_ONESHOT,
+						 thread ? IRQF_ONESHOT : 0,
 						 indio_dev,
 						 "%s_consumer%d",
 						 indio_dev->name,

---
base-commit: 1d5dcaa3bd65f2e8c9baa14a393d3a2dc5db7524
change-id: 20260513-patch-iio-buffer-395d8ca94768

Best regards,
--  
Дамјан Георгиевски <gdamjan@gmail.com>

