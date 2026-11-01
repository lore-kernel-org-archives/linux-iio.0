Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793576429;
	b=uawwwH9eNN3fZfsnJ54vTRW7XWveFGcqX4nlTr/m9AZpkmBP347SLkNpVm3Sp//wb5+b
	 3bCqpMiRMnjkrz2zQmg+g1xj9FwUDLquqEUSIiBYLE62Z8fSOcjjlJxdKCSKTwimss3l9
	 6XdX03u2jWexCWvOTc8ZFXcpxonoCu65DRmb+ck/HK7mmiq2i4KLqvMQ2GxbWv6SkBqJu
	 7V23nFIZ+UA15tPm0J3fkGDxVTHaLv8e/sXRaort5IQaJBfa3foCwVn0pkx803Fx+GGla
	 9b6IakXA6n979B1ggi29vCKRaagTtTqSNpz5HMwFTBuRM2X6qT4HWq9Ss+iIXjAmN8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793576429;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3eD7IFMtpN6nJKjfqgZB3Oa32c8tF4+kKEbpHerQics=;
	b=RepmqKLvmRvpsEV1BK7s50lBynYw3KAlKDWcuxjVZ1oLBW1ITEPSZ38BKhr85DwgWGyk
	 zPIkt0UN2cGVYJVL3fAna6NWzK3jchf5e54PEG5YwSX+w5SeMT4wzBg5MA3CuozGGytOw
	 rEbW2bbyEsQn0q35kiQAS60bb2WMUGfJSRO+3k+3sC4fOegpjJERbUD02MqS+qmqKH7CG
	 41DWRPhPzn/933rGnMuzg830e6mo4Y4aRLH2FX3mbzKu4NTNHYs9JgzS6b3o0AsHHZdqQ
	 ronZ4oJcbco9+4P9E6R4LTQz1dmtDFsoxVB/404KOMgDr+I3aIjtr0L++XIfQqCEbMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUUh6Kew;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B6606A32D;
	Sun,  1 Nov 2026 23:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iUUh6Kew
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE671F000C1;
	Sun,  1 Nov 2026 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793576428;
	bh=3eD7IFMtpN6nJKjfqgZB3Oa32c8tF4+kKEbpHerQics=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iUUh6KewOgb3ZIJkUgwgn+qwmqS9ptkxoe0wGb4ouxV7LF5TdOrn3s/3y6FrlFK7C
	 idOu6uWj05h+gLAPhma9VjptaJfgBwsXHSoHkB2efg65UALHFS2fxai7M8nQgPaVMU
	 gV0LyTmwU+uFkkWXIdNOnkv9E2KaX8CRb9Duw9tINYO7RzTZTA3NsauuQcUgsHLlyl
	 myIF74WMs8/fAbjMT/fWBU6yUMVRX4t5L7NaUhPTNA8Sn2DIyFQMh24pCkEbYi5hmU
	 rDZRg5Lzw2hCuL9Ue7ivrKtviOrLniWgk1XLzjhZ15rPP1qWeY0vC+0KRB6TdOuzub
	 eMmpXpPLy6aPg==
Date: Sun, 1 Nov 2026 23:40:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Rodrigo Alencar
 <rodrigo.alencar@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: core: fix signed integer overflow in
 iio_str_to_fixpoint()
