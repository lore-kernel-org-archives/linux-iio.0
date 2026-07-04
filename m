Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D7F372662
	for <linux-iio@vger.kernel.org>; Sat,  4 Jul 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783191185; cv=pass; b=QmlLxWtzaDxbH0A3Lq645+R4ZCsOednL434ZdUvFbuRLFJtXeAphEM2CkYSgKigIhILz88nu3+XiRTqj19T6cWMw+7Fmr845GObINIela/p/fLc8JrHAfgG4PAj03tDU5BYDh8b3iuP4E8gp+nT1OZVSCZdSUXbiX54rcQ6XP50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783191185; c=relaxed/simple;
	bh=GfnlmAFvUSAqS3ZrwBAbcQ1Hx67x/lz6NtI32WD2Khc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZJ6A2Bwg4vp76acxWT21t5btoFdBWYeYMzhaJWIMl208WStLfS0D1NzMg0xNxMJFApTLxXyOLbdNHtwbt4NR32M/3+6mSf1yLUtR6KBcsZTAUhB9QIVCORYoVtobeHa1tGr8dzwLYSxZUWXNXwTQ5OfgZViSCVRoHtjVpjK7D2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBl9N54m; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBl9N54m"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c126fe7d0f3so192799066b.0
        for <linux-iio@vger.kernel.org>; Sat, 04 Jul 2026 11:53:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783191182; cv=none;
        d=google.com; s=arc-20260327;
        b=CkGquA+mdxFSxygnjJ9Duu0umkvAFHqmKavoVbWmpHqJIpNt8ld+8bsw5M8+nQIOMP
         1b2+hFReuYUtl7sAy45lWpWVuVJbpIKz58kfUfzeI9NLzguKPPHrANLJR6zP3nCRgeW+
         54bmgBys7IrrpKc5Lhs66FLYb29LGqAwPfap7cr8nyjyzFjQ/BUd/rK9hfCaknPKemfW
         CZX2VUORfqRNNYwOmZDSdTlQcpGgJ//WCRUru/WYpn2ljE8fUPxS4QNUQi5zfk1lvIUF
         qqCtI3r0nTGn4IwQK/SaIggKEJaR4nV9lC/aIllKnFbt/zh5BdOulnealcprte9ARJH/
         RyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f+BkGnn82LQN6bHnpZs3JGZAnAhIdCPQEanxeSEyBEM=;
        fh=3bWm8WDNwTFw6zbWOtNKqjb9Wae0GPz0BgYoMnk9fFI=;
        b=B1DA5OHdRmQTdzGrcjVbY7dre2M+FPQx1mV//cWC2aK497LtKTKsO0YDBDFJmzKRxH
         IZo+Oncunh2rhC/8SEMGWYWTFThJH7OTEHE1L9EQKWgH48WqbVcj850UVq6qbhpyH/Up
         i87B9VN1fDXd/6ZPEuXtQmFlVwYTPqZyoBBepLsUoYvHDcV+nuIr2+kApj27II+MsGKj
         vzS5k/TkJqr+G/MB8Ei2O5nHE8LXi4lu/FebRZ39jMZJWVjHXBNL6BEB/2ZMxdGkRqW+
         a1aEuq09HId/f0/GI9imBfqfpBcWjTR5Ompzd3V+VG83eS5ANcVPITETVQx3sZLXfaNg
         4gpg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783191182; x=1783795982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+BkGnn82LQN6bHnpZs3JGZAnAhIdCPQEanxeSEyBEM=;
        b=MBl9N54mjc4tJuE+tFBvEd21jYVWHVytcvHI3UUdy0vRjod+8RGxgJSj2mj9Bjf5B2
         1MzS6BUJIPVKkEIz3RCrv1gsjEmHV+wyyMSvx8ZKbtKRsIEcjFifKHgIpn7GisHN6OIa
         7LUkwvuvLFCuqgQm46lUxhKnBUoHIJupc5pYcxYXiPIzhO3zyxSP9nEyQKL63Ud6/K3L
         LLILucDyS0kbVc3Koicepfk87PUcKTnnsdgzuokgj1LH2Fpdv/ERRnKhYMq4gFpBooAp
         MHISeat7T7+qJg0OxfCrkvMfVBI5wYb0D2Wmjb6XxW+pTLTCMlIAfp65uT2QYkim5lNr
         lGkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783191182; x=1783795982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f+BkGnn82LQN6bHnpZs3JGZAnAhIdCPQEanxeSEyBEM=;
        b=NzXilfpvHLiSRaY962N89buPzpINnaIJ3+7PXu019z/7EOwf2hClA2ast/IvJriCms
         JnrVuSNz1A1lU5BL80HW5lnviMlBkYAEY1J9+4hPYkaAzBQS780P7GoZ+zLpSdId6rXZ
         Qh3sByAqrmbA9vH9T9HwyAwzY5VJLV10JNqK0Wnec+MAMjANZJEPZ/f6iX6T6pUXJD7A
         WnYOTj67D1sGiyVRz1d3NOpQQkZbiLw8Hwe7mEWn9lh/rLvXcjDsBoX/Ip8wK/m9g+iA
         rApkPBwkZkcQxAlhCwm/Z6vULfk8jAdOznocl15MeKuxCPiVqGhdxoWys1nQlfjkkjXH
         u/Ng==
