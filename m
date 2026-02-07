Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30D332EB5;
	Sat,  7 Feb 2026 16:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770483589; cv=none; b=fRaZFG3Rwy20owUqI39qg4PSkrr3irWZYwxc1p2W/kNuWlb3+skgv0S6RVHGeCr+5iUFbYyRIb39w6gAjjtL3/prWEN5SBedqyv3DIED9u266P2aBukLJFa1zBo0FivYcl3NeVO0WZpBJ3Yzgj44h0oupn480EBpQdj7dwY+I6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770483589; c=relaxed/simple;
	bh=PHvLWFRxlqO1CmD8vcd7RCrm1+V+balcd29X2sSmIQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AzYIMP4Zcrk86+r5P4zr6l3HND1DTlDWvv4EPOYombXIsOCq35D7OIrvvIloaf6lKFmuIFSU5m0sOMRwrIWsLYdnLipPSr6vUGGBHSE9wIZyJKTvfvLnF9YsROUAHqX5Te7hhhuYws1Wvwl/IBKbbLqqJXtWh/MavYrIp7PNDNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTAveMUT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTAveMUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F11C116D0;
	Sat,  7 Feb 2026 16:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770483588;
	bh=PHvLWFRxlqO1CmD8vcd7RCrm1+V+balcd29X2sSmIQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PTAveMUTBqQDg2iDp3KZi+YP6mcIdG3rioQCUS2nEkJqAfPXsj9eQdJt5QFTPpP/b
	 +qz3KOO7ESggD5hqHAk+j8yRFR0Ksbt8CB8g60y0v9ewSGrzjChxqoSrAHT4V8Kx+w
	 ATCrVXNLuLs8tVBL/J7Volq8p4GRtY52cAVNWD4JRWZjpzSlr34VSvSmpxZ1i90b/V
	 W+1lfdNVLnARjJUYlk7qJxu66BhTRub90HUoUvwoDSaXKHmLUVaWEj6bcl5N0OFtF3
	 njo4WDZ0gL1MH1BKwoLKovgXKQjzpedQssRzMm41v8iwPhqYyY7KuO1MMretAPM/1I
	 y5j0lIFYLldZA==
Date: Sat, 7 Feb 2026 16:59:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
 rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko	 <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich	 <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 2/8] iio: core: add fixed point parsing with 64-bit
 parts
Message-ID: <20260207165938.59d6895f@jic23-huawei>
In-Reply-To: <c4efbcda461cdfd58c7a7ab8b8c29c5f47fbda01.camel@gmail.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	<20260130-adf41513-iio-driver-v6-2-cf46239026bc@analog.com>
	<eb1d9b939f95888739ce4a70f516cec07393c6df.camel@gmail.com>
	<nzowa6uhnlcllceml2pqjk4so33kl3rf2jwu36eh3znnxug6ub@gfzafmi3m5re>
	<c4efbcda461cdfd58c7a7ab8b8c29c5f47fbda01.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 03 Feb 2026 10:04:01 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2026-02-03 at 09:26 +0000, Rodrigo Alencar wrote:
> > On 26/02/02 09:57AM, Nuno S=C3=A1 wrote: =20
> > > On Fri, 2026-01-30 at 10:06 +0000, Rodrigo Alencar via B4 Relay wrote=
: =20
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > >=20
> > > > Add iio_str_to_fixpoint64() function that leverages simple_strtoull=
()
> > > > to parse numbers from a string.
> > > > A helper function __iio_str_to_fixpoint64() replaces
> > > > __iio_str_to_fixpoint() implementation, extending its usage for
> > > > 64-bit fixed-point parsing. =20
> >=20
> > ...
> >  =20
> > > > =C2=A0/**
> > > > =C2=A0 * __iio_str_to_fixpoint() - Parse a fixed-point number from =
a string
> > > > =C2=A0 * @str: The string to parse
> > > > @@ -895,63 +1026,43 @@ static ssize_t iio_read_channel_info_avail(s=
truct device *dev,
> > > > =C2=A0static int __iio_str_to_fixpoint(const char *str, int fract_m=
ult,
> > > > =C2=A0				 int *integer, int *fract, bool scale_db)
> > > > =C2=A0{
> > > > -	int i =3D 0, f =3D 0;
> > > > -	bool integer_part =3D true, negative =3D false;
> > > > +	s64 integer64, fract64;
> > > > +	int ret;
> > > > =C2=A0
> > > > -	if (fract_mult =3D=3D 0) {
> > > > -		*fract =3D 0;
> > > > +	ret =3D __iio_str_to_fixpoint64(str, fract_mult, &integer64, &fra=
ct64,
> > > > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 scale_db);
> > > > +	if (ret)
> > > > +		return ret; =20
> > >=20
> > > I know it feels tempting to do the above while adding the 64bit varia=
nt. But isn't the
> > > overflow safety also an issue on the 32bit variant? IMO, we should fi=
rst have a patch
> > > adding the overflow safety with a Fixes tag and then add 64bit suppor=
t. =20
> >=20
> > I think handling 64-bit support after taclking the overflow issue
> > would require changes on top of previous ones, which might get a messy
> > commit history, no? Mostly because the 64-bit variant of the function
> > is being used inside the 32-bit one. Also, the added auxiliary function
> > that implements the overflow check parses u64, which allowed for the
> > removal of the while loop in the __iio_str_to_fixpoint() implementation=
. =20
>=20
> Typically we do fixes before because we might want to backport them and w=
e just want to backport the
> fix (so not the 64bit support). But we never really had any known issues =
with the current API
> (AFAIK) so it might be ok as-is. Will defer to Jonathan.

When we say overflow, I assume we just get the wrong value?  If so
then I doubt anyone ever noticed it.  Worth tidying up as a useability
improvement but not sure it's worth back porting.

Jonathan

>=20
> - Nuno S=C3=A1
> > before this assignment.
> > =C2=A0 =20

