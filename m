Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008985;
	b=k33akvQfDDjFx16rUtjAtMD9lqdRz3hrt9BBq4D9MZiWrZcr8T0YjMeaOV0kl9iz/pxc
	 FvLNulZpBhL+Hass2KplKsrRjXPcEYt83YakvsWmtblvZQryWNm+9nT2Y6XDxnuYTkRaB
	 hGkn6/Y9dR+TCxR503PJlAwlvTygYwZYX666nNKL1elA+KLheZ2RP7OcZDW3H+Ng+4MTM
	 sKniPs+5aivoVcarnN7oFGhDB0nIiUvJF5MTIbCaOoGwMyuVLocnHAHARkGTzJfRas/O7
	 h0xmtyIvWrLBT/zaOH/WW47dX8CVihQxJc/cTIA5uHqe+9p0UoDoo0dCP3YXtT9Yhlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DXpJqO2ckp/EX7hz6QTsLqnm/+vAUv9IUn8k0FN2zk0=;
	b=z9mR1mX8ZIoYj7swDSYE/O5jUKTu/qlQigOHpvXa0t5NDvdxY1w1qEXYRLB1ogNWn0AF
	 EmYwgE5ALAgisG7lwLQMOz+dfI7RJWC28vfylTPqNjg+/85Pq1B9ijXQJIQIEBCestvp2
	 279cQ2Rw29r76kn0u8UFotGcglEAUZjNu3ZZGwvjGCJpXL0H4rp9LMdL43aDM1gvRV1Qz
	 pvLRzeXaFPUn5UD8cCK/pwFji3404jLRj1JBVQp/sbIy/Hhp/KC2xIrc+RGGfIAplqe7P
	 H+5nQ58aHGhAFAf3eDwIemdD4W9KGju9YpDHGDMKGpR04CYGlo+7xYG+InecVBGnW9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Th5kBiS7;
	arc=none smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF806606A31B
	for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 10:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF806606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Th5kBiS7
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1087848b3a.0
        for <linux-iio@vger.kernel.org>; Mon, 26 Oct 2026 03:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008984; x=1793613784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DXpJqO2ckp/EX7hz6QTsLqnm/+vAUv9IUn8k0FN2zk0=;
        b=Th5kBiS7rQtx+ZPtW/XI5NlYv6ndEQ3BLDezHD8vkN20oXlVNQYo0W6lygaeZTsa41
         K2mBJfF+KE+C5HfJCuCdnedjJYJ23bbgYoOBwQ2+3tpdRi66VCh1eKlWxr+VuyVfhmXQ
         vsn+J4+QTkHXgZf72WHT2VcW+Y7pMKcz1FAceJ3erRT03CkcjYZBCJIbDElB3mf/F6F+
         ua1i4df6eyognp+CJWF9IDzGAIX9GKjVnl4dCU7dIl9cnYlwGook7MHredWDCY2g0IVp
         jxQCzf8804PZ+thtHYb5wAMGGOY+AFej6GxUSOwRf+72IR+49AQhfcC3Ohqc2ZtbTn9D
         HNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008984; x=1793613784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DXpJqO2ckp/EX7hz6QTsLqnm/+vAUv9IUn8k0FN2zk0=;
        b=UEJd/K3QYowrQoFBGN869RugY4xgB7kd5shZYUH2o7tTVJrM68TDpmGV3bE6n3R5wQ
         7GhYCm//lHzSZmFJYlMQjnRYH6wmQc3rXHEOA3Uo97xq/RW/L1XbF6WzRpD82Y0OV1l/
         LW7x1JH12pVEuYDMNr9m+rMTAtECP65bLAoztK7jG5v4vt6AU2sCOeZi2ets2KxlDr0Q
         nqQYfozoVREIgfdp77ngQSi8hHTHekP1W0DcoCorpLGcj9AhLGD85LwOtDmQnayuFSqt
         vlR3YzWhlGOGgaawDyr08q3oDnOPNgEuVF5RVLcKerKz7kd1c7qCrtDsWx3I+2Bgef85
         1T8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwLXZncW1pjyUgGjZ3agtMOlyUxGBLXakyVEsUeSvwUovljVK3uxLwNlREvUttA4CfLtwsxPgC0A+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJS7Rd4KvGHoYV/gnEn9l3BxBa/JwGrFt7rnaOk31cBAksEtkLr
	t3wuECVV6agzcNh6iXp0L4dDDNlCjkrixE+Xrr7iVU7udEYIVRduCCr3bQmdeRMJPfM=
