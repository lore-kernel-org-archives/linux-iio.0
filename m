Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F038531690E;
	Sat,  7 Mar 2026 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772887920; cv=none; b=oCEpC73m/ITFMQvwYWAoj9KskI8ZMz0ru5SgJ4SU4SIo8LfL0bG5NMpf4ZzGdMJRuzq9NF8zU56/QLJWUG3UlykSGmP2nbG9zYAFbkZJNUveqFRWgi2sJzi3f7dK6M73Q3jhU8h8LPGJfU/4TBNMPJ6ToZwDS1PxOQ3pj2BQVj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772887920; c=relaxed/simple;
	bh=zrnxquczMl4AiVq2U7Qwo1/64yz1D20rPQoLrQRSf5g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y4/8cVdAnVVQByDEsGVmM7eBiOsvYh1+2g2bF8Bw6qB3GOTd7IqPdL2LOISvkCmlol6h0iOBenOONtyQIOO7XJx+qRSDv2BNww+m8IZf2KomHNhBthOiGWsqKF260VBbNalfTrjg5WyQdUtsu1ZFN8AkjGbjnGbiw7RFVw0uEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIMyck1d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIMyck1d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54529C19422;
	Sat,  7 Mar 2026 12:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772887919;
	bh=zrnxquczMl4AiVq2U7Qwo1/64yz1D20rPQoLrQRSf5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LIMyck1d40pCp9Xiu+IQIIVDbDCnLWQFavqPdfd6LEdUPfR2dEMDNttmOZUB7wqgY
	 l8jMeCxbKc5jdAMhIhpWOSrGuUqI0kFd9WOmxIc3zwI3s1WZnju5ABD9+4IcFLn2u5
	 iVVp2oclkXZTOhbcP0TJTjJR/+B6YLidANh0g8F14/QB/RuC4iigh+zMqU65WhDMUR
	 fxut+70cGEtNC0qjYOXelD+5vd73yvPKS96YI1YbPvbMPLLYY5DQQV+oFg1sfNaatm
	 z6KX5GTcirBhqXmcwuDVa80wyiGQnZDlLy3Hsq+qeM/VAu4VJ6lpN9FvJk6pipmdWE
	 xgUjhGR5v8G5Q==
Date: Sat, 7 Mar 2026 12:51:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Francesco Lavra <flavra@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 4/6] iio: ABI: Add support for floating-point numbers
 in buffer scan elements
Message-ID: <20260307125150.3bc60a45@jic23-huawei>
In-Reply-To: <aarED5TAWg2qFtxi@ashevche-desk.local>
References: <20260304080519.2844101-1-flavra@baylibre.com>
	<20260304080658.2844434-1-flavra@baylibre.com>
	<70f25902-5c79-46f9-8c67-99633b22b5ac@baylibre.com>
	<098886563f5fdcde837989d0556ed9a2d8d3203b.camel@baylibre.com>
	<CAHp75Vdni=OgHiDi8G5s6CgBFZZuypOyJSo5DFjaKYFkLGPqkQ@mail.gmail.com>
	<dd6d1436-d509-4233-ba1f-5a3f870f35fb@baylibre.com>
	<aarED5TAWg2qFtxi@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Mar 2026 14:09:51 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 05, 2026 at 08:37:48AM -0600, David Lechner wrote:
> > On 3/5/26 3:23 AM, Andy Shevchenko wrote: =20
> > > On Thu, Mar 5, 2026 at 11:09=E2=80=AFAM Francesco Lavra <flavra@bayli=
bre.com> wrote: =20
> > >> On Wed, 2026-03-04 at 16:45 -0600, David Lechner wrote: =20
> > >>> On 3/4/26 2:06 AM, Francesco Lavra wrote: =20
> > >>>> In the data storage description of a scan element, the first chara=
cter
> > >>>> after the colon can have the values 's' and 'u' to specify signed =
and
> > >>>> unsigned integers, respectively.
> > >>>> Add 'f' as an allowed value to specify floating-point numbers form=
atted
> > >>>> according to the IEEE 754 standard. =20
>=20
> ...
>=20
> > >>>> -  Format is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift] .
> > >>>> +  Format is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift] .
> > >>>>
> > >>>>    * *be* or *le*, specifies big or little endian.
> > >>>> +  * *f*, specifies if floating-point.
> > >>>>    * *s* or *u*, specifies if signed (2's complement) or unsigned.=
 =20
> > >>>
> > >>> I would keep all of the format options on one bullet point. =20
> > >>
> > >> That's what I did initially, but Andy suggested doing differently [1=
]. =20
> > >=20
> > > And still I think it's better to not mix them. The floating in the
> > > same sentence is confusing (along with 2's complement mention and
> > > sign). =20
> >=20
> > Then I would split up all 3. It is strange to mix some and not
> > all. =20
>=20
> I don't find it 'strange'. The integer are grouped together, floats do not
> belong to that group.
Maybe two paragaraphs in one bullet point?
	* *f*, specifies if floating-point.
	  *s* or *u*, specifies if signed (2's complement) or unsigned. =20

Though then we'll definitely need to check it didn't break the formatting
in the docs generated from these files.

For me any of the above are fine.

=09
>=20
> ...
>=20
> > >>>> -is [be|le]:[s|u]bits/storagebits[Xrepeat][>>shift], where:
> > >>>> +is [be|le]:[f|s|u]bits/storagebits[Xrepeat][>>shift], where:
> > >>>>
> > >>>>  - **be** or **le** specifies big or little-endian.
> > >>>> +- **f** specifies if floating-point.
> > >>>>  - **s** or **u** specifies if signed (2's complement) or unsigned=
. =20
> > >>>
> > >>> same here =20
> > >>
> > >> [1] https://lore.kernel.org/linux-iio/aZ7dCdLs5xcJ4UGW@smile.fi.inte=
l.com/ =20
> > >=20
> > > Same here. =20
>=20

