Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C73F1AA8
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017039; cv=none; b=cJAu6kNmCOF7831AY4MEiN9E9AqPF9foaS3UtJzYQ8EWNG5zzQLUB2TGvxMyfzDjEt5M4+hY1yzQRNeIWncDIUpCZHbgmpHvyr2fyg48nRic3uFhxaXxCZGAi+JPiXC/AgX3gy7SVvioBny5st3ht3tSpMobjE0S2JQ6YNooBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017039; c=relaxed/simple;
	bh=2jerD9lp0NqmFadJflPzVzFJZXVG6Vk0wzFQvxAJI1I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hD0DdQzNg5A7jZbFwFgt9T18WNbXA6g63/DJdd8C+XGrTTqktG+uV3iO7NBB+yOm4lPT7Njwo4ZJNIQgvPOJkiH2S7X+P/eThKrDMb6gqxDhRuvzYR1T2dwGnigjhJE0j6TRbNsBZoshU+FZRw5Uua+KPd82DVE6+ogtWlBUP1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DR6MD1YZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DR6MD1YZ"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6974a6e54dbso924791a12.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784017030; x=1784621830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d3Jk1bl127PhKyfuEwshrZ5NXnlXbFwCFha2daTO4m0=;
        b=DR6MD1YZdoWG8DBaywLt0KxG4YNXtHqPmjv16NnXLkKmHitC6DHJawdUvGEM9chVmA
         F041h4q7EwwZzVy3yp7tutxGUxfpKUxLEkybX0BiUOtI+fxUuvYk+0RWbytUH3RQE5nx
         9tTVnM5kStOLH7VyQcsAH1ulBBGEXfHyHpA2ub9zZsUaMdGB+oLoNdBB3AYqZuJ07LZ8
         p3fzujkAGHPWYreiiUeJxRFVuTpWniMK1qn5bMCx0N4is1WU6aQjb7SBYC9QN3+l84oW
         a8qwjEa8TplNA9qkMfbcytlN/vCLCbA+qdpRUwDz54+kGwXsIipJTfNmNww9o6gWJMiv
         5IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784017030; x=1784621830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d3Jk1bl127PhKyfuEwshrZ5NXnlXbFwCFha2daTO4m0=;
        b=guFDXKOoBbh7hBiSzj5x4CPRETaSC5/vcPsG70QAaHirPsGcCCvBuusqL5wu/aDu32
         aNv6K6qIXz7gd+OSyFwBuCn+oIVnfjxDNIaQbXMvT1Bv360ij3r+oopBfsgmP4VPv1hw
         0d1oCQ1SLKBj9hf3kEua0Hrk7Lbx+oGy9pL6plOtr5mN3vpnshsy+1dV5axEVqDQoKK1
         mAJK82Yc+5boWvsCfFXna4lB9CtFR5W0GKM02Mr7eDtfLBpPUaxenBOayz8pVJdx40G/
         OLjRxbbYbGujOY5AxKW5Ce2mKYD/F/T0zlzcq0qaY0tFrdzo+fuXICuZTY1eRvgiteFk
         VaEw==
X-Forwarded-Encrypted: i=1; AHgh+Rr+z0jPAI1+VIPyuCK9BPK53Wwe6FCROeVhrL6CcpKgulMc0Y8gBet0waWvyJS/qeh56yvundHoJew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZHJQQPJSac2L6Fqat7qTQzXLAJlQ6nt+xJyG0hRsdi391mcZB
	EYqiiKtxGzQbL/rWjtjZeM5HPSksOK01F1aKO8EC/7ogGvu6kxgnr+F3
