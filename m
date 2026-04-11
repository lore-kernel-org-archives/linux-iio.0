Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328493346A0
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775899851; cv=pass; b=HaDDtsYXesESQheylKTLwf35ZkZ2kSGWM9GLaDTsmQRTGLxEcL0lA0qEGw0bFfvpQlfPb+FPHmz2Y8n9NF0O3PU4K+h/wedhdqGBzHVuzzIY7yRMRhrto54j6nJXIzmdjG9oixTz9+sNMhvBYJBB4V+yD2J6udNlr6Dpr0KuaIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775899851; c=relaxed/simple;
	bh=cXKSu8prgsxZ7y3532Cei9WNm8Ushqsy6GopGdEKFM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LNSuudUi8F9cEhK5sMz1S2g6UfM4M2lt/M9qSZ5PkJIYRbpKR8d19zsSCqHagKanFJO4pfkKQkoBVqEa4XoM1X0TtVvgn0vg+5GkuxlyJFH3hyXTjPW7pcy/e6SelSkecMPezWMsZRpw7D0JGEOF1vEfn8PE0kyw/A9Dgo/wxr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LK4gK+37; arc=pass smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LK4gK+37"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7927261a3acso27837207b3.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 02:30:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775899848; cv=none;
        d=google.com; s=arc-20240605;
        b=YsMZYLCfr34vB5uDkCh+sYKtZaV3VX6S7Z7CLmqsM/W1MCCUrnSPYxoX97GZkr1SIs
         MffkEmCSqsFA0VXMUfV4Cut/07fCwSIZFcnEJjj6FoY4w0dj/CkfITbPlw0q9TKuR9kK
         oaS0gHrOjrBZWkQzoUAHMGlknvajv5fWRsSBJJda32I/RZiXzbj2qUf3I3uBTV79DaDy
         50iIHWBjs9xHZNe8MF5sC2F7y0twOwt7Y5dBC+ZES4K1ZK8KvS7NyYgbdQm0QZHEmcUw
         8c6OBPRDV4Lwm9OMIjxYO+w1TWXY3vzARh02LqAS6r9td037Gl3nbNWwlZ62iVDEdXQ6
         SEbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iN2MFAihUm9pub9DergW5aGrGxNQSBEtqfIR07hdE9Y=;
        fh=e/7Xu5j3N7g0INo/U2RWswoM0fyFPD4C2hUNMJ9gV7Y=;
        b=TE81G6K9IaNFNFFXXqX8d4YsjPprwiR/iLBH5ZS575DszTGfe+9yRW7DNSOwHYL4I2
         ZLWYRmfOHeynJn1TAYhTdwl4/ayhoaJ/7qzYZFmH1Hz9lacD7Pm9GGwUetx1Tn0VGTvM
         EUbNkcarRXjlNWC95KwJ9x5lrTeGbCKrDBzGewB/JOh2u7LCKckhdk9BVdM99VOZqNOG
         BN3FV+UTzS31mpKMCJih2gyMhbvXlOln79RaldOTSb6c6jxUt7Cyrk4PUUM3Tf0v1M7U
         KiMvcF1ttGHaOnLJ9KIUyfxvFrG6/vjhDEkB21vuO4gXphKyph8a2llt/nDzSQe6p/cd
         iGTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775899848; x=1776504648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iN2MFAihUm9pub9DergW5aGrGxNQSBEtqfIR07hdE9Y=;
        b=LK4gK+37mea3KWvKKsx9KX9lJGDt5QvfMiRy1WP+KGKHZFA6ah8VSd182mJCRfWI8u
         BvLi/V5Oo74ZEFQzzChtXgh8AfmH9Xlii258Xf4arQfhrWPDJPuPsbuv+MlZy9ZpMB34
         Ybz3zhhmBNgPWi/g4n4LdDZ9EkVn26dikvl38kg7GlH/skamBXf9qwWyHy2jl6HrRm7y
         nR3ZXX2oYRASUBkrKhKtRkRBj+qAbZVrFYtY4CTTPPIODxKYBbE5ueDk3ZNLD58Nrv9+
         pbI7E41oG51nibf5bHdLyTLFlYU5pTfB6uUkV6eg7sGspN6USdIopQYedUib6DF9llfK
         eAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775899848; x=1776504648;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iN2MFAihUm9pub9DergW5aGrGxNQSBEtqfIR07hdE9Y=;
        b=F7Kk8J5itxHnfRnrBa83EOxYJKt/KrF6aji7XfyzNeO0fxK6RZClnK7tV+bZqXZoCt
         Yxtj2VZjCyzeB8Fj8ZAkeAcsb7h6Q9SZlj4MCM6U6C6NQjTiCnaphCyS71yK9wwMTkPh
         37DdTINy9ephq7KXVFeeX8wchv60ba0WtI9UWAuA/P/OtfzanY44gPpi+Y/UXe0ywA1d
         Tx/TwUWaWRR2WBFhcDlxHq1aMo409RMRzIjjNsx/PCcJvUqYKqDHThSj2JhGI90EE3N7
         wzDEUTfg12bqBX7T8rcdWvENnZF/fXyniSIGgc7FKFkVRpE0cGzyZ8O4E5qJBaxfR/9i
         gRYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9rSIdUmxutYrWjR5TH85CtMI4xZ+lp3i4kZic0e4s8LBdQ3oV+PBiDr4YM/QYwvwq/zkaCf7R1BDU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy+nCD02U+SVzG+AVE2Y+WNyz4CVclyaPNItKGqkQ2dsNwiSfm
	vl90zIduPlCsrg9EBovaZgcIz375NvEEm6NQhdaOLcSfcb7fPz2l3Klx5BBakT8xKCV5ivoGd93
	wYuRWqGsAXPsqC9Qe3PagjjFrZBFsGf0=
