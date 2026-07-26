Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724503BBA1E
	for <linux-iio@vger.kernel.org>; Sun, 26 Jul 2026 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785091760; cv=none; b=Wbu9Qq9KdA146CyycH71j6+8d75R6llla5YswpfqF6dDfYECJhtwsrw3dhaCBuI1CEWYrQCVeJ716J7QGfVBeg3Z/zoELl+n2gwc/XkTNntrOtnMTN+oEF9gnpf7y4spxsxPfaXLp8K9EO2bDtKhKu4fGlvU58sHfseKqd20rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785091760; c=relaxed/simple;
	bh=6HPQ+OHfDuhLE6pOLO5ArxZMMMR/3xIZKeqFZwiR4NU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pStt41cPGDLsb9JQ5BSiiGh6YfiqyN9y90uh2Rd2SB6k/F1xppEY1J+lmGuxIvKaWcV3iXTHLPG/Ig3LDRtTQtixb2k8rLewEosTyd4q5I0pAMUGIwx9I/P3xqK3KIdnh58ID2NzW5eHcc7+XwhF5qcRM9nAhiQ5NBqNS5QCr58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cY48Ntac; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cY48Ntac"
Date: Mon, 27 Jul 2026 00:48:54 +0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785091746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HL/HwRm4HZ3iQRSQXXuOg0UOKqwrZG3RP/WYt+W5/lA=;
	b=cY48Ntac1WB4iGL1mzd30othOKtwsgzHUsxGWVDQpq9X5WJtXD03ghTZwsP3/GPzyVTyps
	sGcpfb6HoCIimqhN3yjeZ3a+o69YJ8ymhoTmiMgEibIdjwQzYst7TZq2Ge0KbgMYERpFBH
	b/ql1MhC45cx01l6bkt8POKVXZ8yRVo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Siratul Islam <siratul.islam@linux.dev>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lukas <lukas.metz@gmx.net>, David Lechner <dlechner@baylibre.com>,
 =?ISO-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
In-Reply-To: <20260726191833.67dcfac2@jic23-huawei>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net> <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net> <e84c4e047e104cca9b88dda791997ceecba1204c.camel@linux.dev> <amYVZtbxu4fjhBkx@berta-MS-7693> <6b3f1b6188afbb8ebf9576274894b5ed292eca92@linux.dev> <20260726191833.67dcfac2@jic23-huawei>
Message-ID: <871C1A8A-FF30-41B7-9643-E84E59B893F2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

On July 27, 2026 12:18:33 AM GMT+06:00, Jonathan Cameron <jic23@kernel=2Eor=
g> wrote:
>On Sun, 26 Jul 2026 17:01:51 +0000
>"Siratul Islam" <siratul=2Eislam@linux=2Edev> wrote:
>
>> July 26, 2026 at 8:10 PM, "Lukas" <lukas=2Emetz@gmx=2Enet> wrote:
>>=20
>>=20
>> >=20
>> > On Wed, Jul 08, 2026 at 09:58:13PM +0600, Siratul Islam wrote:
>> >  =20
>> > >=20
>> > > +
>> > >  + const struct reg_default reg_defaults[] =3D {
>> > >  + {
>> > >  + =2Ereg =3D CMD_SET(CMD_WRITE_UPDATE, 0),
>> > >  + =2Edef =3D info->default_output_reg,
>> > >  + },
>> > >  + {
>> > >  + =2Ereg =3D CMD_SET(CMD_WRITE_UPDATE, 1),
>> > >  + =2Edef =3D info->default_output_reg,
>> > >  + },
>> > >  + };
>> > >  +
>> > >  + const struct regmap_config regmap_config =3D {
>> > >  + =2Ereg_bits =3D 8,
>> > >  + =2Eval_bits =3D 16,
>> > >  +
>> > >  + =2Emax_register =3D CMD_REF << 3,
>> > >  + =2Ecache_type =3D REGCACHE_MAPLE,
>> > >  +
>> > >  + =2Evolatile_reg =3D dac8163_reg_false,
>> > >  +
>> > >  + =2Ereg_defaults =3D reg_defaults,
>> > >  + =2Enum_reg_defaults =3D ARRAY_SIZE(reg_defaults),
>> > >  + };
>> > >  Why are these defined inside probe? Should be defined outside the =
function=2E
>> > >  =20
>> > The default values after reset are different for the compatible devic=
es
>> > (0 for the dacxxx2 devices and mid-scale for the dacxxx3 devices)=2E
>> > So these are runtime dependent=2E The alternative would be to have tw=
o
>> > regmap_configs for the two device types and add these to the chip_inf=
o=2E
>> > Or do you have another suggestion? =20
>> You don't need two regmap_configs=2E The way I would do it is, move the=
 "regmap_config" out of probe and name it something=20
>> like "dac8563_regmap_config"=2E And in chip info struct, replace "defau=
lt_output_reg" with "reg_defaults[]"=2E=20
>> Then for each "dacxxxx_chip_info" define the appropriate "reg_defaults"=
 configuration=2E
>>=20
>> This way you can do
>>=20
>> struct regmap_config regmap_config =3D dac8563_regmap_config;
>> =2E=2E=2E
>> regmap_config=2Ereg_defaults =3D info->reg_defaults;
>> regmap_config=2Enum_reg_defaults =3D ARRAY_SIZE(info->reg_defaults);
>>=20
>> A bit of work, but it would ensure most of the work is done at compile =
time,
>> and we avoid reconstructing these sructs everytime probe runs=2E
>
>As this has come up, I'd favour just having two static const regmap_confi=
g structures
>and picking between them=2E  Obviously I haven't checked but I'd guess th=
at any
>overhead of extra text data for those is not that different to the extra =
code of the current
>approach=2E  Generally if you can make this sort of thing data rather tha=
n code it
>is a net gain=2E
>
>Jonathan
>
Fair enough=2E I was going for minimizing duplication=2E But if you are op=
en to duplicate structs, it makes it simpler and it may even read easier to=
o=2E
>>=20
=2E=2E=2E
>
--
Best regards,
Sirat