X-Gm-Gg: AfdE7cnQQdAeXoY/K/RDnMNJ65obXSJRtMfvCacOeYlSG8dvT0Ir5oHqspCTkkYn5Nh
	HmxHVlsfsAcsmWpAugG9kAiSoFgRI7txYK/4wlk/5+C7xkGcgcF9wjTD3z1ENFTQVowC4GdF7tg
	KP45FGFIB1tpE18YCYM0TYXFMYiOxX56X36Xrq8Nx9DmNHgvXaBcQOPa720Wd/C0wm29icxoSqz
	Qr6icVT9uf7wBxGBIkticSAjBYk32ZbypRuZvTlsa24d8hADr4ssFLbsbYOzKcEWE/aZDCogE7c
	QFVaeJH6r1ELEWejpUOEPva7LmISC21gAV7oH9ZfeQGPH+4xGAN5xwyIiP5nXdcoGmXgX2SmuY1
	mX8B2eIO527y+Y/DmA1LnjocEwAgk7SDwiwhc8cRHXnqIpA5zwS1Hx1AQ8kZvq0XfloVy5pvC+D
	cXaYyKohqAg43rm4F62/JmOfVpy0DIMGxm7ZmnH8gk5KkxnA==
X-Received: by 2002:a17:907:a4a:b0:c12:b227:614b with SMTP id a640c23a62f3a-c161ea6a243mr573738866b.27.1784017029849;
        Tue, 14 Jul 2026 01:17:09 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15e353d2f8sm723085166b.34.2026.07.14.01.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:17:09 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] counter: add GPIO-based counter driver
Date: Tue, 14 Jul 2026 10:17:06 +0200
Message-ID: <20260714081709.17846-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
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

v7 addresses Williams review comments on v6 [1]. Main change is the
reworked index GPIO handling, rest is smaller stuff.

Tested in quadrature x4 mode (both directions) on a AM642 board with
a real encoder on GPIOs.

== Changes in v7 ==

Driver:
  - check the enabled state in the ISRs before reading the GPIOs.
    This also moves the reads under the spinlock, so concurrent A/B
    ISRs cant evaluate the state out of order anymore.
  - dropped the spinlock from the simple single-field read callbacks
  - smaller cleanups from the review (b_irq_users increment split
    from the zero check, current_state variable gone, ternary in
    index_pulse, GPIO_COUNTER_NUM_COUNTS_MAX rename,
    GPIO_COUNTER_MAX_INDEX removed)
  - index GPIOs now live per Count (idx_gpio/idx_irq/has_index in
    gpio_counter_count_priv), the n_idx based arrays are gone
  - enable_write: dont resample prev_a/prev_b when Count 2 gets
    enabled, that would corrupt the quadrature state of an already
    running Count 1. Also sync the direction from the current B level
    on enable in pulse-direction mode, otherwise the counter steps in
    the wrong direction until the next B edge if B moved while
    disabled (both reported by the Sashiko review on v6).

Regarding the IRQ enable ordering question from the review: I kept
setting cp->enabled = true before enable_irq(). The prev sampling and
the enabled flag are done atomic under the lock, so the first edge
after enable_irq() sees consistent state. With the other order there
is a window where an edge fires and gets droped.

Binding:
  - index-gpios (array, position selects the Count) is replaced by
    two seperate properties index1-gpios and index2-gpios, matching
    the signal-a-gpios/signal-b-gpios naming. So Count 2 can have an
    index line without a dummy entry for Count 1.
  - dropped Conors Ack [2] because of the binding change, a fresh
    one would be appreciated

The 2D synapse array preparation for a future pulse-direction mode
on Count 2 is not part of this revision, that was flagged as
follow-up material.

[1] https://lore.kernel.org/all/20260707104501.977372-1-wbg@kernel.org/
[2] https://lore.kernel.org/all/20260629-trekker-estranged-754e9bfada16@spud/

Wadim Mueller (3):
  dt-bindings: counter: add gpio-counter binding
  counter: add GPIO-based counter driver
  MAINTAINERS: add entry for GPIO counter driver

 .../bindings/counter/gpio-counter.yaml        |   60 +
 MAINTAINERS                                   |    7 +
 drivers/counter/Kconfig                       |   17 +
 drivers/counter/Makefile                      |    1 +
 drivers/counter/gpio-counter.c                | 1011 +++++++++++++++++
 5 files changed, 1096 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/counter/gpio-counter.yaml
 create mode 100644 drivers/counter/gpio-counter.c

base-commit: 3cd8b194bf3428dfa53120fee47e827a7c495815
-- 
2.43.0

