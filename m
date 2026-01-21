Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C9481FC6
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769005220; cv=none; b=P2emENN8Ux6toxNRDJPpy/lejKcuBBZ9/DB9ruI3QrjWWwlFxK5TcUcs3mD+kHGQ1ggT6+wNCupzFFCr0RxHfqaGDgxBq2kjEoBNa/uGNBgUq43xBAIuKQUQ28YutMgnWUj3ZOw5q9stHCOVj8QCxFv15tTFGnPevVFzaZ2KYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769005220; c=relaxed/simple;
	bh=O7m4ZpKhedGqokJhJAmLBqTyG3gdL+OWB9GtYVZR0c4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FViRCue3n+GmVxwjwDXhS0cxL3HSc9GHbEgFWdqfH5zPBFSluBb/rzPv8iCsaD4nXQdrSw7Xdn+F+PvUVcuj8EYRCZ/0BuXz5LcPgxJCrjj29UUZY68+AMa5u2KE/0WggQxZuMEDi7ebTY4YUL24cMssYa5aUKcGmXrg+v/kpZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q93RR6f8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q93RR6f8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4801d21c411so25072015e9.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 06:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769005217; x=1769610017; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=O7m4ZpKhedGqokJhJAmLBqTyG3gdL+OWB9GtYVZR0c4=;
        b=Q93RR6f81EvQkB7iBQ5VLbGCFlzm6A6J8eQHyh9cWoZYBy4CBEySyHTFCFXSQ/F1Kx
         tPzkABGWcmySKGB4bYXWrV8iTKxWYOjAjPcK2TdxTlGWlftBxFkPEjrwFyzzU0DDoMYt
         zl3HYaYU4ce0nGCSZYp7nHjJTmX1uIRk1sfv7nMlTMkmVnWVaq7DO3PiVHJfPYqV1vNr
         nA3XKRB0HsMBysyxW9HhNHHCrj8X/vYIrPX9zXeA0S9JDAHdQkZqHvqTNCm4HnzlOShb
         v5JUJul67ZvarcQTIOPQ32UHuCBSpn1AVKdy+ybwXIALXjsUrm9wdFDKA+P/sNiJxs+P
         45cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769005217; x=1769610017;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7m4ZpKhedGqokJhJAmLBqTyG3gdL+OWB9GtYVZR0c4=;
        b=iss4kdDtakvCQwiBrhBp8btppwHxTgB9AhMGHdTh5LVnaagngLzNaIiKMLzBws5Q9D
         yWdbV5Hbqp+Rmbr8ZX2RDLr4TMgFGLfNTzCBTOf2djC3uefZapHrzHtZ8HcjKFvlvVGI
         dl0YxaVsDHl/MIxBLb26WtiY7gbnwUa+rOhHPWZJNGpK3a08NNH+g0g0I0RcCI42bqNX
         WykR5gn+usyT9moj9UpSXv2QpEHO7zdAEBCyyHi7Sjf6YFQwqFHfwJt63+z4Gg0Y9epr
         9KvMlE3eLu2DGHZJ+d0IA7HwBHLMOyCFi62Q+ME9gM0aXxjKJIA56v9A3ZCI8H2dZprP
         lQ/w==
X-Forwarded-Encrypted: i=1; AJvYcCXcRizVwFBuS7I/BhiajvNapGCiQqqOI4qm/0Kpjifl0xrMmxpUQu0/e9FjUhWuQKh7JLKMG29oGlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUejnbyp4p2rNh6FAaug/BCNQEZ5NNclxgv+3dx0/qCUY2C7ST
	LzweuJHDS+in6fkRoc0v1QAfvwasyA1ZPaHjzHPx38327eqJ3VMZgtQm
X-Gm-Gg: AZuq6aLz9yDrOEmWyFJK3pjGRsZaMW+IUp1hdvj95so9XGsWBDlvsQVngybxf/6r/Wx
	Bs1ArDx/RloK2ClO5U5RiMiOiwItYnEyDL9Rq7pbqgVZ5OeqU23eC6q/1b7gjD8njJmGpJ2VfDy
	2kgWjkwri3SV08JyRA9KqFr/rYY5q4S8mohm9kUGzzVLKgRx9tNdVwnj/q2CEX66GbRh4mqOgB4
	WpE8pBI9lDJpCOw4Fb53C34uvqoCzlrZ5zrS1UIdSQMvV1mbcpsu17/VHYmdYq+EYPVPiVTpHf+
	VK+IhDa6fWSZj3oQdwx77zJaT9a6e9ljuVveqjSsnLnY06TGMWbeEe7A2yE5ziQEah8PPL6YwqN
	ZIU4FNWtexohqkvhNI21LJugXaG2cYyEwY8de7vbuOZY3UaQe6UL+F6LQCGjNTBsO8452RIiWWB
	0l4LE2Al6OV3CV9oTqbgM=
X-Received: by 2002:a05:600c:4e50:b0:47e:e2ec:9947 with SMTP id 5b1f17b1804b1-4801e34dfdamr242339415e9.33.1769005217144;
        Wed, 21 Jan 2026 06:20:17 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801e886829sm311971825e9.8.2026.01.21.06.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 06:20:16 -0800 (PST)
Message-ID: <99789eb34873eca976a3324c363a1dc70a2f0d3d.camel@gmail.com>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Rodrigo Alencar
	 <455.rodrigo.alencar@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, rodrigo.alencar@analog.com,
 	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Cameron	
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko	
 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Date: Wed, 21 Jan 2026 14:21:00 +0000
