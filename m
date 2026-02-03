Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD9539B4BB
	for <linux-iio@vger.kernel.org>; Tue,  3 Feb 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770113004; cv=none; b=RnIZ6367H2aPVw3Ww6c4BHKm+TZUd6IXLW4BNLi5ofj/0c6kxK5Q4jnFQowBSNs7DpPgVtarUcxco1HqLK0BhvySQ3nD57sueq8qHK90/iX/zLrYd38LulQG2iJT1Iku4EweXbRUKfem3lmKcpa6PT1F1stLjgGZqq+lSTSWOzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770113004; c=relaxed/simple;
	bh=ao5SwoLNTIiHJURJeN/qxgiD0uarUaiktckItiBuuxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CQGFvMphxhx9pwxv/FEmhTKlcPOgjlFLKtjdyTR4dKrBNfsCGsZSTWW8vtU/47fh6qWp34Wq6ZqY3qjErzinzqAnthe4IupMP1SCRrlFGGnzqwd+ua+r0DtG8UKI/GBeCVg14nyEA4t6MpQD+4X1e5knM1wzzUDS0/wPteEUh2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gdIPF3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gdIPF3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb4eeb482so3750707f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 03 Feb 2026 02:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770112999; x=1770717799; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9t5Fe5bGozogr0ZNYAWcRlOMGPdLPrptTIS9SavKeiw=;
        b=Q+gdIPF3SmpI+vGeoYLyresfGoXQJErwLP4kt0vS7MHbHziBXkiMJr4FGSgqTg3Ba2
         kYlDInqM//a5uMC4b+BFNwDQ1xhlKT5hFw0ESwENUKUyvnind9qlcMAkhn37VDPfYruZ
         rI2JA35kbaqVw02DEAqEeJCjf+GnST5hjsQtlz2k1Hye41gYF15v4mvTVBBu0WoI9qRE
         bx1i+yj6Fo0v1J4E/qDHIPrVE9AX+MkJndllfCIG1ZJ84uskaOXhONfTmZrEXIptq9VM
         QrrBU1TBFPdNSaAhJa3CzYgpiI6BREvOM1nCKtnzLK2+/Dc0nbLQ/y9yUUJUsSq/+7lQ
         MsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770112999; x=1770717799;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9t5Fe5bGozogr0ZNYAWcRlOMGPdLPrptTIS9SavKeiw=;
        b=Q9L4SeByiPf6Q64IG5X+ZjsNCmTLG3ltRLF58pYggDR5S/UysySew0w0B0atRztzjX
         VDpVk8I0oeTmMuKvXSGulf6em5ZMWV6f7ZRqQrPasqxdFcePsCCkPbNwZhupEPWzNyGH
         V9+sBQ8qxp6vjnkC4U4PVF2TNjeK3TlHeMoTat7vvyaDp60Wh3VLZwghDzJz2eifrOuM
         SEMgbJluFPFjDRemygmAYe0JdGNei3JrVh4/vVlVJTmJ/cnZEI+fKUjDxtR5lRErPYDs
         lu4RMh1otjMsEQPvnKjmVzM5jmsVi6lyr+99GrGxYcjWf77dbTsfAuOUmn6turXe18FM
         vJtQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/cLKpyio7lgbg+J6IJ982wKpEmW7LUFgD1Ad5PJhZ3gnEdHwQD15NcTyUDm9G2LQDSKYdu4WVmJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE5j/mv3cGcsfVmoHkhRg9JLRKiSZovsDuBXEOddoNv4Bk8+zQ
	QmYdu+zt2mD8yXHRTnu+0Ql15bMCVsl8YLQY8ptdcOb7KjhB1WRa59+qT9U+mEfn
