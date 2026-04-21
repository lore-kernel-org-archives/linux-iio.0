Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149D13845D8
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775793; cv=pass; b=MZc3C8JkgdO51X5z3isQuUJl1tZqNGECCoJ+icFnwF3vBqxAaJBJeLXkUPwHzVzN8H8I3IhaV6wOxHbLdMPvAVycToQW/Z/zXK6afyW4kap/UeAPSQSyHUKZRwa+BBXyP0oH6T5R9kFLjDt3PxK0B/CwzI2v19oWWKXIo2R7WFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775793; c=relaxed/simple;
	bh=vNi43Xf6OSIzbF6Z7RXi9dCVO7srGEMN0CuH1U3Ffes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WEyZuwhS5fiweinwDuJfuz3Mevhk0SwApGDQDgG4CzqvGT5riWE7usyQ9dXaOltj3r1kGpuFFTVn/dCSTw14eEXs9OLoqtnZZkFGS2NGL+yMDJIhrI9lvBI2Ur6mz0MVqtOesnn/fd3nyXdfzz2neYGsNouDbED02f+WaXsFdKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUVosTOS; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUVosTOS"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso553947066b.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 05:49:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776775790; cv=none;
        d=google.com; s=arc-20240605;
        b=JMbwE7uLYdO3hnot0uLtzjDU+qg8xGFwRUMLYdB+92r0mBIXoMxOvRadbYuqrYKR3S
         KkVJXdWezYT5OIcWNREcidaB59I/vDUcBYoZyIlFbgGp+tufI8+gIYfraqNE2pjszv2q
         yN9DY0igoVfIHfohcR7Y0tx4ZjMEhTPdo4nax7cl/VEJLwcXSapXkFiducIpkZeC+lTL
         zoVTlrczvBkIiRculJbJe/5NUELZck5nASku5xxX9S+FpQLVDwUJ11lS+dSVw0NRLTry
         oxm8CNs8gTQU7S+JgQQzxys4tDej9kg0pvfaldadNacUZ9WFfTPBb1zuFQ89DHZ11L3e
         yF1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kaGcUM2oVd6aQz87EOxtKMZk6I0+5wbfxHFZIiWXOY8=;
        fh=77fabpOLO0WnF8+w+hOsrCP6bM5B9SoFomrnysoR5VM=;
        b=jSYWEyD8ZbzfvnXjOmP4g9IIRVtDcyBogHDibhQ8V/8jZDBoA6S/9rkQ5pEwhqIfv9
         FXc+1u9nUq4vtCBZdJ2EradwW+khHoN2gKPaa+NIboPb86dEe0DrpsgVdy3aRT/zhdxB
         xbhfuhDE+rgHdloKpt/uY2NwPaPoAX8JqavIAA8pEfx9u9ddxlpsmdxMdrTiEcYs/x2m
         na3wG1Hqmmmm+avrx/lhBXUCAGxG3IKA6ZG3NpoMd7otjMdUVP9gKbxdYGP8rdxbbQPK
         y4YodF7Dgwa5zA/zW2vVZR1Zdw8/MbQyu0mYs9+TSXhGKFkMlcTINPL6lpzrwuy+Bfx3
         V+hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776775790; x=1777380590; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaGcUM2oVd6aQz87EOxtKMZk6I0+5wbfxHFZIiWXOY8=;
        b=XUVosTOSOmPfD+S9qsrFEMJmT8BygENmnkOGwXjzLNLSSZVgdc//oYJMmsJk0nOf2b
         Ea2ygwx8Klq+ktdl2bPaNsp9h6SXH+WDTX4BUPuEeSmd30gETos/G6nlezIfaq4JbAxS
         k48gDTN8Tp/IIuYq+gWIDwCQG0S7IpdlFp9wfPb+r3fq5B8RJ/k3jw0T13x+BIEKXk4z
         eJ7TerpQRQVBXkSIyueW/tjN+CsAGmNzdIUgngg8MMd+J0U8/TKL3HfsGL+SsQtsBtuV
         O+bApvzWHv3e16rNMBnHC5+11iRT9naTW2w6t46LLRtrZ1aAc0gdhJ+W/OZ6JJ+t0w+a
         PHYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776775790; x=1777380590;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kaGcUM2oVd6aQz87EOxtKMZk6I0+5wbfxHFZIiWXOY8=;
        b=B/ppk+Gg8LEfaFZCBJjATVicYT1mFYrem65N2/6DPMh4VZOROr27X954xhgWDuqiZR
         4b5Ms+lKWlHqc+Xldy5nwMhOldHRX00MJb0tWuZyfpQjv8F/MlFoUlJaiwIxbJzifeNz
         j+ZuqDxnKHqCf4y6lxw5MM+siYOYoXfOkCJRigU5MGHa7tr7/PwzkrPga3iv4L8R3xic
         ON0s4gSYtzqL8N/qmJ8BgvB+oHxd3gonjgueW7QpoUU51TgeNNa1Kn3lJ6PYyg0q36PC
         SkgAGuR2jMwHK2sROvuBUPWhh/B+Ih2Sb2IzfXa0PkWpXouymYBzv5lPpjjpNvS8sUhs
         CODw==
