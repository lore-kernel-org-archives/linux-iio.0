Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFB84028E8
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 11:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781092629; cv=none; b=uDM2l1EE5JGqOu+Qa05p6AP78i4Cm7Qh4SLbRLUUpIbdnEm9PQq13JrzkrvITjH4rFvjVqzA97Bj/O4bv8uqZckuKpTtQirI96H20e/CsGqzd9Tkj5MiRcM33sB4PpEKe7UqMNJJ24ifTovetyFBGy7Zm2mUhIv9GpkuDi/Sgg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781092629; c=relaxed/simple;
	bh=3Ow1vhYaiddpdkYNnZdeAh7QrGmJJKJ8rVShuvEylN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OCrwbgIb0+G15QG62TMdD19M8B0oH1I0hmn/cPTQUXHTfmP41z5ktNBc4XR3JTDHyzALOCwKiYrpPcrauZFdc+enaJ9tpbF2hrJFebXWJfOeK+OOfWzDrOyyg3z9sW2vn2VHua+bQtmIidyKd1xXB/YPuiSxiVWSzjoHt3EQ5cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=NtH2ChHi; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="NtH2ChHi"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84230ab8857so2988399b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 04:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1781092627; x=1781697427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5jBBtH27kqbFTX1MrIF55iLAuenItTJhzKigqLVUXl8=;
        b=NtH2ChHiWKs17UL18Bhscf+iCSjRRx37h0SKjVwvNddTafg9mBRWYQsbfiE8tl/LD9
         XoVS2OU7vv+8iKANIwXpvuN97VrVB+WEMzfHMEtuENLwAFZy0ZIgaGogknD7+tT38phr
         J+ORK1A/duqfhB1RX7gNdzdbeAopkgIqfaGiA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781092627; x=1781697427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jBBtH27kqbFTX1MrIF55iLAuenItTJhzKigqLVUXl8=;
        b=IHRODeEVZagjWJXwKpZkRvlvn14bQ1FxjFgu8TYKZBt/iaHy4GYSTcXoJaOqECJWPk
         xcuShCi/IEZkQ/Zr368RU6IaO5QMpz80eIvFLX7Ja82SZWV8M3vP+lijnU+9Sfpwj7sk
         0tYd0Zduk9DBYX6LlVlZpLGJNOxtBkMV8hKM/AOlXi59Y2DuLebne1dy75xncsqPgB1U
         BvQRK+CjYB5VXf23TwAfUhe+nrUX94tN4JZ1Eh5a5OZ3YQiIPVJoyKYRy26AwPBGhjDg
         fkfStpmyJ5TbYJiUPOB+5n30lXYotnd5EhzSuS+erdcoIErlh7AK91PCsm1g6U0tT/9r
         VJCA==
X-Forwarded-Encrypted: i=1; AFNElJ8w6ltnZY06ReM2v3TayX2LOedYn1QMxJknykQTOCgoBilACdujIgNIj+ZMWzwBjxhoa1pFnLwPYH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyle1cpvdGn7ah5dUuAK4RMHkeObfTTywyLuz274FR8+WFv7aAi
	UhZBODYC+cSv5OWLGla/kOywPjZDlgybbD+/ftj9XKH/RENKeH7KyMDz7M8LHaQmrvI=
X-Gm-Gg: Acq92OHlyBa3rRY27RzFBcETq6UPm1p+WJcYAVXqvShCbYWJzMYYufHrCF4P3W31Jt3
	uLdTy+uT3TZzwiTEu5h0hQRqVdL9NnBN1w0o7IA/lXktuHtkf8vusWbeC+hFUKs8ViityA/nZWt
	dn6KilwqECDnqpEYPxcHzZMniUpwFstVMSIsOScsoU/6Pvl7a3bP04HfpWx92vYa3lXjg0R3HhC
	xzGPv4CyzDWUV6Cy7wz5swWRP+UY2VeFfeZXi8mE60mYhTYrhu8X0weE/nZL2GBj0Jf6FIYZWdO
	MDSbiVBHwmM81bvL9f2AQLFOYNvL1g9EAMvJU5ggqNMFWV9IqEkx8KbjYBleLoQqIDpoFGOMdxb
	pMPv/HCL/OiDgCmapw8gkJGNPJhbocE8SF76CkbNaZ1TVXmEwNvrNg/Ig+O7ns+dR8WjbDKJjI/
	Qa38AjEuJDoeXB1AT/9KkHZutuetf0EWaw2sfzCO9r5WAF1XW3aTe8xW5lt+WKL3MVl2M=
X-Received: by 2002:a05:6a00:a10:b0:835:3949:3c1f with SMTP id d2e1a72fcca58-842b0f52ec3mr26405130b3a.24.1781092627121;
        Wed, 10 Jun 2026 04:57:07 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428288002asm24249042b3a.31.2026.06.10.04.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:57:06 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: iio: adc: KASAN wild-memory-access in complete() on early IRQ
Date: Wed, 10 Jun 2026 20:57:00 +0900
Message-Id: <20260610115700.774689-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

lpc32xx_adc_probe() in drivers/iio/adc/lpc32xx_adc.c and
spear_adc_probe() in drivers/iio/adc/spear_adc.c register their
interrupt handler with devm_request_irq() before they initialize
st->completion with init_completion(). If an interrupt arrives after
devm_request_irq() and before init_completion(), the handler calls
complete() on an uninitialized completion, causing a kernel panic.

The probe path, in lpc32xx_adc_probe():

    iodev = devm_iio_device_alloc(&pdev->dev, sizeof(*st)); /* st kzalloc-zeroed */
    ...
    retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
                              LPC32XXAD_NAME, st);           /* register handler */
    ...
    init_completion(&st->completion);                       /* initialize completion */

spear_adc_probe() has the same ordering: devm_request_irq() for
spear_adc_isr() before init_completion(&st->completion).

Both interrupt handlers, lpc32xx_adc_isr() and spear_adc_isr(), call
complete():

    complete(&st->completion);

If the device raises an interrupt before init_completion() runs,
complete() acquires the uninitialized wait.lock and walks the zeroed
task_list in swake_up_locked(). The zeroed task_list makes list_empty()
return false, so swake_up_locked() dereferences a NULL list entry,
triggering a KASAN wild-memory-access.

Suggested fix: move init_completion(&st->completion) above
devm_request_irq(), so the completion is valid before the handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thanks,
Jaeyoung Chung