X-Gm-Gg: AZuq6aIcoryh2giK7162f/OI3CyrqoBtK8ER5PVxU9ny+ppECt9QboHpcpYBcsWC4re
	pIDWp1IEMT+TvvQ1yICklJVBrK2bRp1z5Q+aes5CGbAcFz+vBrUE+ijhKpY26k04VkzKYKFOOj8
	uL2ftx0Ei8Xm8cPlrYyw8kR8QSfflm3MiFYclV9yMxk51X+NS3kOEo83lc9BdFhlepGvZEtOLeo
	fcpfKFcb5g5YodKnBDwiynH+rrfua21+lCT0kiNy4ug4ofD8rU+nRjq34RS6ltWANGLAuD/LsRV
	Gt39MPw46MsuQBqVkNHGEHj2Dxb2lMO//QBBYAwwaXWrTmHsJ/k8JPlL0FfnvdkEaAB2C0k5W3g
	T7ASaOPchCcZE3uTgsXZS3ML4u0RYPcan3oYMQky/NFxP7JBcvf7/DT7wRkTXicUiUauKIx8jkw
	pS26Ygsj15lBxyVJuaYgT7Q1XjU/1Tuw==
X-Received: by 2002:a05:6000:1ac8:b0:432:c37c:d83a with SMTP id ffacd0b85a97d-435f3a86321mr22562027f8f.15.1770112999096;
        Tue, 03 Feb 2026 02:03:19 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e135422csm52922361f8f.40.2026.02.03.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 02:03:18 -0800 (PST)
Message-ID: <c4efbcda461cdfd58c7a7ab8b8c29c5f47fbda01.camel@gmail.com>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>, 
	rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>,  Andy Shevchenko	 <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Date: Tue, 03 Feb 2026 10:04:01 +0000
In-Reply-To: <nzowa6uhnlcllceml2pqjk4so33kl3rf2jwu36eh3znnxug6ub@gfzafmi3m5re>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	 <20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
	 <eb1d9b939f95888739ce4a70f516cec07393c6df.camel@gmail.com>
	 <nzowa6uhnlcllceml2pqjk4so33kl3rf2jwu36eh3znnxug6ub@gfzafmi3m5re>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-03 at 09:26 +0000, Rodrigo Alencar wrote:
> On 26/02/02 09:57AM, Nuno S=C3=A1 wrote:
> > On Fri, 2026-01-30 at 10:06 +0000, Rodrigo Alencar via B4 Relay wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > >=20
> > > Add iio_str_to_fixpoint64() function that leverages simple_strtoull()
> > > to parse numbers from a string.
> > > A helper function __iio_str_to_fixpoint64() replaces
> > > __iio_str_to_fixpoint() implementation, extending its usage for
> > > 64-bit fixed-point parsing.
>=20
> ...
>=20
> > > =C2=A0/**
> > > =C2=A0 * __iio_str_to_fixpoint() - Parse a fixed-point number from a =
string
> > > =C2=A0 * @str: The string to parse
> > > @@ -895,63 +1026,43 @@ static ssize_t iio_read_channel_info_avail(str=
uct device *dev,
> > > =C2=A0static int __iio_str_to_fixpoint(const char *str, int fract_mul=
t,
> > > =C2=A0				 int *integer, int *fract, bool scale_db)
> > > =C2=A0{
> > > -	int i =3D 0, f =3D 0;
> > > -	bool integer_part =3D true, negative =3D false;
> > > +	s64 integer64, fract64;
> > > +	int ret;
> > > =C2=A0
> > > -	if (fract_mult =3D=3D 0) {
> > > -		*fract =3D 0;
> > > +	ret =3D __iio_str_to_fixpoint64(str, fract_mult, &integer64, &fract=
64,
> > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scale_db);
> > > +	if (ret)
> > > +		return ret;
> >=20
> > I know it feels tempting to do the above while adding the 64bit variant=
. But isn't the
> > overflow safety also an issue on the 32bit variant? IMO, we should firs=
t have a patch
> > adding the overflow safety with a Fixes tag and then add 64bit support.
>=20
> I think handling 64-bit support after taclking the overflow issue
> would require changes on top of previous ones, which might get a messy
> commit history, no? Mostly because the 64-bit variant of the function
> is being used inside the 32-bit one. Also, the added auxiliary function
> that implements the overflow check parses u64, which allowed for the
> removal of the while loop in the __iio_str_to_fixpoint() implementation.

Typically we do fixes before because we might want to backport them and we =
just want to backport the
fix (so not the 64bit support). But we never really had any known issues wi=
th the current API
(AFAIK) so it might be ok as-is. Will defer to Jonathan.

- Nuno S=C3=A1
> before this assignment.
> =C2=A0
