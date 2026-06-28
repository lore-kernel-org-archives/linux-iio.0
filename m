Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354C0364045
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 21:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782680575; cv=none; b=KuNmHjv3o/2WukhwdMprO8+0Xz75YE1k44inZexHItpgI0KK7MqDrlBt2SOMMK8LvvKwiPywvaNZJ6QgtVergdiOfhfcFadzoPwn+BuhGrhGXJ7OAQYVVgEAxCzIuX70Y7OJj1K6hNjh/8HT+Yf43Yt8jkSt7zqqKT7G0/Bn5k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782680575; c=relaxed/simple;
	bh=ZDPsWmwXD2dOb/MsrbNbzt8kYng76STy90w28jpNGkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MGEOfQsRluJJMTdJfmjW3igvfTRdlgvvJPffHnSafX5OG0+Fyja6to6RoVC/cmQBjecyRQ/mGH0zBmOKyrKCqW3x98jTt+oEW9jZDRmqxPHvgb694I04wzIcXKX3IC94uwMbYqNxi4nAEjbnqZ2WDBhdPL3Bs3AmWs4TthcW9tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSqlt9P9; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSqlt9P9"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so4594268a12.3
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 14:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782680572; x=1783285372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=geX/7Dwx4QSAMTBDt1s9/g30v9NQSBsduKeMF7ycvVs=;
        b=RSqlt9P9LvU8IMJ22cd4dxwHHDTW1/4K9d9Lk2FoaISjgRjtfmFUmN0KzpcBFH5oN1
         8j5ew9IHZbtT8a7Ar2SDLOA7xZ6o9w84ahst1C/fE8Xb3DQRv3m0hl8sUcqjt1qOEjgt
         KWoUNP11jVYDWJeU4g1dqcNptvS12WAEOSDTreWnymAQHDJ5QcFT68J2Vws1DIgppcxE
         x97QNbic/D1dF9SbDogm2VULJ6boeu3eUzCiCNs775WxrAbglhXElAo6rTO6fsmnxP5M
         bTFUqMZE4x+ZF5cejtzR00WwTW8uDoKt8Q5HrJq3iAHVrQghdceXsc6rurg1tMe/AhmS
         0aGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782680572; x=1783285372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=geX/7Dwx4QSAMTBDt1s9/g30v9NQSBsduKeMF7ycvVs=;
        b=ilO9KLt5dmCJh8wrAqL7Vm/WxThfI7lblQIRcFnkC8m6emEhT/PaH93v05egixywbE
         7u9q+nxQfQ6ON5/m0nzWR72DaTGi/6Uf1dLg0bT3xtjJkcTwMrAnTlJ5x59JeOb8PVqI
         +W0rpEHFhL4VbpUhS6EsLyAnonjeShXa9Rc4jhpe4KmoXhUvky5FFjEtS2Q8QGONcAWx
         oieuYBwxaqZDT3Q5Mg96gp8vwxsy1DG90dma64+xpjRgw1jLEgzdyyym2wPgGJ6a4jW4
         R/+MKoJj0i1EBavIKsKcJmuqIh4gKvRj/Y0DehQPO9uX/mC0Be0Q8hg7eA0He9AiuD4M
         rZ6A==
X-Forwarded-Encrypted: i=1; AHgh+Ro4mzaGUwG95a2bMLBp2G0mbh/K3FAaxqqMTuZ9M+3Bf/LrAz5wzl57OSxzfL8TCd2OpcIdoUvO1Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh+4AWk0PS0cpMAmfz7MhWZMW0uzLInzwplaiwxXHuGGI+uIB/
	la3o46Rdqc3XG+UA+r7zXqoVD6gogEStrZMXAV6Keux4L5F0Tt/tfBrb
