Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A524317D
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 22:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771973328; cv=none; b=Ol1yZqMUBhKIUuf1TUm+LSgx1p1RSES5qpBNbaAgPKcBcZCGXlY5nJwKeYFjsMY/MyqFxbYEQLlFWUyD9vEGp5gXV2T7SxpT+aoxmkAORQL2hmjPjdN2CyeAvB2UeSYVxJWvxYDRTCUxmpgicBL5gi6D3vjIQIu0cfcFW08aDJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771973328; c=relaxed/simple;
	bh=iT/zSBZZC103llbdI1FZKHJ0O7TbNfzO4lDmpTxrzkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AkZWG1VnsQ8vAqCyeBsMBI4gdNwRZkJXxgb6odRHbo1OLXcU6U14PgGN1nP/O8SYSoJQSq9y0xqTYdyTEFPvB+LsbSvXEaNjWHrZjsALMNRrEJdEXTdDOj3W9yvoBIT5pVQaZvBWiOIXzF/YIGSEBmND9jDCXQjaVmxp+iwXtTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0pbvu3J; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0pbvu3J"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7927261a3acso54602567b3.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771973326; x=1772578126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liTx5SAnAXmiPnh0ntA9AzZPkXzH8iR1KauHaEM1SNY=;
        b=I0pbvu3JqDglCLenalr+4Gyv3ogAsgekaNUbzGt8OJWTFS7usDkP56muSGq9jG8tdE
         diOHw5H9WYzUexbmUmMFgwcvq1ouLtTBTStYzpnUrF/v355Jz+IUClI1KfcZwz+7vYjA
         g9fmwTNZgyhDkaBxkojJ9yi+CqJ8XLukzvgce9Zwq7IX1nTuiqMYIso+k+QP+DqcOd7d
         tJsKbqNcPJaNLzDuqVjU4gCCGIeg3cGk1b3KHhUX3l9DRd/6l4TPmKXcJo5rTut7xzh/
         lzGxn32xJ+Xg+ADPJvVtvD/10zP6nvWxJnYSDUH0Rb85Fz+1FiCv74JW97YhFiAz/PRN
         rp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771973326; x=1772578126;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liTx5SAnAXmiPnh0ntA9AzZPkXzH8iR1KauHaEM1SNY=;
        b=U4+dxlETV6l6lIHOsHASSI+np//U3nz9sxPJH7BrNDwrfia3iVL2Tvb6OEZJHDD0VQ
         qbQpT1mxERdRjJvqzO0TGvM8nDjn3roZIzvPTgWSvhruxegqWMrIoiApKJyE37sGzY8W
         R4JMCE5L+pCRbZvwT/Oc0vQaoszuM9azQ6AidDUnpxVDVSdykciRgXeEuvKcztXTOOzk
         768x2RvrKE6tHJBaZ5gYPnsSah3U5EHnrqMJd1GdjcL0wfNxr01l4LIkN8Akhi+KoRfM
         Pl6QV7/+hR5GQQXYwf2+FTTdONkSerBZtB8JKHjVKl8BZgSlYaTxbZnds5wYYknO/32f
         Bdhg==
X-Forwarded-Encrypted: i=1; AJvYcCUsTVLC6Qf+c6yNfakJrGNFl9Be/TVYYvNWqcjNc9+2IIGrG32rVmQ8l/BVfjGjVaPnxFdgvYt3tVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtT+iLxzzs974kAtn4StP42A1ZHxBJYu1Y2Nq2wJ0Kxfns9qT
	+55IfNEFljgiR+6u02i6Vg1tgGV6zNXyvdngTgXcqp6hLjCSPf9kmV0d
X-Gm-Gg: ATEYQzwlAKIxedqdXmeKEw4Ne01hQhjcd7nelAFxYq/QBMAki0CMzeLPotpPY7RziEc
	p/sF4sbDdUFR+rYnWAlStRGeJbpySn3ub2kIHIWrdTdt9iaLzfhwtM+7uLH541rqJYGP32H8BtM
	/B6ca14ZI75mbps01GIeP/Orc6KPlMQxPV5R1pU6k+P8OJl2SsfQYcLCDdfFDDj8Vqi6XGLwbQ0
	gCi8W7lJNDRmXJcdrAxeNE+U6LZPZXED5e9CKg9QOc1oL2Iz14Oc+lrTkuqVshsB+U4xXDMfZ4e
	fvrH6+cYLPuUVv5Ktc8DWTaXGibvsfQ2I7yHT1U4jO2xuHh5xxmT6B5dFHJkglX32UVwxdELizs
	l+DmPMFpm3IsY0oD41imx7IrrTkhYASxW3afy7fRWYX/0218B9M5l+SB3qkbbMNcyCnhtjYkpLu
	NA73DnzmEuJbZe3QXW6rJ8HwUhJnyxBOwIfo0Hmnnselwo843VgdJ84rxCGYa4zBvsG0P3hjjOa
	GW7ettONsvxi/IFFQUMTfiB
X-Received: by 2002:a05:690c:62c8:b0:798:6666:26bd with SMTP id 00721157ae682-798681fa054mr3021927b3.37.1771973326012;
        Tue, 24 Feb 2026 14:48:46 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00::5c0b])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dd88efcsm48838757b3.24.2026.02.24.14.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 14:48:45 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: linusw@kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v3 0/4] iio: gyro: mpu3050: Multiple bug fixes
Date: Tue, 24 Feb 2026 16:48:14 -0600
Message-ID: <20260224224818.2452675-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes 4 bugs:
- Patch 1: Fix free_irq() being called with wrong handler.
- Patch 2: Added missing free_irq() in an error path.
- Patch 3: Moved iio_device_register() to end of probe function, in
  doing so had to implement correct error cleanups and place
  iio_device_unregister in beginning of remove callback.
- Patch 4: free_irq() is after called iio_triggered_buffer_cleanup()
  which breaks LIFO, place it before it.

I plan on doing a proper devm_ conversion of this driver, but went ahead
and did these fixes so they could be backported.

v3:
- Patch 1 & 2 remove unneeded code snippets.
- Patch 3 remove stray change and tidy up grammar.
- Patch 4 clarify patch purpose.

Ethan Tidmore (4):
  iio: gyro: mpu3050: Fix incorrect free_irq() variable
  iio: gyro: mpu3050: Fix irq resource leak
  iio: gyro: mpu3050: Move iio_device_register() to correct location
  iio: gyro: mpu3050: Fix out-of-sequence free_irq()

 drivers/iio/gyro/mpu3050-core.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

-- 
2.53.0

