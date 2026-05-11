Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695EF24DD17
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497812; cv=pass; b=cbpbDu+chhjD1qc/w0yuIjFy3S81xvjQYxj6u/9+/+dC7mQKsdr3JANzQOi3MFgICO7kepjrLWa6FJ2JNXNxRfzWVT+7jDiqR+2gtLTvmNs1U8av9Hfhw9zsVdTURGlpt/aXJiY9luCFxnsIukdNJAhW1Nzc5SdUwXcJ/XEGifs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497812; c=relaxed/simple;
	bh=d2PAdyoy3aQgj3PYWIAbCUVN3BpTqzgMskFFpYLapFU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VzRko4s91om/W3sGgdmWCI59Ys4RuKDz/2H9uPwaL32cQB/GLyqq/9NQbCzhdUgJmmTtfVkSDjJvvEumessL3HoDYFDbPWxu7cOMqGFNN9xcmYY4MY+IoZoii9vruJ7AmSLWMO1ZOyIMU4FgFgO5daCV8o/e1ZoifPMPcGQ/Pgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sntGp2YS; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sntGp2YS"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-44985f4ab0fso2356993f8f.0
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 04:10:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778497810; cv=none;
        d=google.com; s=arc-20240605;
        b=RJzLJBmSo6kQq849TTzCpB1urOcBYYdLbhS2pwt43tAfthHZQtbKX0HnwMDzJG/6wh
         uwLCIM1m/It/0A4/gIHnY8H90GNhRWVuYcSyj9AM+s8Pw1GPf7106GznOMbU8qUxukDI
         KINgAoYmILx3evjxVruTrk89je6/HPX2k2frSNnyTUASFkCet4fCwQYerBNXjjYfM6zw
         Cexn4gcR2Z76zYzLGwSkZouDcr5KqiMDWpIEuo/YQqbcpHesq/BRH4oBlaSG7h53NSde
         brNI9qV1aWVdZmQzy0fV3iQq87B/kPYbAg46XluuwweUJEN9gmMYXXkYR/u7LCFz3vK6
         2Ggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+qaAwFuBgU/GnegLS5+KLawgrr7ik6No/cnt7fQGgOA=;
        fh=rdFdnKnt8R5AYZcRHUuOjOAMTki3LT2sQCac/F0UpaY=;
        b=NArjki2ZnjWgqHvqe/zwEsrYle1KcTgXaCGexKxaybhb95uppZQBiW4JfPOHzOZcXL
         MnVLqgVd08QYfkunQMmaoOXIizPyn0wqUCF58r8PqoWz+KWKeczxGqWgVwqDNlmq173K
         qm4iQHafUJuvKY2sjxaqB7Z19Fqf5/YKikRa7hho059OaP+Ln96/Ij+3NTe2u+LG/aaD
         7o1jbxzSHgoSKcVLROmWn6GkCf4Gf9hZw01OEp03kv9RuVP2WfVZnvV980nGcY5S5GbR
         YPvUrqE+W+gJcekcg60oots5r0y6HaiYb0sBZlrWfubnOV8T5VRjSZ7Yt42J6s5DDj33
         spsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778497810; x=1779102610; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+qaAwFuBgU/GnegLS5+KLawgrr7ik6No/cnt7fQGgOA=;
        b=sntGp2YSPbEzpy0OLE+Y6MPNnZn8ylQ/WgPU09LnvxeIoS/QxNIlNO1BA+ulw7f/Pz
         X/DQ+nqgWq3S5vN46UnYWasNkr1i9/fJJ/s08G5mnPrxnEBGPv46GH626KTNhfgi5gvJ
         M9weXfbL2+5fSY43cghwfK4Ij9MxU8ffIyT9jXIDg4ssGKNXqUw2NVZn0ElCu+5s5Vke
         GEzIoyJTsmWmUfO8X9suFEaLK8leQj6WMyq0U/COAOxeHrSNy4CGqTzvQgHVD/InlByS
         8ly2MU0N0Zs8MMtR0Yg+miqmk6wQqsX6NW/1OFUcfb7N+g9ILl2UCH2PeWpzqvFOhiqt
         4vQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778497810; x=1779102610;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qaAwFuBgU/GnegLS5+KLawgrr7ik6No/cnt7fQGgOA=;
        b=RCMXZzFVQlicYq0osUqMBfzxL6AiW4lk5e1Kc5PEbBgbTdJj33epODk/c3hJO5F5Pg
         bhe+SyJQJWxVw0ApaqSs137RSxw827WRyyKt9FCwEyhYYlkjhh3BBxqiRU3fczZfRR2g
         ksKhfIR4VP27Xm6R8O/hm5klT4AwEqvtD/SAvzKgkb2DdbXGjbK6uMlc/+YEAjoJPP5B
         kdHcDP0DTzM+Uu3lrMmqjwWDz72rCchYjt5Y07Y4IdFkkss8NtGNQsrYhx/LqzSHTzI9
         QlyioVQBaonb2uHmoR9r/GjEEbJ+scr9mhGeo+L8KqpmatT2OuQYmKnaDCFlPZX1Q1hh
         Dqbw==
