Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0182F1FEF
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 22:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327480; cv=pass; b=NeJe8qWqMAdLmr7NHPxdI0B3Y05hNxNntV6L8+f5BJC1sedoQRyG59RyzfpLcvbHfVDL/qj10mbdJYKHr/aW4cTyhhWxCNK7T7USqol5Sdq0PRSSE9y6e2CPVY3YCrWKkG93841CxFY8i27Q7ZgLixJ32kPYgUfLp2mCYClsBcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327480; c=relaxed/simple;
	bh=7DOOjiFf+sYmSm5JWfgliRMe+Pi7ySnZfjM359AsiwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3vVw4BdbLBIKUJjg3xq+K3BiNK0Eq467mDKMVjSTRnxiP6PqI8yZ67u5ZljdkzExHfiAY7lv7BBikp/teF5m9bcdODUyTBfQLJqPEAmHuebYnNzdd+ShKvYCHMKVUm1EgJkQ3uWZUWC4pnU54jwF0Qa0QfouMRYuykZ2MENKd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=txZ3WGaH; arc=pass smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="txZ3WGaH"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2d891442388so535143eec.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 15:04:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777327476; cv=none;
        d=google.com; s=arc-20240605;
        b=A2IMC5+ZEn9AOEe1oXoVeB5TZzkF90gMeOfkUA3rbbf10VIx6ekk0WjMX3GFbJkJX+
         sOZTGC9AYxIOrkmh3ShY9cI7PTCI/2tKoj0pKWiRTr8k0RnZ69WGgco1qVjP0pniGhGx
         2IYDr8cDLJcIetOFXxjD8ZHeFLCUxAaQII2cNj0OM/lGBN3ceSEJonK2E/9gt86GtZci
         FNuXyt0UvfL/YWhkg9UUIb4ikLxnyA9intP5K1uVUVFAC7Xl620jz6NfJlUOdlCCkpLd
         PNPlvNpc9gxHtqfwN7uId69jUNX5WnbpWemp0eiIJONXW3Mt3SSG6A8bhVq6u5G0Ok2h
         1yyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XzIxXRAIzxAYYMbmQLFNASdoiGDN2I0JtBVDZH0nO+E=;
        fh=VD6+8Byl3tQdpSyi2PCFWiraqxikM4SGKQmu4doyu5I=;
        b=ZH974FcUiUZSrt8AFZu7ye28vLPDmxsG0LfnPC+ttFT7PvyqahslQ2yFLBFg61HD2f
         k2fgYkeNRd2bbWxZbD+IluQsAoL+c9ErvYafczLil31njKJ4NVJjMdPOPLj4wY+6KWKi
         VYefRtdZ2OxNsgEQnVZ3TtZ/jKS09k2N988VXlJAMgXNqVOl1qN1IXj63Ve7eFMfU7bL
         GiUMMHpZtSUoN7ru1lUMn/RDNrN3brkfPUClIxM8EczpagSGrWxqODzKH8/ehxbJF6NZ
         9QItHsAVh/VeCzzHPEHrpRSqo+7PviOuSdIW7K5hgfwTi5Mt24+vr/Rle/xl3CGnZGeJ
         N+6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777327476; x=1777932276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzIxXRAIzxAYYMbmQLFNASdoiGDN2I0JtBVDZH0nO+E=;
        b=txZ3WGaHcq6q82ssEfrnmz78t7VNIII2z4hITfL/62igpbnIalB5wQPbfeBFIG6oW7
         UfoihHHk6EOU7dQhMa4Oitvzfg0nmAIJjJ9VQEKlZmIIfbKJIl2YG7fGmuO71I6Qprfk
         Sp7L1vCOcD0RAwvDb7ZfrrfGaQXeYZ31y/XPYkG3h35VbIvzRuttN7LOba1AYqp0wik8
         vKAHzpSjO190bbNF2fzsJhclgG66DmZwNyos1G8pKSxKxk0Uz+WGCi16PnAfrYhd4WS0
         WTzVA6ScbmtBAClmxeDFE9bv54tK2ml3rsJxSjcZ1WeG54nlMdSHiUxYtRTJoIuEXGou
         YFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327476; x=1777932276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XzIxXRAIzxAYYMbmQLFNASdoiGDN2I0JtBVDZH0nO+E=;
        b=j/Ic1oU251rVbA5+Y5tZ60fKdwbuGKtjv8kaVm7sua1bpR53SYdd+5LXXSDUlBrPOZ
         GLPXJ2Wq2Hjk17lCB2e7Gde5GbcaNUdt+bA83AwU2N1tuHC3bFuRlfCEdmOZEla+TY86
         ijeZdPppnuo12NiAxJM6k/2M/gwphFxD1Wi3Zs0DzTmri4QIhtHSsGBczIASGQPARbcQ
         ZX9OEPYAXWBVWh+8OZOpWHD3JzHVNkWGUXu2IrrqL5XmFHANSk1p1kUyGNqWdV8iVNWE
         UCYw5Vtl5l4G7GmD/VrFzabdxIecjlNGDexUuAexxw/q0u5IbB2IjBwBbtp0O6p19VJT
         m5JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+mhv3Q0KneBQjNxgFvlnTPqeKqmoINiF+lE9zOv/mVyVFEqH83/fFep1Jbin+ezPgRLQ3uFmWpF1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJCvpmlbua7JrZCHuQ6RqeQKCWZgp22He94fhTMsxNrAyTz0Nk
	hCkCNHGI5JvWu+Sr9jIh/KPZTgVyMIU3z5HW/OG3mJUse5g1K1OOx35GgoS/MSiScJwLvgYOA4Z
	P/de4+wx7OmjM/3ZS/Eoxj2xpBYoCJGQoy42+clNJZQ==
