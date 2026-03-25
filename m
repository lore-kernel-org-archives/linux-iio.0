Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8977372670;
	Wed, 25 Mar 2026 14:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774447609; cv=none; b=dBc0QymmIfK3by17MJhLE6gy00foqYh4tWSA7duaP064k1kBjVMco1gmrtXWcWwQN848ZoFgip3Zr0ZLsgdx4Gjt6NXalLYbeK3HTR2xX7iTdaO/56oCO/2L5J6+2Htf0v7E69a3aFIX40EWIg8OMoI7enyCBfBqMNJSJjn6A44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774447609; c=relaxed/simple;
	bh=DEYpTaNunbjC4iWnem1Kupd0V7h5J3IaGpb9FI2MAIo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhhGFx7PiVQBqIwM2xl1sX/vw7CB4kElKvUmOHc13KJ7uIgVcILbuM/e92pAIVi7B8b1/16EkPBiCBj5bybJBTxZDRjlob5aWqUUjEIQZNm3CttdDQ5TrX99MMO2kTAVxe4U6Kz/gEX6hFqJj69ikMZvPLbm7beWQrnJ1649ejE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.150])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fgpc21sP7zJ46FB;
	Wed, 25 Mar 2026 22:06:26 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id DDAB54056A;
	Wed, 25 Mar 2026 22:06:34 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 25 Mar
 2026 14:06:34 +0000
Date: Wed, 25 Mar 2026 14:06:33 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Sirat <email@sirat.me>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
Message-ID: <20260325140633.0000059c@huawei.com>
In-Reply-To: <f27bfbe4-aa90-4631-b96b-efb8465b05d4@kernel.org>
References: <20260325063254.18062-1-email@sirat.me>
	<20260325063254.18062-2-email@sirat.me>
	<20260325-gentle-earthworm-of-progress-1f9f46@quoll>
	<CANn+LW+Y6j0xk2x02-BUL9qNq2gf-PXspi4wP_KGd7Abz3hOYw@mail.gmail.com>
	<4d10b6c0-d599-4fc5-b9ed-ce669ac46e84@kernel.org>
	<CANn+LWJQM45rAT+mzS9ZEGBgmqChbxUtStdzhbzthXUPJ=2csg@mail.gmail.com>
	<20260325133806.00007b68@huawei.com>
	<f27bfbe4-aa90-4631-b96b-efb8465b05d4@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Wed, 25 Mar 2026 14:44:13 +0100
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On 25/03/2026 14:38, Jonathan Cameron wrote:
> > On Wed, 25 Mar 2026 15:18:05 +0600
> > Sirat <email@sirat.me> wrote:
> >  =20
> >> On Wed, Mar 25, 2026 at 2:58=E2=80=AFPM Krzysztof Kozlowski <krzk@kern=
el.org> wrote: =20
> >>>
> >>> On 25/03/2026 09:48, Sirat wrote:   =20
> >>>> On Wed, Mar 25, 2026 at 2:05=E2=80=AFPM Krzysztof Kozlowski <krzk@ke=
rnel.org> wrote:   =20
> >>>>>
> >>>>> On Wed, Mar 25, 2026 at 12:32:22PM +0600, Siratul Islam wrote:   =20
> >>>>>> Add device tree binding documentation for the STMicroelectronics
> >>>>>> VL53L1X Time-of-Flight ranging sensor connected via I2C.
> >>>>>>
> >>>>>> Make vdd-supply required. The device requires power to operate
> >>>>>> and the property should have been required from the start.   =20
> >>>>>
> >>>>> That's ABI break and device for many years was working fine, so this
> >>>>> should not be changed.
> >>>>>   =20
> >>>> Jonathan and David asked that vdd-supply be made required. I feel li=
ke
> >>>> there is a conflict here that I am not able to resolve myself.
> >>>>
> >>>> What I think about it is the binding does not correctly describe the
> >>>> hardware and we should consider this a bug and fix it.
> >>>> The driver worked because of a fallback mechanism (dummy/fake
> >>>> regulator) and not because power was optional.
> >>>>   =20
> >>>
> >>>
> >>> I looked at v6 and v5 and I do not see such comment for binding that
> >>> existing device should change ABI. Can you point me to it?
> >>>   =20
> >> "Make it required and add a note to the commit message to say why the
> >> requirement should always have been there. Devices tend not to work
> >> with no power." - Jonathan (v3:
> >> https://lore.kernel.org/linux-iio/20260322115704.10b2e0d4@jic23-huawei)
> >>
> >> "No, bindings should not depend on driver implementation." - David
> >> (When I asked if I should  drop the hard requirement in the binding,
> >> v6: https://lore.kernel.org/linux-iio/55e92148-b5de-4fb8-af0b-94762353=
41bc@baylibre.com/)
> >>
> >> "From the point of view of the devicetree, it doesn't matter what the
> >> driver does. It matters that the chip can't work without power. ;-)" -
> >> David (v1: https://lore.kernel.org/linux-iio/d0ec6a2f-6d30-4774-8950-1=
5dd3c4b020b@baylibre.com)
> >>
> >> I'm not sure if this is the correct way to quote. But I have added the=
 links. =20
> >=20
> > This came up a few years back - though I doubt I can track down the
> > exact discussion however.
> >=20
> > From a Linux point of view we are breaking binding checks only if the
> > supply (that should always have been there as chips tend not to work
> > well without power) is not present.  We absolutely have to
> > keep the driver running whether or not the supply is specified.
> > Do other DT users provide such a constraint? I've no idea.
> >=20
> > If the DT maintainer preference is leave it not required (perhaps
> > with a comment saying new users of the binding should supply it)
> > then that's fine by me. I'll keep it in mind for future similar changes=
. =20
>=20
> If this was other ABI, e.g. clock, then answer would be - do not require
> it, because that's ABI break. Therefore I would stick to that also to
> regulators. Once Rob also expressed such thoughts, although noting that
> it is not that big deal.
>=20
> New device in this binding of course should require the supply.
Seems my memory was less than perfect on this :=20
https://lore.kernel.org/linux-iio/20241119140409.GA1093349-robh@kernel.org/=
#t

Rob expressed that we are inconsistent on this, but he'd rather not
have regulators as a special case.

So let's only make this required for the new device.=20

Thanks,

J

>=20
> Best regards,
> Krzysztof
>=20