X-Forwarded-Encrypted: i=1; AFNElJ9wFOpI4cUwI+hlR8KlYVDJxP1189vNqAt06N6OQMx62GQNukhAMNyZjY9+pKPODyqerKUs6yhmJJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVNVuuXVjULM/5c4LIZta3OJd/VwVPVvYwv4twZpXSyAximRh2
	ODBLe1BfS0KvQNV+Q5/3kWCbewYnTev5hHe9cS7kKXfQ9h6h75Vy2Qy6PrKit+LTLXaQb4nSBz2
	XZuNaS4wvwbMWSGyNOa/GBgWI81/YClM=
X-Gm-Gg: Acq92OHFSY2R7sJdt329/72I7v9/wA7I73l1Go/94AOoJILSh1s+OeeqNckfj4PNWGB
	yvnxSCNGjzQBPfRHeTBYOX3Nl5zH6trFMovPcQU0ZW0kF+uyq4WtowCvzF+tTpFaQ7km4DUhDC3
	b4tSOOmjDPMsswrlbRqoAgXRsgxxMaJcxJAuR+xHPmGYauPx9tC9DxClR/myD2NLX3kBnZr1JM7
	LyL54YYAGzkwKdow92I65mnkEuPnAeCS7A0ILqJJZU2DutpO/ITYHPXzBOfp32uKWkhdrvMhOGX
	uyluaiRT1sD3tviBgo/M5KbOswi8Z+IvYL25BmLRCeeYOT76sVGrU99JjNfunr1eZhHykQLbNu6
	UhxwFfGYnaB+C+ARRiLKYBC3HvK3k746gO+nD4GA6sGHMV/hbbhdOm8ULmk0tqtEZBdnHy6JN53
	9Ff6cGIZAYrmx/onLK
X-Received: by 2002:a05:6000:22c4:b0:44f:d9da:2c40 with SMTP id
 ffacd0b85a97d-4515cf125d1mr37234227f8f.21.1778497809765; Mon, 11 May 2026
 04:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
 <20260511-opt3001-cleanup-v1-4-f7879dc3455c@gmail.com> <agG4bt8mboTd6N_g@ashevche-desk.local>
In-Reply-To: <agG4bt8mboTd6N_g@ashevche-desk.local>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 11 May 2026 13:09:58 +0200
X-Gm-Features: AVHnY4IBLz1-V4qAgVz-IcOqzia4aNEeK8VfWSoRb6kMD6OJWUnYBMVtwcADGI8
Message-ID: <CALoEA-xAK+GyJr1umC=RtKvrv9qcsvRsTmxrbeU7s+Dxe5DCHw@mail.gmail.com>
Subject: Re: [PATCH 4/7] iio: light: opt3001: move driver to guard(mutex)() use
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 May 2026 at 13:07, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Mon, May 11, 2026 at 12:04:09PM +0200, Joshua Crofts via B4 Relay wrote:
>
> > Move driver to use guard(mutex)() macro, to facilitate automatic
> > locking/unlocking of resources. This modernizes the driver and
> > improves code style.
>
> This one LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>
> ...
>
> Side note for the additional patch, in case you want to address that.
>
> >               dev_err(opt->dev, "failed to read register %02x\n",
> >                               OPT3001_CONFIGURATION);
>
> Broken indentation.
>
> ...
>
> >       ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_CONFIGURATION,
> >                       reg);
>
> Ditto.
>
> ...
>
> >               dev_err(opt->dev, "failed to write register %02x\n",
> >                               OPT3001_CONFIGURATION);
>
> Ditto.
>
> ...
>
> There may be more, I haven't checked, but maybe we want to clean this up as
> well at some point.

There are about 30 errors when running checkpatch with the --strict flag haha,
I wanted to address it in another series, but I guess I can do it now
(only annoying
thing is that there will be lines longer than 80 characters).

-- 
Kind regards

CJD