X-Gm-Gg: AeBDiesLJ4u6xX5Xi3q0zsfLVrIHRyxsZ0oOwCKXdh6y6biv8QMZfy6yadkhaYVJOaD
	ebVIbDr6KoYsBfAkmP+gEfzsiLGWgHezrmUGhQqbvTxwrNustPIAKkcnaqSLhqV/1o8PDcleirE
	Woub0Y25AL397D+tS8aVmtRsSDO3mZpgD6Z1NQZyCbhpwTtBV69FUtVjFsxEm+NYblQSbh77p3q
	3HLfuaa7IUQpzfcsL6PPAg2iU6DDlW/SvFWm4H58beMTv+Nxa5nABa0auMJfiaG6YX+ovgceywv
	CLBsSmk=
X-Received: by 2002:a05:690c:768f:b0:79b:deb2:f5e2 with SMTP id
 00721157ae682-7af6ee49711mr58014857b3.11.1775899847966; Sat, 11 Apr 2026
 02:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411080435.2125626-1-lgs201920130244@gmail.com> <adoEfbDRO_ZsIUx6@stanley.mountain>
In-Reply-To: <adoEfbDRO_ZsIUx6@stanley.mountain>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 11 Apr 2026 17:30:36 +0800
X-Gm-Features: AQROBzDz53mV2WKlgnrPeDto-2h3oj2JZDFfc_Y9BjGEHLf9CUWBJA3INxTEoPs
Message-ID: <CANUHTR-CY2WdPqdheQHHsFqj=y88zs3iiVn=5rE6gh9mRmsong@mail.gmail.com>
Subject: Re: [PATCH] iio: trigger: Fix refcount leak in viio_trigger_alloc()
 error path
To: Dan Carpenter <error27@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

Thank you very much for your review and for pointing this out.

The kernel version on our side is `v6.19-rc8-214-ge7aa57247700`. For
clarity, below is the full `viio_trigger_alloc()` function in our
tree:

```c
struct iio_trigger *viio_trigger_alloc(struct device *parent,
       struct module *this_mod,
       const char *fmt,
       va_list vargs)
{
struct iio_trigger *trig;
int i;

trig = kzalloc(sizeof(*trig), GFP_KERNEL);
if (!trig)
return NULL;

trig->dev.parent = parent;
trig->dev.type = &iio_trig_type;
trig->dev.bus = &iio_bus_type;
device_initialize(&trig->dev);
INIT_WORK(&trig->reenable_work, iio_reenable_work_fn);

mutex_init(&trig->pool_lock);
trig->subirq_base = irq_alloc_descs(-1, 0,
    CONFIG_IIO_CONSUMERS_PER_TRIGGER,
    0);
if (trig->subirq_base < 0)
goto free_trig;

trig->name = kvasprintf(GFP_KERNEL, fmt, vargs);
if (trig->name == NULL)
goto free_descs;

INIT_LIST_HEAD(&trig->list);

trig->owner = this_mod;

trig->subirq_chip.name = trig->name;
trig->subirq_chip.irq_mask = &iio_trig_subirqmask;
trig->subirq_chip.irq_unmask = &iio_trig_subirqunmask;
for (i = 0; i < CONFIG_IIO_CONSUMERS_PER_TRIGGER; i++) {
irq_set_chip(trig->subirq_base + i, &trig->subirq_chip);
irq_set_handler(trig->subirq_base + i, &handle_simple_irq);
irq_modify_status(trig->subirq_base + i,
  IRQ_NOREQUEST | IRQ_NOAUTOEN, IRQ_NOPROBE);
}

return trig;

free_descs:
irq_free_descs(trig->subirq_base, CONFIG_IIO_CONSUMERS_PER_TRIGGER);
free_trig:
kfree(trig);
return NULL;
}
```

So in this version, both error paths are reached after `device_initialize()`.

That was why I thought `put_device(&trig->dev)` would be more
appropriate here than freeing `trig` directly with `kfree()`.

Also, since `irq_alloc_descs()` can return a negative error code, I
thought changing the release-side check to `trig->subirq_base >= 0`
was needed as well.

I may be missing something here, so I would very much appreciate any
correction if my understanding is off.

Best regards,
Guangshuo