X-Gm-Gg: AYBFou3z54tZNaoFz2g8lWteO5uaNlyCUHG9myruPNGQUZ2JI5JAI3WXtQ4l2GDPTSk
	B0NkW1ZJf9FUhbSXtB8tpcKKfUmhdX6oZb3CRn8EE8Kr6w0Dz1y+juTjUzW6rX0/JrL9F3LbRET
	Mmn66O+vWtTe3yPm4bSth8wM3c4ftnsn2oV4FGTdVjV+LzPSc4OFYXFV1DssG6oRp7EheUBDFMt
	9eTEb6GMMZ/8Ua8i6KALO+/lM0y8LQheAT0gNLRXX2dCDZO2Jne/a8rmxZjRHXKtA9MKIfro7Kp
	wBtl/GLSS3gAkNOJeH8S45Gy+wvhJc4mbW3bWasetoRiN5agZtUJ2AT6usVb6LwHWAQBURGUROU
	ZN1GOI1Fd6m2128WB9R7P1kmaMaVOX04QB8s8PI3wFPAfTPufOalQais9t5MagsXzVMAjr9EE/c
	b7z+gr7FkFek/HkQr0ZJHedm4MmwIZy1TVCzbFA3g3/AVlrWaNorqICHRyV+TDPkpZDglD0EMpX
	7mjm6Hve87zwjagyBr/NidSeGD/0xH6Xvf6KwfzDzNcjeZ7qm6sxkWkHlgnW/5rygbUDnhxqcSc
	pd4FET1Dw4veXRJUiqicCuWjb9FytEFgYsU8oqCTkQXj0dFUmkMZ1ztT97PKRjTRTgSVoA18lGB
	tfya2qU4q8PulS6m/BPQSe9Y4bbeI
X-Received: by 2002:a05:6a20:6a22:b0:3e2:8c30:2e4f with SMTP id adf61e73a8af0-3e7cd4f5d8fmr4700592637.66.1793008984058;
        Mon, 26 Oct 2026 03:03:04 -0700 (PDT)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.17])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccccf37esm1425204a12.27.2026.10.26.03.02.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 03:03:03 -0700 (PDT)
From: Yu Zhang <yuz08559@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yu Zhang <yuz08559@gmail.com>
Subject: [PATCH] iio: trigger: fix use-after-free in current_trigger_store() on concurrent writers
Date: Mon, 26 Oct 2026 20:02:46 +1000
Message-ID: <20261026100246.68005-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

current_trigger_store() holds iio_dev_opaque->mlock only around the
INDIO_BUFFER_TRIGGERED / trig_readonly checks and then drops it. The rest
runs unlocked: it reads the current trigger into oldtrig, acquires the new
one by name, stores it into indio_dev->trig, and drops the old trigger's
reference with iio_trigger_put().

sysfs does not serialize writes to the same attribute issued through
different open file descriptors (each open has its own kernfs_open_file),
so two threads can run current_trigger_store() on the same
.../trigger/current_trigger concurrently. Both read the same oldtrig, both
overwrite indio_dev->trig, and both call iio_trigger_put(oldtrig). The
extra put drops the trigger's refcount to zero while it is still in use,
frees it, and a concurrent writer then dereferences the freed trigger.

With two sets of writers hammering current_trigger between two software
triggers on an iio_dummy device, KASAN reports:

  refcount_t: addition on 0; use-after-free.
  WARNING: CPU: 3 PID: 3467 at refcount_warn_saturate+0xbb/0xe0
   kobject_get+0xf6/0x100
   current_trigger_store+0x15c/0x4b0
  ...
  BUG: KASAN: slab-use-after-free in current_trigger_store+0x168/0x4b0
  Freed by task 3468:
   kobject_put+0x125/0x220
   current_trigger_store+0x2cc/0x4b0
  Allocated by task 3454:
   __iio_trigger_alloc+0xc7/0x100
  ...
  Oops: general protection fault
   __module_get+0x27/0xd0
   current_trigger_store+0x192/0x4b0

Hold mlock across the whole operation so that reading oldtrig, swapping
indio_dev->trig and dropping the reference are atomic with respect to
other writers (and to buffer enable, which the -EBUSY check guards).
Acquiring the new trigger with iio_trigger_acquire_by_name() under mlock
is safe: it only takes iio_trigger_list_lock, and the buffer path already
calls iio_trigger_{attach,detach}_poll_func() with mlock held.

Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/iio/industrialio-trigger.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
index 76926fe..9241cd6 100644
--- a/drivers/iio/industrialio-trigger.c
+++ b/drivers/iio/industrialio-trigger.c
@@ -441,17 +441,18 @@ static ssize_t current_trigger_store(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
-	struct iio_trigger *oldtrig = indio_dev->trig;
+	struct iio_trigger *oldtrig;
 	struct iio_trigger *trig;
 	int ret;
 
-	scoped_guard(mutex, &iio_dev_opaque->mlock) {
-		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
-			return -EBUSY;
-		if (iio_dev_opaque->trig_readonly)
-			return -EPERM;
-	}
+	guard(mutex)(&iio_dev_opaque->mlock);
+
+	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
+		return -EBUSY;
+	if (iio_dev_opaque->trig_readonly)
+		return -EPERM;
 
+	oldtrig = indio_dev->trig;
 	trig = iio_trigger_acquire_by_name(buf);
 	if (oldtrig == trig) {
 		ret = len;
-- 
2.43.0

