Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE863E63B7;
	Wed, 25 Mar 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774450927; cv=none; b=ToI9KZYqNkbme/mqE3OsgrG/NVDhACLH4bEsl/eDmtJsyixtYy06g/+4Jw+Go/OFEW/yiuZpkZyt/uqD9h/dSOIsGa8XG2gOavxD8rdWBp/EePEyBJDNcqEmTjSSTsv5tvnOM3uChlgsWeGsgHkrh35p7HdOL6XKeSkyv0lFNhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774450927; c=relaxed/simple;
	bh=DxdQ77nCASc6jDoVDE5avAvW8b84dFl6QPJEHn21+Z0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qI8S7iQLAQRN6pFbquZ94K24qqSZozc4FPuMhAWN9q6LSacZyWHGBQQZ4BByrBZwwE3zbWcZVBkfj/sL4U8m8kQn/uO9bZp/X0UFQnIKXLM2nC1PWl71gd9/bvySQGhzQLCg5d7JIIJsYBe3qqrgCTg4rSHBPd9ss+OB3sVeT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.107])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgqqV1l0bzHnGhV;
	Wed, 25 Mar 2026 23:01:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id BF2FB40584;
	Wed, 25 Mar 2026 23:02:01 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 15:02:00 +0000
Date: Wed, 25 Mar 2026 15:01:59 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Sirat <email@sirat.me>
CC: Krzysztof Kozlowski <krzk@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
Message-ID: <20260325150159.00004c3e@huawei.com>
In-Reply-To: <CANn+LW+X5puvzY+cKYKAbWY6L2d_0P_2AZxuRkwH7ngc6T-vJA@mail.gmail.com>
References: <20260325063254.18062-1-email@sirat.me>
	<20260325063254.18062-2-email@sirat.me>
	<20260325-gentle-earthworm-of-progress-1f9f46@quoll>
	<CANn+LW+Y6j0xk2x02-BUL9qNq2gf-PXspi4wP_KGd7Abz3hOYw@mail.gmail.com>
	<4d10b6c0-d599-4fc5-b9ed-ce669ac46e84@kernel.org>
	<CANn+LWJQM45rAT+mzS9ZEGBgmqChbxUtStdzhbzthXUPJ=2csg@mail.gmail.com>
	<20260325133806.00007b68@huawei.com>
	<f27bfbe4-aa90-4631-b96b-efb8465b05d4@kernel.org>
	<20260325140633.0000059c@huawei.com>
	<CANn+LW+X5puvzY+cKYKAbWY6L2d_0P_2AZxuRkwH7ngc6T-vJA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Mar 2026 20:38:48 +0600
Sirat <email@sirat.me> wrote:

> On Wed, Mar 25, 2026 at 8:06=E2=80=AFPM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Wed, 25 Mar 2026 14:44:13 +0100
> > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > =20
> > > On 25/03/2026 14:38, Jonathan Cameron wrote: =20
> > > > On Wed, 25 Mar 2026 15:18:05 +0600
> > > > Sirat <email@sirat.me> wrote:
> > > > =20
> > > >> On Wed, Mar 25, 2026 at 2:58=E2=80=AFPM Krzysztof Kozlowski <krzk@=
kernel.org> wrote: =20
> > > >>>
> > > >>> On 25/03/2026 09:48, Sirat wrote: =20
> > > >>>> On Wed, Mar 25, 2026 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krz=
k@kernel.org> wrote: =20
> > > >>>>>
> > > >>>>> On Wed, Mar 25, 2026 at 12:32:22PM +0600, Siratul Islam wrote: =
=20
> > > >>>>>> Add device tree binding documentation for the STMicroelectroni=
cs
> > > >>>>>> VL53L1X Time-of-Flight ranging sensor connected via I2C.
> > > >>>>>>
> > > >>>>>> Make vdd-supply required. The device requires power to operate
> > > >>>>>> and the property should have been required from the start. =20
> > > >>>>>
> > > >>>>> That's ABI break and device for many years was working fine, so=
 this
> > > >>>>> should not be changed.
> > > >>>>> =20
> > > >>>> Jonathan and David asked that vdd-supply be made required. I fee=
l like
> > > >>>> there is a conflict here that I am not able to resolve myself.
> > > >>>>
> > > >>>> What I think about it is the binding does not correctly describe=
 the
> > > >>>> hardware and we should consider this a bug and fix it.
> > > >>>> The driver worked because of a fallback mechanism (dummy/fake
> > > >>>> regulator) and not because power was optional.
> > > >>>> =20
> > > >>>
> > > >>>
> > > >>> I looked at v6 and v5 and I do not see such comment for binding t=
hat
> > > >>> existing device should change ABI. Can you point me to it?
> > > >>> =20
> > > >> "Make it required and add a note to the commit message to say why =
the
> > > >> requirement should always have been there. Devices tend not to work
> > > >> with no power." - Jonathan (v3:
> > > >> https://lore.kernel.org/linux-iio/20260322115704.10b2e0d4@jic23-hu=
awei)
> > > >>
> > > >> "No, bindings should not depend on driver implementation." - David
> > > >> (When I asked if I should  drop the hard requirement in the bindin=
g,
> > > >> v6: https://lore.kernel.org/linux-iio/55e92148-b5de-4fb8-af0b-9476=
235341bc@baylibre.com/)
> > > >>
> > > >> "From the point of view of the devicetree, it doesn't matter what =
the
> > > >> driver does. It matters that the chip can't work without power. ;-=
)" -
> > > >> David (v1: https://lore.kernel.org/linux-iio/d0ec6a2f-6d30-4774-89=
50-15dd3c4b020b@baylibre.com)
> > > >>
> > > >> I'm not sure if this is the correct way to quote. But I have added=
 the links. =20
> > > >
> > > > This came up a few years back - though I doubt I can track down the
> > > > exact discussion however.
> > > >
> > > > From a Linux point of view we are breaking binding checks only if t=
he
> > > > supply (that should always have been there as chips tend not to work
> > > > well without power) is not present.  We absolutely have to
> > > > keep the driver running whether or not the supply is specified.
> > > > Do other DT users provide such a constraint? I've no idea.
> > > >
> > > > If the DT maintainer preference is leave it not required (perhaps
> > > > with a comment saying new users of the binding should supply it)
> > > > then that's fine by me. I'll keep it in mind for future similar cha=
nges. =20
> > >
> > > If this was other ABI, e.g. clock, then answer would be - do not requ=
ire
> > > it, because that's ABI break. Therefore I would stick to that also to
> > > regulators. Once Rob also expressed such thoughts, although noting th=
at
> > > it is not that big deal.
> > >
> > > New device in this binding of course should require the supply. =20
> > Seems my memory was less than perfect on this :
> > https://lore.kernel.org/linux-iio/20241119140409.GA1093349-robh@kernel.=
org/#t
> >
> > Rob expressed that we are inconsistent on this, but he'd rather not
> > have regulators as a special case.
> >
> > So let's only make this required for the new device.
> > =20
> So since it is a new device, how do I require this? should we split to
> a new binding (like I had in v1) and make that required. That would
> also allow us to correctly name the xshut pin.
>=20
> Or do we do the "allOf:" exclusion? In that case, I think it wouldn't
> make sense to someone reading the binding without the context of
> commit history, as it would imply one of the devices explicitly
> doesn't need power.
This + add a comment that it's only not required for other devices
for backwards compatibility reasons.

>=20
> I'm willing to do whichever is prefered tough and move this forward.
> >
> > =20
> Thanks,
>=20
> Sirat