X-Forwarded-Encrypted: i=1; AHgh+Rrc9PYHnwcwN8au/mV4RFy8bRS+QX4aNoJw6WuQfy5McGWz2jgT2D7GJrJYNDsShPksp241KrBZCNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB7U4FNFN0rp4jk9PquSSs+pV4qxQD++OjCJTZ+9g5CaGzRYL3
	n3mkTNTZAbwGQ53QYfz86pSae43Sl2T5PPrNXW+MiXdvGnQ7cGC1PDxZ1q8qLJXYxVERDLdJwXd
	G2pTcHZNHCk4EkGXeMTPXSJhJK3us3lg=
X-Gm-Gg: AfdE7ckiFZpm5L4upCWx9xABasll1VT0E5vqVcTjyuxgjfXsgx40EGITJT17de2AD5n
	J1YMfBJ6JA8A/xIk5wqE7kfIbR+1B4WeLnoWq6mgJ/OYWv35Ms0fEzvj3zDwbaKsg0bSqjz1HVC
	wX0nOBB+FCNOicjfcntsOe+AkXrAWhYl28UEjymH4F0TUrMr14SufCtQ48uR+xKnKQgO35WgLpD
	yms82lrQ4EzpqQgSmNshFYCbYd6oONN79juUi8RUe/JgiLC65otB3lYAT6+cOVBjb/MVyUFVqbL
	6EFcDv0cN9qDiLnAskGmlAKJkUtsnVT/0DeK6+PY15cDLBNNFF/brmeb9tQJuQ4Lu9uBsrJfPXs
	XtmS8C2sFbEvEw84E1Hpu7hEMlZp4agIf3rHtefnSoyszew6Y1B0Xa+R9+7nTGq7TcNlN
X-Received: by 2002:a17:907:25c3:b0:c12:45fc:c44 with SMTP id
 a640c23a62f3a-c12e6bff31emr137459066b.62.1783191181998; Sat, 04 Jul 2026
 11:53:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260703102941.1141341-3-stefan.popa@analog.com> <9878f042f424bfbd7fab24175298224b58e87779.camel@linux.dev>
 <akj3Ay8mwemRj-9U@ashevche-desk.local> <akkwWxCf10rfThMk@fedora>
 <akk9d-Zrx52C674x@ashevche-desk.local> <f7aba67831fbee343c105bba4bb531ce6f1c1c50@linux.dev>
In-Reply-To: <f7aba67831fbee343c105bba4bb531ce6f1c1c50@linux.dev>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 4 Jul 2026 21:52:25 +0300
X-Gm-Features: AVVi8CdyAnuqpwp7HErpmAcpd3YTiWdAQ5q92MiljKmxpMmIe5DU0ndquU9wm84
Message-ID: <CAHp75Ve_98MSB-RrSWV7J5yH39c6gus4eUBjXondo1=hue9pyg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add MAX40080 current-sense amplifier driver
To: Siratul Islam <siratul.islam@linux.dev>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Stefan Popa <stefan.popa@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 4, 2026 at 8:30=E2=80=AFPM Siratul Islam <siratul.islam@linux.d=
ev> wrote:
> July 4, 2026 at 11:05 PM, "Andy Shevchenko" <andriy.shevchenko@intel.com =
mailto:andriy.shevchenko@intel.com?to=3D%22Andy%20Shevchenko%22%20%3Candriy=
.shevchenko%40intel.com%3E > wrote:
> > On Sat, Jul 04, 2026 at 10:32:32PM +0600, Siratul Islam wrote:
> > > On 26/07/04 03:05PM, Andy Shevchenko wrote:
> > >  On Sat, Jul 04, 2026 at 01:42:39AM +0600, Siratul Islam wrote:
> > >  > On Fri, 2026-07-03 at 13:29 +0300, Stefan Popa wrote:

...

> > > > > +static int max40080_get_range(struct max40080_state *st, unsigne=
d int *range)
> > >  > > +{
> > >  > > + int tmp;
> > >  > > +
> > >  > > + tmp =3D i2c_smbus_read_word_data(st->client, MAX40080_REG_CFG)=
;
> > >  > I think tmp can be initialized, since it is only assigned once.
> > >
> > >  I don't get this comment. You mean switching to ret?
> > >
> > >  I meant tmp is assigned only once so the indirection here, i.e.
> > >  declaring and assigning in two steps doesn't buy us anything. Instea=
d,
> > >  it could be initialized like "int tmp =3D i2c_smbus_read_word_data()=
."
> > >
> > Ah, definitely no to this suggestion. It makes code harder to maintain
> > and the pattern you proposed is actually discouraged. You can search in
> > mail archive and find like ~1-2 year old message from me with the detai=
led
> > explanation why.
> >
> Thanks! I'll look into it. Learning a lot of stuff. But I'm trying to und=
erstand where to draw the line though.
> Like "struct xxx* data =3D iio_priv(indio_dev);" and "s64 ts =3D iio_get_=
time_ns(indio_dev);" are pretty common.
> Do these calls make a special case for it?

When the assigned value is coupled with a (validation) check,
definitely do not assign and define simultaneously. When it's used as
a counter, it's better to assign it closer to the user (meaning the
counters that can't be folded into a for-loop). This is the rough rule
of thumb. Plus use common sense.

> > > > > + if (tmp < 0)
> > >  > > + return tmp;
> > >  > > +
> > >  > > + *range =3D FIELD_GET(MAX40080_RANGE_MSK, tmp);
> > >  > > +
> > >  > > + return 0;
> > >  > > +}

--=20
With Best Regards,
Andy Shevchenko
