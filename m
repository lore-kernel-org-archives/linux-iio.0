Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C8615E5DC
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779651544; cv=none; b=Htv1qBkBUPD39f3x34xKkwOo/TqmlaxusFncRqYqwvaZGS/QDRctNKLxCLInvw9eIt0XFIg+bux91Boj1EjsBe5f1dbnADeBHG6mPtZsrfxNL8eZp5BLLni3JDw7ou6nImYtBwB/rBDxUbw00OiySIQ6qTxYmuYMsFCZAShKmRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779651544; c=relaxed/simple;
	bh=VSfUQScx7QWLQqMmGGwCCytcYQammq9ExKnodB/hLYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COAIU6bdPw1C2B1DVxxf8Oop+cOl+XCNq6u/jeyGWbB0rrXK6wrkq1cCs5ipV+tTeH/2RqE0bl8dR+N5kCwmcn9QmqAS3w9Ufk/34kUNTw2MrtiL2kzsTPEYH873SKfZxyY0/ZKlIf4MDrgJK9KMb5V4sB0+0AXeLY2w9vV0Hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RABauvP9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RABauvP9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so23114735e9.2
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779651540; x=1780256340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CEDGJFNI0AFFSxtRQsKCVjO7L22n5qBzI1DnBki3h14=;
        b=RABauvP9Bs7wH8pGNVCcARtUDLZ0qLA8FKlXK7f0j5nRId+KkqTr+u+Bc8ZiNvmjZT
         NOkQKpbZDyUc8nn+k8coCaIEKTFIc61rf217JrGbaHMsGg7Ntn6WHLgervv8KJyIY4t/
         8FUbQLx7JHXDSj5SGDJMspKqkaf8riiBID8MdAOrFzO1trmo1jrv3R1C1E55FL317jCn
         r2YXs4Y5eajbR4H5eWdYhsVBrWro7MHUKwBHkccKjhEzd7SZaeDzF4YiBd5PFM8qGsUD
         FU2lhp/aDHIHVUH7dyYIenkD4mFA3htWtBy8+fJo+fkgdpWFiVr9SfMZfLgHBx1wY2jt
         h0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779651540; x=1780256340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CEDGJFNI0AFFSxtRQsKCVjO7L22n5qBzI1DnBki3h14=;
        b=STdlqkyvY922Hn5Cc0Z+WIbX7ECZEWlsNuyvcEXKQryTpPZCKNQCqg/MVBwN2krrsO
         mskTo6tUlFZ/u7jTxctYSx9CdMjsP32Q0ngcvWijqtEXs5n2BItV1lgh3+25rAENsxV/
         VQS1V7MSGV4iBTRBPBMsKP1D+YzC9fFYSvJ/rEHl4upDbQSpyJDqzr7xOFhGWO9GhhgW
         5UoAy8AULcYva5S+8dr+clgKFMUp+mWb7WGjr476YORwv0nPS+4qZAfFQUuXSUdYhypn
         QIvHgECEjhziv9IUsKrO1SssXntsNZCxKdwN8ITnPh8nMkLZK3A5CYK9k/rJsfnQVo5p
         yutA==
X-Forwarded-Encrypted: i=1; AFNElJ8wtBNETNbsui0yZxcaySGcj4qViJH8jeg0ytQ24SQmJ0zjpxKor+hncP378TDsqehgpQH/ohC5llQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytnVhi5UT3uUO/2NWklpfYppMXZk4Vyc0vB0r9M9QyxThNBp4c
	k148qL6Ifv+ixgQq+WFkF6eJxqsjkiCWCOU73ZcmtJ8hRd8hSmWJfTdW
X-Gm-Gg: Acq92OFjXN2Rqhe/hYQu4Efj+lc8+xuivyBY8uGdHJT3yKSQfL/dO2h4+E5V81VAABI
	g3yu8oUwpuTBgT636EWZLOU29RRpV9LP0S6PAI8YFq+/2zlEBSKS41GaEdypRWho2UvZsGsIDrk
	CMU1Z7pzY5C9gNKMNR0J7tXeWFKgKjJrHEaLXF88EsovW1la0h+IiPFFUgP9Gfs/b4vE9oDldyu
	RA/gNVFx6nLLHyNJ5+9MdlXL5R5fVe6PdbgIzYu1nyMLG1ssRtgv57iYo/B3+6IW89aPcYoohwL
	F1htFsmls+I5dYkl4wiUIX3QlIyW2Iu1BVhLJWkUVLG7qZqAMW/De9vyb8LGbPUIuNuBq24Z7XK
	6PuKYjwjvcaALFDxYdSwkKVTu2y+Z1U4FHr1aoCvtljgMS4wwLAIfrrTvjbGthHaxL4mn2yhA9G
	sWYFzI7hpbFV7jVAk=
