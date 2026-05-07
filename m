Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C703EAC74;
	Thu,  7 May 2026 10:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778150137; cv=none; b=cqv/JTlBmA+vns2aKUM1zidCU6CYy5gQhpL+MK3D3247XAM2kHNSaSqCS+WQcffzLUbWWuiD4gdb4h9gh2/Tdk377ViSGk7XEWBkl8qktdvDPZYskeR4Pmh9lbQYPfKjUD059+zroCuJIOpvuP6kpMARvMZyBPYakN9T316+6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778150137; c=relaxed/simple;
	bh=f8iiIV+47WQMkhQVHjg2kccIWpWfcLf7fo/8BzKawrY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnLDcvu8CElmlcmWdqRqdL/Opwxrt6971Z9sdr6UGqo4WYqensDTBNrZGYVKcsDtUQmDrJhwjhCUuLDsc0TbJNqa51iPf5dtIQpyeUw1Koq834/zuUIK3HMjeMr2np1Qmpe2dCpEOLnXvMm1H1cvMuo/jr+Vp5Jvq9zT8/vpks4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2LC3BK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2LC3BK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C946BC2BCB2;
	Thu,  7 May 2026 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778150137;
	bh=f8iiIV+47WQMkhQVHjg2kccIWpWfcLf7fo/8BzKawrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J2LC3BK8qHxsB8G52K60qi5m+hF1+8llhCBj7twaNaze8YgBaTQGVvSHlXjUaltMM
	 WqiZG2K2FM/7jS+Mr98Ty760LzhIC8yrmJjfuBYXkxTKg3mppvEpLQTp+SqYGihZjn
	 Obj1mvhgv8K7bqv3YulPL74wZfB7aZ5g1P68SX2cpGMubt01rPmA8klvdsjtzAwLNK
	 vPalHRgwCoD9ShoOHQ8uIwLy1EBYIHYW6sL/kLh6PLcg0gYNbGuv13ata2BVaIE9FR
	 1c+869sI54A3An3DrALi1DXrcmcCHTyoCqcW8txPeLGJqZUsVh0LXcP7uPXY8bbGXQ
	 auaKRFhs4wTsQ==
Date: Thu, 7 May 2026 11:35:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support
 to adi,ltc2983
Message-ID: <20260507113528.607b52bf@jic23-huawei>
In-Reply-To: <SA5PR03MB8377E2EFE0F838C0EBD70AA6F63F2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-2-liviu.stan@analog.com>
	<20260428155819.3b56a3fa@jic23-huawei>
	<SA5PR03MB8377E2EFE0F838C0EBD70AA6F63F2@SA5PR03MB8377.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 May 2026 14:52:04 +0000
"Stan, Liviu" <Liviu.Stan@analog.com> wrote:

> Thanks for the comments, here are my answers:
>=20
> On 28 Apr 2026, Jonathan Cameron wrote:
> > I don't know much about these temp sensors, but how is this different
> > in practice from a 2-wire RTD?  Obviously one is copper and the other
> > probably much more precise platinum but does that matter to us? =20
>=20
> The main practical differences are:
>=20
> - The primary output is IIO_RESISTANCE, read from the resistance result
>    bank (0x0060-0x00AF). This bank is marked as reserved for the other=20
>    devices

That bit we can bury in the driver.

> - Sensor configuration bits 21:18 are hardcoded to 0b1001 for all
>    copper trace configurations. For the sub-ohm variant, bits 17:0 are=20
>    also zeroed; a >1=CE=A9 trace will have the excitation current and an=
=20
>    optional custom table in those bits. For the existing custom RTD and
>    thermistor types, the custom table is required by the binding. For
>    copper trace, it is optional (and forbidden for the sub-ohm variant).
>    And for leak detector as well it is optional.

So working around this would require some constraints in the binding
triggered off the compatible - but doable I think.

> - When a custom table is present, a second IIO_TEMP channel also
>    appears, reading from the temperature bank. Same dual-output
>    behavior for leak detector.

This feels like a driver detail rather than a binding one.

>=20
> That said, the hardware uses the same custom RTD mode (sensor
> type 18) internally.
>=20
> > I'd go with "LTC2983 and similar" for the title now as it's
> > to long. Leave the description to list amount more info.
> >
> > Alphabetical order and it might be worth thinking about switching this
> > to a bulleted list with one device per line as it'll make adding new on=
es
> > neater. (obviously they are already not in numeric order, so fix that t=
oo ;) =20
>=20
> Will do.
>=20
> > Is the absences of them enough to indicate this mode?  I.e. are there o=
ther
> > modes
> > with no specified excitation mode or custom rtd table?
> >=20
> > I'm trying to work out if we can map this to the existing binding for
> > custom rtd just be adding more constraints + making existing ones more
> > specific.
> >=20
> > I don't mind if we can't and have to add a new child node definition but
> > I'm not yet sure that's the case. =20
>=20
> You're right that the absence of both properties could imply sub-ohm mode=
,=20
> so I think we could drop the boolean. But the issue with reusing rtd@ is =
that=20
> adi,custom-rtd is currently required for sensor-type 18, and several=20
> RTD-specific properties (adi,number-of-wires, adi,rtd-curve,
> adi,rsense-share) have no meaning for copper trace and would need to be=20
> forbidden (they could also be ignored in the driver). In my opinion, sepa=
rate=20
> nodes for both copper trace and leak detectors would make sense, but I'm=
=20
> happy to go whichever way you prefer.

Ok. Sounds like we could do either but the different node type is cleaner.
So fair enough - go with that if the DT maintainers are happy with it.
Just make sure to lay out some of this reasoning in the commit message.
>=20
> > I'd avoid describing things as xx only as that tends to become wrong fa=
st!
> > Better to put that as a conditional only (as you have below)
> > Maybe here you can say, (some parts only) or something like that. =20
>=20
> Will switch to "some parts only".=20
>=20
> Thanks,
> Liviu

