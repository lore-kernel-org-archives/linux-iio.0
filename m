Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535F73346A8
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843172; cv=none; b=akJflVJK0H5LVhHrl6nWNVSuJG7iyit6RcgemirfU5NGW5I/jfv5jnHnMf6AP7xery3n1nMeYJBVQyxj2/HRshqQvZN5IaDvUPKohSngIGTIdFuY+hsvbc2fEdGH9+m3z9AZA/KHzzxKjGKJOnEiYnTVt+jKAnd98rAwBFy4rZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843172; c=relaxed/simple;
	bh=N3cGoSdH3XfdnoUaWzR2MgiyMqqrl+nN6EO3v9JjMOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcSiTYsR7OVuX5udRj9yheAa5QxjzJp2O5bZLJL5rkp4JzR/ckUWow+DfhwaEwGdp3Aw3BpaPqpByP7Onq2bqmi60vsU8VIedOM/D+Ia6mIE4ZOIl0t/OK94uP2U6TxikaXS0uBISHec82PpOeaX2rSVOfFJhLgyA0t/7cFYQNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8nvsBJK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8nvsBJK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47ddf7b09aaso767828f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784843169; x=1785447969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nvjwd+QQTJrIq20v2huRxUmUe5pGFzHXergjGJYa+mM=;
        b=U8nvsBJK1u53QiCLRKdjdJPa/pEPCp4tYgTS62SNNLKZGZipiCx48m9PW6Hf+l995n
         CsqnFV18/fEflJZrUKINHfe2gPVSxXe7+NzQ+DZDxd0s0/qwUBqCEUcBh/HMGcEVHU+2
         DsthLBn7IxCh2b+JGCeF6/Xpz4UC0Jx8ix7C0APyjnZVrDDTjFrD9VkpFBA4gNiNgx7d
         DU/NWOj0B0uI7VTh8aUfidZvojgP2afvRKS33EZNGTugLoI0/sz4DjOPdV1hM9FESvym
         70EHDjOhKAhTDhDEGCF1yJu/8QJpij6xMlbN/j36Kk+AX4Pii7dHAOBI4ULPCXggTgUc
         rSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784843169; x=1785447969;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nvjwd+QQTJrIq20v2huRxUmUe5pGFzHXergjGJYa+mM=;
        b=F5V0by3gu+NMu11K0yT59cGhaggxipxtO0oJnsXRCwcaRAlPQcSvuwrihdbiWuMOmp
         V+V8GP0y6UOxi4VArkx9U7tZos4+KE2A3zrkSV8PPhtEDeC7lG3TyhdV3XLyWc0zLyzH
         5WkHuYmO9JRKVbriVlYQQFgJOS+gB6+19AQ1cIshnZix5UxHvUdBO2FLK+iJRB64ePs9
         zH52+lxGyATKYnn8f54BcOTQFENAtE52bzkAa6eW5AmxYULBQ9pCAgkJBV0GyOSJ5XJL
         Zap7wKhgMtd0x7EXHVLuHJMcQvENM9fzV8WtrvFBWS18YmN6+f71MiYDpBBbmM6DHDBU
         jATQ==
X-Forwarded-Encrypted: i=1; AHgh+RrB0iZuxFVKLl85OQwnbGlWdyPpRyapXKtLMoVET3VX9GLXErBoZM16089/BYp0L1HwyGBG2B0/9Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVx4Reoretm70rlqeO2+zLwJbGgOI2drbnxy7W07LG4bV0v33A
	UhXSbwLUQWtEnUEGvf5WWBGSEkRYQb97gdJEIG7nXS5kXamhTMOi2sql
X-Gm-Gg: AR+sD12gmOuoXazMJAAWU+WpAAZCWmTaGpxjkd1OXwV9MOX6miz6Gfv+Zgaw32X8qqF
	XPq0A3DPq5xQBa8+up2GCWl5vjwsEhrYHiyRpZc+mAGebXLI0mHnxDNBGQGREWq3sfRzrxoT/0Y
	boU3l48UPtuwtiWI1cPuFQIT+o/dGw4pjux64D6/mVNa3953uafpkU9ThaW0kQspZmdgtijepZz
	vIy9yepxj1nqlH3vl2olXc1FgeiffIpLa08kSCTeLUYHaPDFiZhNZRv7lFoIyLRUifX+pWIHF7r
	DRIfgiY+C2AkEw2E6iH1ZUjKP/SgoYwy2kljSlWqlps6j5VcGJKhCUpwYM/QxX80n3fFhGx6SqJ
	bz+3IAL35ewypRfBMZURXtJbnZmHG7DD3cOL32zEpdx7EsMvQKEefZ7FvRsYN8XBKhz/+l1zTGd
	QL+qi+518YAmR4Mq316Z6WPCtpawLR1Lh/9D/HUFWRxBixWyUg7iRgC7yqS2okM+7mDm69FLYcS
	CN+TlUa5wBCzzzaEyE+4IDzKP86q1gYJc8+8Qz9FXBPbdJRZCZlfJ+Z3IITi59aFHYZ8MkJ+UYT
	xmfGZtVQuUzMJyzOD4rzH6BCSnkuLdmpq4DO9SWsaZM2CjThjS8un8syd5aZrkRlvlmS+URMuq3
	y6u6bs8LOfPcI7LjKFrq3Ow==
X-Received: by 2002:a05:6000:2c0d:b0:47d:fc23:abe8 with SMTP id ffacd0b85a97d-47f8d755388mr6206915f8f.28.1784843169422;
        Thu, 23 Jul 2026 14:46:09 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6e9a2sm18919144f8f.35.2026.07.23.14.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:46:09 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:46:07 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Jonathan Cameron <jic23@kernel.org>, Linus
 Walleij <linusw@kernel.org>, cocci@inria.fr, Andy Shevchenko
 <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH 15/36] iio: remove conditional return with no effect
Message-ID: <20260723234607.52b67523@systembl0wer>
In-Reply-To: <20260723184538.3888637-16-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
	<20260723184538.3888637-16-ekffu200098@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 03:45:17 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---

Good idea adding a cocci script for this!

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