X-Forwarded-Encrypted: i=1; AFNElJ9W/U9Qr2xH/bMiCRFWxz+wDpicoIQ9otZzahyr7fxb7ZGt3XEexsWk64e+JMozaTQILLkUX6YyG3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lmmhh5eALEL7ubWN2HEf4QQfLb1spent2Dx96w+vEdrBDSUW
	DcvMdfBZ3iYB87PkImTbzpXKZPrXj4LpBIkFqIBYAHR2OuEI1sLrI2ssxaieujDKxnPNhkmE8F6
	9/DgRXXLJiLmI6prkP3rQbO+amwwJ0OE=
X-Gm-Gg: AeBDiesXCjw6oLXXh8MBKOBLCrHTct9nl0Q9CZFv4OYkbPwkrH0yMK44nyqqrrTprv6
	8sV/grn7t64x5HwS8jLVXTAkDGxfz7uolKcFGMAvV9YBWoeRLMMBNMweXwaHDg+eeiRN37W9dYq
	UhmlrQKS9c3kbfY8vqLsL0ptFE4jdWvv4BGW+GU3xKb6ZE0V9/nHa3PEFFvYedRvinQ8y4Z6Dxi
	m3QJIHltG4U+OMAK9jpRacCA+UItiawKVUB5FYcCVwkHyTE1VVpzwPp7ZEymo7yn5kaxO+PxuOp
	ONmfiCpRQ6OYsn6lfNjrScexHuuW2/CoT04DBXgb5sBV5/Xliev8C4PMpjApBLGPHJ6Tk0g+cyv
	F0Xwovr4Q0EwvKnfc1Q==
X-Received: by 2002:a17:907:7b93:b0:b98:7e30:8129 with SMTP id
 a640c23a62f3a-ba41a825cd1mr800964366b.32.1776775788650; Tue, 21 Apr 2026
 05:49:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421021023.563290-1-rafasales@usp.br> <20260421021023.563290-2-rafasales@usp.br>
 <20260421111919.5ad809fb@jic23-huawei>
In-Reply-To: <20260421111919.5ad809fb@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 21 Apr 2026 15:49:12 +0300
X-Gm-Features: AQROBzBGPln7ETNUs2sB4zmqXEl1hAzYrtYYa08oEQKuqDxIxno070hpSBY-6UE
Message-ID: <CAHp75VfVB9qQeX94Hvhv8apa-gzK0anmE6ox5wzYK8oVKGgzMA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: light: ltr501: update header inclusions
To: Jonathan Cameron <jic23@kernel.org>
Cc: rafasales@usp.br, andy@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, "Gustavo C. Arakaki" <gustavo.arakaki@usp.br>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 1:19=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Mon, 20 Apr 2026 23:10:00 -0300
> rafasales@usp.br wrote:

> > Update header inclusions to follow IWYU (Include What You Use)
> > principle

> One of the issues with the kernel view of IWYU is it's a bit fuzzy
> (and not well documented yet).
> That means there are some headers we assume will always include
> certain others. So if you need the 'outer' header the inner one
> is not normally included as well.
>
> So the comments below are very much my opinion on what should
> and should not be there.  Others may have different views and
> it is always a little flexible for some of them.

It seems we are on the same page here. Just a couple (I hope
insightful for you) comments below.

...

> > +#include <asm/page.h>
> asm headers if they are needed are always in a separate block
> after all the linux/ ones
>
> However, it is very rare to see asm/page.h in a driver. Why do
> you need it here?

Yeah, the most we should see in the driver(s) as of today are div64.h
and/or byteorder.h. And the former is still rare as usually we want
math.h.

> I'm going to guess it is for PAGE_SIZE?
>
> That bit of code needs a rework to use sysfs_emit_at()
> instead. If you have time please could you make that change as well
> as a precursor to this patch and then we won't need this one.

+1.

> Alternative would be to convert to using read_avail().
> That would be even better but is a more complex change.

Even more =E2=80=94 +2!

...

> > +#include <linux/bitops.h>
> I think it is always safe to assume bitops.h will include bits.h
>
> > +#include <linux/bits.h>

Yes. The chain is

bits.h <=E2=80=94 bitops.h <=E2=80=94 bitmap.h
If the header more to the right is included the left ones are
guaranteed to be provided (or rather the APIs they provide are
guaranteed to be in the rightmost).

...

> > +#include <linux/byteorder/generic.h>

Note, this has not to be included. Yeah, a bit of a voodoo, but
asm/byteorder.h is the correct one.

...

> > +#include <linux/err.h>
> > +#include <linux/errno.h>
>
> It's a bit indirect but I think we can always assume err.h will include
> errno.h

Yes and no. err.h includes asm/errno.h, but linux/err.h. Strictly
speaking the use of -EPROBE_DEFER along with IS_ERR(), for example,
need to include both. But I personally don't go that far (I do not
require people for this particular case) and do not prevent them from
doing such (when there is the case as per above example).

...

> > +#include <linux/interrupt.h>
> > +#include <linux/irqreturn.h>
>
> interrupt.h will always include irqreturn.h so don't need
> irqreturn.h

Agree on this implied dependency.

--=20
With Best Regards,
Andy Shevchenko
