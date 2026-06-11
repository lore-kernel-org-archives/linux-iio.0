Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B703A8730;
	Thu, 11 Jun 2026 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781197058; cv=none; b=rnguvk05ejGY48yJDBZ5dimVMGDPOnXAJPpsBhOgJN3O3CAw6pzeZmQUBaIr2KUPsiyC+ZpH4hSAGZhPzkG/vcIc279FpYj7hF2q2iCfV+rnu1LerrJXMOhlOqocjAgN9rR0OZEmyfoyF0Xlb0HUTE/Bshi1eUfvgco/94jm6qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781197058; c=relaxed/simple;
	bh=ju3frxCuX47EVbO34+foUxxrb6uvwoLEqG1gXq1dFq4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDPZa98g3Iz5+wuHFg2jHimAV+3n+HPLgWX8FqJZvGo18BobQMaujwfIbVHwTDHjGMd7bjZBK3CexyLJ4eDoblE1QQSQFi/AFNdB7XL8owTQfa9GCnlwlHFl+6SdagF0i+GQB0Q3I00x5iQeHYsjbpp3XHc1irgSYWbF3R3Bg8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk5neRmg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk5neRmg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B0B1F00893;
	Thu, 11 Jun 2026 16:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781197056;
	bh=5J+Qcluqlu/9IAvqNc9qIGS3Z+PkmdQBkuvtGSTT/mU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tk5neRmgDPlVDBhAQI4HBa8m4c1iuxlcMp1LzqsL9JmmiLfDtg3TapaKlZnrTICcw
	 /dBEExpqpwuGfqpITfZCaoQmIDaIwuSNTQtf0Fu6dR5rUwAKUmfQBtDR0UAVX3n6rt
	 TfgU5xt1hMCa/v5wn12XANmSYHg7yV3aCDlSAJ+SjMsUVfVKMZvdgdTWjZLsCLfqVY
	 KOSKc8MvAw/NYDr5gi2XWtPnuFl9aKJnqp71WEzhsVELRgmKxC3Se1d0fQxb06kM4a
	 6iuDBuAR5c4fT6ytXNYvn4rYlNj46fcEJTLsk1j74i2j+e4oiE7tzpSlz+x5WXsOho
	 EWdvTNRf51OAA==
Date: Thu, 11 Jun 2026 17:57:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tomasz =?UTF-8?B?RHVzennFhHNraQ==?= <tduszyns@gmail.com>
Cc: Maxwell Doose <m32285159@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
Message-ID: <20260611175728.738ac9c3@jic23-huawei>
In-Reply-To: <CAObtm8zDk4s3+pmGSxRoVHq7ef1y=_cHdC8YRH6ycRNbjzaNkg@mail.gmail.com>
References: <20260609160326.45123-1-m32285159@gmail.com>
	<20260609160326.45123-3-m32285159@gmail.com>
	<20260610-pastoral-dark-ostrich-5ca3f6@quoll>
	<CAKqfh0Hi8EkShh3s4dUqAJRDExQLR0NVOvd4An+bY5hat4-Lhw@mail.gmail.com>
	<e00caff5-55e4-428f-bc57-3885699b221c@kernel.org>
	<aipatjyVcltbspRJ@ashevche-desk.local>
	<6c5a657b-f316-4982-8cb8-8c09f1b1669a@kernel.org>
	<aipfPwT4RJGdA4TT@ashevche-desk.local>
	<aipfxL3ttO1-7W1T@ashevche-desk.local>
	<CAKqfh0FQb6tSZrrTHGWcoQqPe-OwD-mW02GOOn9y+ysstRPVzA@mail.gmail.com>
	<CAObtm8zDk4s3+pmGSxRoVHq7ef1y=_cHdC8YRH6ycRNbjzaNkg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 11 Jun 2026 15:41:44 +0200
Tomasz Duszy=C5=84ski <tduszyns@gmail.com> wrote:

> Hi,
>=20
> I've been trying to catch up on the recent discussion. A few things I
> want to address:
>=20
Hi Tomasz,