X-Gm-Gg: AfdE7cm0fmj59UTYW1lHRSny6zPHROPt8CRntwtte+G3e9rwUF6WOnBMJYaWsryaoM2
	aGxtVCerqe6BevExqo31z9hkxXMrXDCqSJbhRmonwAtNPFZL5Gs2jVM/+RUP1AbiHRtQVkbHURq
	vTVwVGE56NUDMHOPO+uD4ApqzBYLQnlOaoeoDL6rRr2KHyRE43wFadnTwFpAwmT9mAQdVg8Bn3P
	v8ypV6wkpQG3cnCvsdouvAEoVUlaGoGVE3a3QA1PItcweGEDkosqyd15xt+EXmXxxWQ+uxCkozA
	8Lc7KRXhhzwwg/qzTtqTCw+Kmgxhi96U8trSwgLL+OcA3ksOyl293vG2m8aQdkBqXEAiqYMP4zJ
	OwVZCmfXKnQvynClqwmafQJWj5iCDlQZ74zTcOunTUpVycyYzc9EQ33oXUuo9OlXqaO0eKQ==
X-Received: by 2002:a05:6402:540a:b0:697:bd1d:116d with SMTP id 4fb4d7f45d1cf-69810af0831mr4974930a12.27.1782680572387;
        Sun, 28 Jun 2026 14:02:52 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69848e5ebc0sm2205656a12.3.2026.06.28.14.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 14:02:51 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: wbg@kernel.org
Cc: krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	o.rempel@pengutronix.de,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>,
	kernel@pengutronix.de
Subject: [PATCH v6 0/3] counter: add GPIO-based counter driver
Date: Sun, 28 Jun 2026 23:02:38 +0200
Message-ID: <20260628210241.119825-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
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

Following William's v5 review [1][2] the driver now exposes two
Counts on the same wires:

  Count 1: Synapses on A and B (+ optional Index 1). Supports
           QUADRATURE_X1_{A,B} / X2_{A,B} / X4, PULSE_DIRECTION,
           INCREASE and DECREASE.
  Count 2: Synapse on B (+ optional Index 2). INCREASE / DECREASE.

== Changes in v6 ==

Driver:
  - Two-Count layout with per-Count state struct
    (gpio_counter_count_priv) so future per-Count features can
    be added without parallel arrays.
  - ISR rewrite: STATE_CHANGED check used in all quadrature modes
    (not only X4); the *_delta helpers are gone.
  - INCREASE / DECREASE now count on both edges of their input
    (A for Count 1, B for Count 2).
  - PULSE_DIRECTION: direction is sampled in the B-ISR, the A-ISR
    only steps the value.
  - direction is initialised in function_write so the first read
    after a mode switch returns a defined value.
  - enable_write: added enable_lock mutex and reordered the
    enable/disable sequence so the spinlock is dropped before
    disable_irq() (which can sleep). irq_b is shared by Count 1
    and Count 2, so it is refcounted; the per-Count irqs (A,
    Index 1, Index 2) are toggled directly.

Binding:
  - index-gpios takes 1..2 entries: Index for Count 1, optional
    Index for Count 2.
  - Description and Counts wording updated for the two-Count
    layout.
  - signal-b stays required.  The single-line case is already
    covered by interrupt-cnt.  Oleksij suggested [3] extending
    interrupt-cnt with a multi-line variant; I kept this as its
    own driver because the Generic Counter ABI (Counts /
    Synapses / Signals, ceiling, preset, action) does not fit
    interrupt-cnt's pulse hot path well.
  - Conor's v5 Acked-by [4] is dropped because of the binding
    changes -- a fresh Ack would be appreciated.

[1] https://lore.kernel.org/all/20260617074929.333876-1-wbg@kernel.org/
[2] https://lore.kernel.org/all/20260623053800.120909-1-wbg@kernel.org/
[3] https://lore.kernel.org/all/ajoXoYc1CYKZyQ5l@pengutronix.de/
[4] https://lore.kernel.org/all/20260525-register-bogus-b198545b69a8@spud/

Wadim Mueller (3):
  dt-bindings: counter: add gpio-counter binding
  counter: add GPIO-based counter driver
  MAINTAINERS: add entry for GPIO counter driver

 .../bindings/counter/gpio-counter.yaml        |  59 ++
 MAINTAINERS                                   |   7 +
 drivers/counter/Kconfig                       |  17 +
 drivers/counter/Makefile                      |   1 +
 drivers/counter/gpio-counter.c                | 983 ++++++++++++++++++
 5 files changed, 1067 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml
 create mode 100644 drivers/counter/gpio-counter.c


base-commit: 3cd8b194bf3428dfa53120fee47e827a7c495815
-- 
2.52.0

