Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C16E3C585A;
	Tue, 12 May 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778601426; cv=none; b=SEdT0SLZYOptRyWPUvSM78qH8DvYDU1dp7YOkzFoiukJ68OSnaFKx8VgyhNd3ko4n/V4ORd7mQCVVGodtUnT7kQ8bX6MlrB6zTPInKjlsAH92gkQvgT6+u0yVkF97WZL8E3A4llSYMQcc6lJwmUKwUozfE7aokkHFIIuUl9aTbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778601426; c=relaxed/simple;
	bh=8tzh2aKDG7YCBM/EDfo3r6XGcRGEOLJQwcdsHTcOpoo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjAhwTa7xC0gNdJGW7zqiY6s013tgnt75WM7uHM80wEwSX6hkbkyX7NeNfxBE9Uy9aqdHFY0BGKwvpuLz7V2V01XcvcF2DwCqe3Yco5Ag091oezNNqnz+ATKiAHwE9IjYVbNjqHhxwp6YSL1gqcZbQUueAeDWWykypZZbhVKbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZAXThmL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZAXThmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22AD6C2BCC7;
	Tue, 12 May 2026 15:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778601426;
	bh=8tzh2aKDG7YCBM/EDfo3r6XGcRGEOLJQwcdsHTcOpoo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZAXThmL63eHFSapwA3EBH3wbK3TrdfMFlhAOnVf1cLIdPwsa0bY0lvNEANhTPSfi
	 eszBsMW5KUDi0Q8QLCzfNba6SfRmt/Ys2y+iqIy9JC+/xvX+P9FihQKfVqMRau6T1r
	 /oOO2qUMmuCA5v7aAf3pGUr5kXH0dOKxqvNXaLdqolqFLAIrkspvb2Zb/uUT0j7dyD
	 LL0uyuk8yaIzDZPJ0KGEH3MW/wvHlztO9lzOk1dwnqZsiQLR6xyvdHRkC/kdsypNq7
	 rrU8X4M64xNB5tqOYyyfwtsT66SSsuC6Yj3nZ3Mb8I+92WfNHbsu7txt5beLEOwUwp
	 j8nQ7rCjqD0Jw==
Date: Tue, 12 May 2026 16:56:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <20260512165654.5adeba0f@jic23-huawei>
In-Reply-To: <SA5PR03MB83776E4DF7B5542B40C3B925F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af3oezNmmBhI4Yu4@nsa>
	<SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af4LCQiqNaiMzFkX@nsa>
	<20260509154600.02e2d11a@jic23-huawei>
	<SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
	<20260511121820.3be9e635@jic23-huawei>
	<SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
	<agLhb-S2ISSjaopc@nsa>
	<SA5PR03MB837758532C0007A97121F6CCF6392@SA5PR03MB8377.namprd03.prod.outlook.com>
	<agMXiWA39tW9mZ2O@nsa>
	<SA5PR03MB83776E4DF7B5542B40C3B925F6392@SA5PR03MB8377.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 12:26:02 +0000
"Stan, Liviu" <Liviu.Stan@analog.com> wrote:

> On Tue, May 12, 2026, Nuno S=C3=A1 wrote:
> > > > What I'm not too convinced is that coverage is relative to what? We=
ll
> > > > it's a percentage so I guess we could not care and leave interpreta=
tion to
> > > > userspace (to know which device is dealing with). Still I wonder if=
 a
> > > > new iio_chan_info wouldn't be more appropriate? In this case applie=
d to
> > > > iio_resistance. So something like:
> > > >
> > > > in_resistance_coverage_ratio
> > > >
> > > > So it's clear what physical quantity coverage ratio is affecting. =
=20
> > >
> > > I still think a new channel type is the right approach. Consider copp=
er
> > > trace sensors - they also support a custom table, and when one is
> > > provided the chip outputs both a resistance result and a temperature
> > > result (the interpolation output), each in their own register bank. T=
he
> > > current approach handles that with separate IIO_RESISTANCE and
> > > IIO_TEMP channels. So, for consistency, if we use a chan_info
> > > attribute for the leak detector coverage output, we would need to do
> > > the same for the copper trace temperature output. Since IIO_TEMP
> > > makes sense for the interpolation result for copper traces and
> > > because it is a distinct physical quantity output by the chip, I thin=
k it
> > > would make the most sense that leak detectors follow the same
> > > pattern and create a separate IIO channel.
> > >
> > > What do you think?
> > > =20
> >=20
> > Yeah, makes sense. Jonathan already put it very nicely for the distinct
> > channel case. =20
>=20
> Sorry, I saw the last two messages only after I sent my reply.
>=20
> On Tue, May 12, 2026, Jonathan Cameron wrote:
> > > I do wonder if a complete type is what we want? How will we present i=
t?
> > >=20
> > > in_coverage_ratio?
> > >=20
> > > What I'm not too convinced is that coverage is relative to what? Well
> > > it's a percentage so I guess we could not care and leave interpretati=
on to
> > > userspace (to know which device is dealing with). Still I wonder if a
> > > new iio_chan_info wouldn't be more appropriate? In this case applied =
to
> > > iio_resistance. So something like:
> > >=20
> > > in_resistance_coverage_ratio =20
> >=20
> > I'm perhaps missing something - as far as I understand it there is no m=
eaningful
> > connection to resistance in what is being measured.
> > I think what you are proposing is similar to measuring current via volt=
age
> > drop over a sense resistor. We don't present that as modified voltage, =
we
> > present it as current.
> >
> > Here the thing being measured is coverage rather than resistance
> > so keeping resistance in there is confusing for the user.
> >
> > If we wanted a type to modify then we could do this as a modified area =
measurement.
> > Channel type IIO_AREA (which is new) and modifier IIO_MOD_RATIO (also n=
ew). =20
>=20
> On the implementation: you originally suggested IIO_COVERAGE_PERCENT,
> which would give in_coveragepercent0_raw in sysfs. The IIO_AREA + IIO_MOD=
_RATIO
> alternative would give in_area0_ratio_raw, which is more generic but less
> immediately obvious for a leak detector. Do you have a preference=20
> between the two?

I wonder what other reasonable area sensors we'll get in future?
Maybe more specific is better here - like humidityrelative (we've never had
an absolute humidity sensor because they are really hard to build!)

Jonathan
>=20
> Thanks,
> Liviu
>=20