X-Received: by 2002:a7b:cde1:0:b0:489:1f04:96c3 with SMTP id 5b1f17b1804b1-4904248b137mr118732875e9.2.1779651540266;
        Sun, 24 May 2026 12:39:00 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm22339674f8f.8.2026.05.24.12.38.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:38:58 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v5 0/3] counter: add GPIO-based counter driver
Date: Sun, 24 May 2026 21:38:43 +0200
Message-ID: <20260524193846.19216-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260515153616.157605-1-wafgo01@gmail.com>
References: <20260515153616.157605-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a counter subsystem driver that does quadrature
encoder position tracking with plain GPIO pins and edge interrupts.
Compared to interrupt-cnt.c (pulse-only) it provides full A/B/Index
decoding and exposes the counter sysfs ABI.  Target hardware is
low- to medium-speed rotary encoders on SoCs without a free eQEP /
FTM / etc.  Benchmark rig: github.com/wafgo/qenc-bench.

Changes in v5
-------------

Following William's v4 review the driver and binding are renamed
from "gpio-quadrature-encoder" to "gpio-counter" -- the name now
reflects what the hardware is, not one of its functions.  This
renames the source file, Kconfig symbol, compatible string, binding
file and DT properties (encoder-{a,b}-gpios -> signal-{a,b}-gpios,
encoder-index-gpios -> index-gpios).  Out-of-tree users on v1-v4
will need to update their DTs.

Conor's v4 Acked-by on the binding was dropped because of these
rename changes -- a fresh Ack would be appreciated.

Driver fixes from William's review:
  - X4 decoder rewritten using the 2-bit Gray-code parity trick
    (STATE_CHANGED = pa^pb^ca^cb, DIRECTION via pb^ca) -- no more
    16-entry lookup table.
  - X1_A / X1_B now count on rising-when-forward / falling-when-
    backward in the per-edge ISRs, with the X1 direction caveat
    documented in the source.
  - action_read holds priv->lock while reading function/direction
    and returns from each case directly.
  - ceiling_write no longer touches priv->count (matches intel-qep,
    ti-eqep, stm32-timer-cnt); the >= guard in the update path
    prevents further growth.
  - Dropped the redundant functions_list check in function_write
    and the !!val rewrite in preset_enable_write.

Sashiko AI [1] flagged seven issues on v4, all addressed:
  1. Normalise GPIO reads (a = !!a; b = !!b;) so negative error
     codes from gpiod_get_value() cannot index the state tables.
  2. priv->enabled tracked under priv->lock -- enable_write is
     now idempotent.
  3. preset/ceiling TOCTOU closed by moving the check under
     priv->lock; index ISR clamps after preset load.
  4. probe rejects sleepable GPIOs via gpiod_cansleep().
  5. action_read reports RISING/FALLING based on current direction,
     matching what the ISR counts on.
  6. action_read holds priv->lock (same fix as William's review).
  7. IRQF_NO_AUTOEN replaces irq_set_status_flags(IRQ_NOAUTOEN).

MAINTAINERS: section renamed to "GPIO COUNTER DRIVER" and resorted
alphabetically between "GPIO AGGREGATOR" and "GPIO IR Transmitter".

Thanks to William for the patient review and to the Sashiko bot
for the extra finds.

[1] https://sashiko.dev/#/patchset/20260515153616.157605-1-wafgo01@gmail.com?part=2

Wadim Mueller (3):
  dt-bindings: counter: add gpio-counter binding
  counter: add GPIO-based counter driver
  MAINTAINERS: add entry for GPIO counter driver

 .../bindings/counter/gpio-counter.yaml        |  59 ++
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |  17 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/gpio-counter.c                | 744 ++++++++++++++++++
 5 files changed, 828 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml
 create mode 100644 drivers/counter/gpio-counter.c


base-commit: 3cd8b194bf3428dfa53120fee47e827a7c495815
-- 
2.52.0