X-Gm-Gg: AeBDietTpYMtyKlx2feUWsf6fHtTVo9e+om2kGDJ0y9s3anWl0oOhIG+z9LjuJgX7ML
	MijC7hMBhT8DlbUOcq5QwuUSR8OiC6rXYuVsoiLll0+L4YqiooHQsd/JVKYTtTt2p7Gi+KIj4ZK
	Jjyxr80DuBGOsMv84Dk3Y5FzOKGUmZO88BA0O8noVWgOK8RKa8oXnEbENpYV7FJ+j/79jt/aE6L
	fIthRVjhJyt16RwYjia4SRHYqqOod1FZNA8AvFENK6GQ/PU8S4KGQ7gm/BExgSK4IaEQ/fFcO/S
	XGWSovROJ2nrnkqH4BbHlgtXh4f19JFxm3UHt4rhF5kYJmnPQQdutggRUxP3
X-Received: by 2002:a05:7301:578c:b0:2c5:b972:b436 with SMTP id
 5a478bee46e88-2ed0a0ce7a8mr376020eec.23.1777327475790; Mon, 27 Apr 2026
 15:04:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260423223958.100487-1-guilhermeabreu200105@usp.br>
 <aes2tzgfXbuD6ccQ@ashevche-desk.local> <20260424113901.0508dbc2@jic23-huawei>
In-Reply-To: <20260424113901.0508dbc2@jic23-huawei>
From: Guilherme Dias <guilhermeabreu200105@usp.br>
Date: Mon, 27 Apr 2026 19:04:23 -0300
X-Gm-Features: AVHnY4L3rWKdnACK4Wm2aghKSMgx17kA3HSiKn8OHX4ahxs1pdcbB-6h4QXeFCQ
Message-ID: <CAH1eeHs5M4rDhdtmyWadFFsx3qK9=xST67h1zwb0-CwDV=aLrQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, nish.malpani25@gmail.com, lars@metafoo.de, 
	Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, =?UTF-8?Q?Jo=C3=A3o_Paulo_Menezes_Linaris?= <jplinaris@usp.br>, 
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Em sex., 24 de abr. de 2026 =C3=A0s 07:39, Jonathan Cameron
<jic23@kernel.org> escreveu:
>
> On Fri, 24 Apr 2026 12:24:07 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
>
> > On Thu, Apr 23, 2026 at 07:37:51PM -0300, Guilherme Dias wrote:
> > > Use guard(mutex) to automatically release the lock on scope exit,
> > > simplifying the error handling path and removing the need for
> > > explicit unlock and goto-based cleanup.
...
> > >     /* exercise a bulk data capture starting from reg DATAX0... */
> > >     ret =3D spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.=
channels,
> > >                               sizeof(st->buffer.channels));
> > > -   if (ret < 0)
> > > -           goto out_unlock_notify;
> > > -
> > > -   iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> > > +   if (ret >=3D 0)
> No to this as well. Keep the error out of line.  Which makes the use
> of guard() here tricky.  You could do a do { guard(); } while(0) loop so =
that
> you can use break with out it being odd looking.
>
> (I don't like breaks out of scoped_guard() because it's non obvious scope=
d
> guard is actually a loop.

Thanks for the suggestion =E2=80=94 just to confirm I understood correctly,=
 do
you mean something like this?

...
 do {

 guard(mutex)(&st->lock);

 /* exercise a bulk data capture starting from reg DATAX0... */
 ret =3D spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
                          sizeof(st->buffer.channels));
 if (ret < 0)
            break;

 iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
                         pf->timestamp);
 } while (0);

 iio_trigger_notify_done(indio_dev->trig);
 return IRQ_HANDLED;
}

Keeping the error out of line again.

--
Kind regards,
Guilherme Dias