> 1. My email is active and I do read patches (when CCd), but by the
> time I have a proper slot to sit down and review something, it's
> usually already gone through several rounds.
> Chiming in at that point just for the sake of it doesn't add much value i=
mo.

On this, if you want to take a look at a patch but are busy at the time
(happens to all of us!) then feel free to just reply to say that
is the case. Most stuff isn't urgent enough and I do take things a bit
quickly sometimes (driven by desire to keep the queue manageable!)

>=20
> 2. I get the impression you're thinking that since I'm not actively
> maintaining these drivers, you can step in and take ownership. I'm
> broadly fine with that, but I'd want to see more work and patches
> coming from you first. If that happens, we can revisit the ownership
> question. That said, do you actually have these sensors on hand to
> test more invasive changes? If you've already answered that just skip
> it as I'll probably stumble upon it whilst going through overdue
> mails.
>=20

This was driven by some confusion and I think a bounce on a different
email address (octakon).  For the scd30, would you mind if we put you
back (can be along side Maxwell who stepped up because the original
suggestion was to mark it orphaned) with this email address?

> 3. I've managed to carve out some extra time lately, so I'm happy to
> be more involved with reviews going forward if that's useful.

Excellent!

>=20
> In the meantime I'll go through the remaining emails to get better contex=
t.
>=20
> On Thu, Jun 11, 2026 at 2:23=E2=80=AFPM Maxwell Doose <m32285159@gmail.co=
m> wrote:
> >
> > On Thu, Jun 11, 2026 at 2:12=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@intel.com> wrote: =20
> > >
> > > On Thu, Jun 11, 2026 at 10:09:57AM +0300, Andy Shevchenko wrote: =20
> > > > On Thu, Jun 11, 2026 at 08:58:47AM +0200, Krzysztof Kozlowski wrote=
: =20
> > > > > On 11/06/2026 08:50, Andy Shevchenko wrote: =20
> > > > > > On Thu, Jun 11, 2026 at 08:37:33AM +0200, Krzysztof Kozlowski w=
rote: =20
> > > > > >> On 11/06/2026 00:24, Maxwell Doose wrote: =20
> > > > > >>> On Wed, Jun 10, 2026 at 4:09=E2=80=AFAM Krzysztof Kozlowski <=
krzk@kernel.org> wrote: =20
> > > > > >>>> On Tue, Jun 09, 2026 at 11:03:26AM -0500, Maxwell Doose wrot=
e: =20
> > > > > >>>>> Tomasz's entry is no longer valid, as he is not active anym=
ore. Add =20
> > > > > >>>>
> > > > > >>>> Why is not longer valid? I see activity in Feb... =20
> > > > > >>>
> > > > > >>> Strange. According to git log --author=3D"Tomasz Duszynski" l=
ast commit
> > > > > >>> I have from him is 2023. We also did have an RFC open for a m=
onth on
> > > > > >>> linux-iio with Tomasz Cced with no response. =20
> > > > > >>
> > > > > >> So you did not check enough... and no one needs to read RFC :/=
 =20
> > > > > >
> > > > > > Hmm... lore.kernel.org shows last activity November last year (=
07-11-2025).
> > > > > > What other sources do you suggest to check? =20
> > > > >
> > > > > No, only lore. =20
> > > >
> > > > I used this request:
> > > > https://lore.kernel.org/all/?q=3Df%3A%22Tomasz+Duszynski%22
> > > > =20
> > > > > As I said, February this year.
> > > > >
> > > > > https://lore.kernel.org/all/CAObtm8zKUAWNS23nRMhc9ZR-zn7xeVOFPiV4=
ai_x7Bkd5puiyA@mail.gmail.com/ =20
> > > >
> > > > Okay, you used UTF-8 name, Where did you get it from? MAINTAINERS h=
as no
> > > > diacritics. =20
> > >
> > > OTOH, you may have used simply email approach. With
> > > https://lore.kernel.org/all/?q=3Df%3Atduszyns%40gmail.com
> > > I got it as well. =20
> >
> > Ok, now I see it. I will say though that we've emailed Tomasz at least
> > 10 times at this point for various things and hasn't responded to even
> > one :/ if we need to we can allow Jonathan to chime in. =20
>=20
>=20
>=20