Message-ID: <20261101234022.6e094a05@jic23-hlaptop>
In-Reply-To: <atsgYaApZPg_3Z1N@nsa>
References: <20261022140353.24213-1-kapoorarnav43@gmail.com>
	<atsgYaApZPg_3Z1N@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 23 Oct 2026 09:53:36 +0100
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> On Thu, Oct 22, 2026 at 07:33:51PM +0530, Arnav Kapoor wrote:
> > __iio_str_to_fixpoint() accumulates the integer part of the parsed numb=
er
> > into an int. Feeding it a string with more digits than an int can hold
> > overflows that variable, which is undefined behaviour.
> >=20
> > The parser is reachable from userspace via the writable IIO channel
> > attributes, for example the "sampling_frequency" or "in_voltage_scale"
> > ones, and via the exported iio_str_to_fixpoint() helper used by a
> > number of IIO drivers. A user writing a long enough string therefore
> > triggers a signed integer overflow.
> >=20
> > Use check_mul_overflow() and check_add_overflow() to accumulate the
> > integer part and return -ERANGE when it does not fit into an int. The
> > sign is applied while accumulating, so INT_MIN can still be parsed.
> >=20
> > Fixes: 6807d7211327 ("iio: Factor out fixed point number parsing into i=
ts own function")
> > Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
> > --- =20
>=20
> LGTM (maybe a Cc to stable next time but Jonathan typically takes care
> of that),
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

In in two minds about this.  It is preventing unintuitive behaviour but
we shouldn't have any cases that crash or anything like that.

Given the code in question is likely to be replaced shortly anyway
by Rodrigo's rework applying this for backporting purposes makes me nervous
even though it looks fine. I also don't want to delay Rodrigo's work
by having this go in via a different branch.

So perhaps the worst possible compromise.  Applied to the testing branch
of iio.git (which I'll rebase on rc1 shortly) and marked for stable.

Rodrigo, you are going to need to rebase your series on top of this.

Thanks

Jonathan



>=20
> > Changes in v2:
> > - Use check_mul_overflow()/check_add_overflow() instead of open-coded
> >   s64 accumulation and limits (Andy)
> > - Apply the sign while accumulating so INT_MIN needs no special case
> > - Drop the unrelated parenthesis change and the explicit casts (Andy)
> > - Add Fixes tag (Andy)
> > - Fix the truncated subject line
> > - No KUnit tests for the current parser, as it is replaced by the
> >   E notation series (Rodrigo)
> >=20
> > The fractional part is left as is: with the fract_mult values used in
> > tree (at most 10^8) it cannot exceed 999999999.
> >=20
> > Tested with a userspace harness built with -fsanitize=3Dundefined on
> > inputs including "2147483647", "2147483648", "-2147483648",
> > "-2147483649", "99999999999999999999", "-0.5" and "12.345\n".
> > All inputs that fit into an int parse exactly as before. Compile-tested
> > in tree with W=3D1. Applies to both togreg and fixes-togreg.
> >=20
> > v1: https://lore.kernel.org/all/20261021225306.623361-1-kapoorarnav43@g=
mail.com/
> >=20
> >  drivers/iio/industrialio-core.c | 16 +++++++++-------
> >  1 file changed, 9 insertions(+), 7 deletions(-)
> >=20
> > diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio=
-core.c
> > index d73f2541375f..f3bf17c13cea 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/math64.h>
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> > +#include <linux/overflow.h>
> >  #include <linux/poll.h>
> >  #include <linux/property.h>
> >  #include <linux/sched.h>
> > @@ -1027,7 +1028,12 @@ static int __iio_str_to_fixpoint(const char *str=
, int fract_mult,
> >  	while (*str) {
> >  		if ('0' <=3D *str && *str <=3D '9') {
> >  			if (integer_part) {
> > -				i =3D i * 10 + *str - '0';
> > +				int digit =3D *str - '0';
> > +
> > +				/* Accumulate with the sign applied so INT_MIN fits */
> > +				if (check_mul_overflow(i, 10, &i) ||
> > +				    check_add_overflow(i, negative ? -digit : digit, &i))
> > +					return -ERANGE;
> >  			} else {
> >  				f +=3D fract_mult * (*str - '0');
> >  				fract_mult /=3D 10;
> > @@ -1052,12 +1058,8 @@ static int __iio_str_to_fixpoint(const char *str=
, int fract_mult,
> >  		str++;
> >  	}
> > =20
> > -	if (negative) {
> > -		if (i)
> > -			i =3D -i;
> > -		else
> > -			f =3D -f;
> > -	}
> > +	if (negative && !i)
> > +		f =3D -f;
> > =20
> >  	*integer =3D i;
> >  	*fract =3D f;
> >=20
> > base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
> > --=20
> > 2.53.0
> >  =20