In-Reply-To: <aXChxvlZxKVrOMsW@smile.fi.intel.com>
References: <aW3dxuelYDM67pqZ@smile.fi.intel.com>
	 <texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
	 <aW40ylvMwVhqNQMw@smile.fi.intel.com>
	 <hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
	 <aW5kk6K30Izckvg5@smile.fi.intel.com>
	 <e5lcg5kkey3c6u2l4rlzzpolp7qkudhcofyzcx5s2tjbh2iwkg@js3fisv23zyj>
	 <CAHp75VepcSZo_E4_UxhKRfHrMFDd7huJg14m8=6zVo4ENKFXkA@mail.gmail.com>
	 <vvdk3whhwua73g63eetnmn46t2cpbpkzzkx7m6wsbverp7gcvs@mi7cipis3i4t>
	 <aW-Fai68pk1tAeyY@smile.fi.intel.com>
	 <kmdqcaewxxg7isappgfxuf5ode5fepbywrdriksmvrzmaykcjd@crpr27tt3bmf>
	 <aXChxvlZxKVrOMsW@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-01-21 at 11:52 +0200, Andy Shevchenko wrote:
> On Wed, Jan 21, 2026 at 09:41:25AM +0000, Rodrigo Alencar wrote:
> > On 26/01/20 03:38PM, Andy Shevchenko wrote:
> > > On Tue, Jan 20, 2026 at 01:07:49PM +0000, Rodrigo Alencar wrote:
> > > > On 26/01/20 01:24PM, Andy Shevchenko wrote:
> > > > > On Tue, Jan 20, 2026 at 12:43=E2=80=AFPM Rodrigo Alencar
> > > > > <455.rodrigo.alencar@gmail.com> wrote:
> > > > > > On 26/01/19 07:07PM, Andy Shevchenko wrote:
> > > > > > > On Mon, Jan 19, 2026 at 04:37:09PM +0000, Rodrigo Alencar wro=
te:
> > > > > > > > On 26/01/19 03:42PM, Andy Shevchenko wrote:
> > > > > > > > > On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alencar=
 wrote:
> > > > > > > > > > On 26/01/19 09:31AM, Andy Shevchenko wrote:
> > > > > > > > > > > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo Ale=
ncar via B4 Relay wrote:
>=20
> ...
>=20
> > > > > > > > > > The current implementation is kind of a stripped versio=
n of
> > > > > > > > > > __iio_str_to_fixpoint(). Would you prefer something lik=
e this, then?:
> > > > > > > > >=20
> > > > > > > > > Do they have most of the parts in common? If so, why can'=
t we use
> > > > > > > > > __iio_str_to_fixpoint() directly? Or why can't we slightl=
y refactor
> > > > > > > > > that to give us the results we need here?
> > > > > > > >=20
> > > > > > > > __iio_str_to_fixpoint() only parses "int" chunks, adf41513_=
parse_uhz
> > > > > > > > was modified to accomodate the u64 parsing removing unneces=
sary stuff.
> > > > > > >=20
> > > > > > > But why? The fractional part most likely will be kept int (it=
's up to 10=E2=81=BB=E2=81=B9).
> > > > > > > The integer can be bigger than 10=E2=81=B9?
> > > > > >=20
> > > > > > Correct, integer part of the frequency value goes up to 26.5 GH=
z
> > > > > > (uint_max is approx 4.3 GHz). Also, with the dual modulus, the =
PLL can
> > > > > > achieve micro Hz resolution.
> > > > >=20
> > > > > =C2=B5Hz is not a problem since it's up to nHz.
> > > > > So, the difference so far is the integer part that can be 64-bit.
> > > > > Again, can we factor out something to be used for this and for th=
e
> > > > > __iio_str_to_fixpoint() cases?
> > > >=20
> > > > I am not sure what you are suggesting,
> > >=20
> > > To make changes to reuse the code.
> > >=20
> > > > but I am avoiding changes to iio core at this point.
> > >=20
> > > Why?
> >=20
> > I understood that core changes would require more than one user
> > supporting the change.
>=20
> At least one. And we have tons of them as the callers of
> __iio_str_to_fixpoint() are not going to disappear. Basically it's a surg=
ery in
> the middle of the existing chain of APIs. To me one user is enough justif=
ication
> for such a surgery. For the newly introduced API (imagine __iio_str_to_fi=
xpoint()
> as an example) it's indeed one user not enough.
>=20
> > > > If any other user needs similar behavior,
> > > > I'd say we would need to have __iio_str_to_fixpoint() implementatio=
n
> > > > modified, so to create a version of iio_str_to_fixpoint() that hand=
les
> > > > long long variables. Possibly consuming simple_strtoull instead of
> > > > doing the manual parsing.
> > >=20
> > > That's the problem here. With Yet Another Cool Parser this all become=
s
> > > unmaintainable very soon
> >=20
> > Considering that the need for a new parser for 64-bit parts is only dri=
ven
> > by this specific PLL driver, I wonder how things become that unmaintain=
able.
>=20
> Because there is a duplication of the code (to some extent) and if we fou=
nd
> a bug in the one implementation it will be hard to fix (or even remeber) =
about
> the other.

Agreed!

>=20
> > > (basically as you said when new comer needs a third
> > > variant of it). This is not good. Instead better to create (amend, ex=
pand)
> > > existing test cases, split out a foundation API that parses 64-bit pa=
rts
> > > (maybe even for fractional as well, dunno) and evolve a needed (sub)A=
PI
> > > from it.
> >=20
> > I don't disagree with you though, I suppose I will need a green light t=
o
> > move on with this?
>=20
> Fine with me, let's gather opinions of David, Nuno, Jonathan, and others.


Fine with me.

- Nuno S=C3=A1
