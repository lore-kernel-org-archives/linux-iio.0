Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595492DF12F;
	Mon,  8 Jun 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780940211; cv=none; b=ixnEripUvp/qei1Er1gLjW3/8Uqr87XZD1pV/Ue6cIqBX5NbPgOJLugfmZzkBh+CDuy5m8yd1SpKWHAZvkkmaQpUIOOLSDe4J0WqjHQWrtqx37AiVBcAF40vLNefmdcexyuwtMPzYmBW1ENCeqOgVRg1FgtNWZmRe2OimE+2P5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780940211; c=relaxed/simple;
	bh=tpxsQXxcJIiQGk/EbZaG74+TlBrHnbasDHHU1BgZS9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V2fHHlMO8haIYTcIRkzVRbId9hT5IsBnUNnbZHObkpIzcqKnUDtAIVIoHBmB+UZuilnrH6qHCGPt6c4Cor7DdwvfZSh6NrDEzqV7LCeLo0VO1SN8REPVlGII2R93ftNMvQqGz/U0ETP7Esl49ayNoLymhvqRs29/0NfwT//LTXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EgJKctPr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EgJKctPr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 309C91F00893;
	Mon,  8 Jun 2026 17:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780940210;
	bh=/UCHEzrAWILVaSxepYyvlI/VLouUmZkJkxu7dHy0jwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EgJKctPrdtjlSkcvyhVho7COAnyBnUeEnYdXEKKwioUctsOqtp/fjeYUflJhb8TcG
	 K4KwP3CmCL9KImbDsZFKsV/L1eJV3rnZkBd6uxqWh/UA1vsKVIUUsVcuo+sJoR75FC
	 Qm0IXqqtAJTDdIdhx9ozWPLsdXisQrn10DUH2OqPQdsSOj8SG1rNI7OZ9zDPY9qiDM
	 1clTQrfAYdkLFdGsJ6KV9nq1XTS8+AWQR1Eej0oudei1uuEP6bj8e5dP8lvq1cBrWc
	 gj4c/cbAszFbgs8kQDAX+MrAd8/VXfmkevg8mlaHtlgC1cmVjievEIjsCCiiGPP0GN
	 pnnWCLa+7ia6w==
Date: Mon, 8 Jun 2026 18:36:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Siratul Islam <email@sirat.me>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko 
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v2] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <20260608183643.59bd4318@jic23-huawei>
In-Reply-To: <9d1f3538c3e42ad5dd19c4942123eb5423f1a884.camel@gmail.com>
References: <20260608124027.35879-1-email@sirat.me>
	<9d1f3538c3e42ad5dd19c4942123eb5423f1a884.camel@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 08 Jun 2026 16:30:07 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2026-06-08 at 18:40 +0600, Siratul Islam wrote:
> > Extract data-ready polling into a helper, fix regmap_read_poll_timeout()
> > argument alignment. No functional changes.
> >=20
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> > Signed-off-by: Siratul Islam <email@sirat.me>
> > --- =20
>=20
> Normally don't really like these one liner helper APIs but for this cases=
 where it's easy to mess
> up, it makes sense as if __we mess up__, we only need to fix one place.
>=20
> Just one comment from me. With that addressed, looks good:
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
>=20
The changes are fine, but there are really 3 different ones in here - so
at least 2 patches (see below for why not 3).

Jonathan

> > =C2=A0drivers/iio/proximity/vl53l1x-i2c.c | 36 ++++++++++++++----------=
-----
> > =C2=A01 file changed, 17 insertions(+), 19 deletions(-)
> >=20
> > diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximit=
y/vl53l1x-i2c.c
> > index 4d9cb3983dba..ed83999cf735 100644
> > --- a/drivers/iio/proximity/vl53l1x-i2c.c
> > +++ b/drivers/iio/proximity/vl53l1x-i2c.c
> > @@ -43,6 +43,7 @@
> > =C2=A0#define VL53L1X_REG_SOFT_RESET						0x0000
> > =C2=A0#define VL53L1X_REG_VHV_CONFIG__TIMEOUT_MACROP_LOOP_BOUND		0x0008
> > =C2=A0#define VL53L1X_REG_VHV_CONFIG__INIT					0x000B
> > +#define VL53L1X_REG_DEFAULT_CONFIG					0x002D
> > =C2=A0#define VL53L1X_REG_GPIO_HV_MUX__CTRL					0x0030
> > =C2=A0#define VL53L1X_REG_GPIO__TIO_HV_STATUS					0x0031
> > =C2=A0#define VL53L1X_REG_SYSTEM__INTERRUPT_CONFIG_GPIO			0x0046
> > @@ -64,7 +65,6 @@
> > =C2=A0#define VL53L1X_REG_RESULT__OSC_CALIBRATE_VAL				0x00DE
> > =C2=A0#define VL53L1X_REG_FIRMWARE__SYSTEM_STATUS				0x00E5
> > =C2=A0#define VL53L1X_REG_IDENTIFICATION__MODEL_ID				0x010F
> > -#define VL53L1X_REG_DEFAULT_CONFIG					0x002D

There are too many things in one patch. This move is unrelated to the rest
so needs to be on its own.

> > =C2=A0
> > =C2=A0#define VL53L1X_MODEL_ID_VAL		0xEACC
> > =C2=A0
> > @@ -191,6 +191,17 @@ static int vl53l1x_stop_ranging(struct vl53l1x_dat=
a *data)
> > =C2=A0			=C2=A0=C2=A0=C2=A0 VL53L1X_MODE_START_STOP);
> > =C2=A0}
> > =C2=A0
> > +static int vl53l1x_wait_data_ready(struct vl53l1x_data *data)
> > +{
> > +	unsigned int val;
> > +
> > +	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite =
Driver) */
> > +	return regmap_read_poll_timeout(data->regmap,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_GPIO__TIO_HV_STAT=
US,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, (val & 1) !=3D data->gpi=
o_polarity,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC, 1 * USEC_P=
ER_SEC);
> > +}
> > +
> > =C2=A0/*
> > =C2=A0 * Default configuration blob from ST's VL53L1X Ultra Lite Driver
> > =C2=A0 * (STSW-IMG009).
> > @@ -230,10 +241,9 @@ static int vl53l1x_chip_init(struct vl53l1x_data *=
data)
> > =C2=A0	}
> > =C2=A0
> > =C2=A0	ret =3D regmap_read_poll_timeout(data->regmap,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_FIRMWARE__SYSTEM_=
STATUS, val,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val & BIT(0),
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 100 * USEC_PER_MSEC);
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_FIRMWARE__SYSTEM_=
STATUS,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 val, val & BIT(0),
This one is using BIT(0) and above you are using the value of that (so 1).
I slightly prefer BIT(0) as I assume it is a single bit field.  Even better
would be to use proper field definitions.  So something like
#define VL53L1X_FIRMWARE__SYSTEM_STATUS_BOOTED BIT(0)

> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC, 100 * USEC=
_PER_MSEC); =20
>=20
> This looks unrelated to what you have on the commit message. Either drop =
it or mention it in the
> message (but I'm really not sure on the added value of the above change -=
 I guess more meaningful
> line break wrt the API arguments).

Separate patch. I don't mind all the reformatting together (so the register=
 definition
movement).  However if you follow the suggestion to use a define to name th=
e BIT(0)
field that can be combined with reflowing this, but not the move above.

>=20
> - Nuno S=C3=A1
>=20
> > =C2=A0	if (ret)
> > =C2=A0		return dev_err_probe(dev, ret, "firmware boot timeout\n");
> > =C2=A0
> > @@ -261,12 +271,7 @@ static int vl53l1x_chip_init(struct vl53l1x_data *=
data)
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > -	/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite =
Driver) */
> > -	ret =3D regmap_read_poll_timeout(data->regmap,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_GPIO__TIO_HV_STAT=
US, val,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (val & 1) !=3D data->gpio_pol=
arity,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC,
> > -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000 * USEC_PER_MSEC);
> > +	ret =3D vl53l1x_wait_data_ready(data);
> > =C2=A0	if (ret)
> > =C2=A0		return ret;
> > =C2=A0
> > @@ -461,14 +466,7 @@ static int vl53l1x_read_proximity(struct vl53l1x_d=
ata *data, int *val)
> > =C2=A0		if (!wait_for_completion_timeout(&data->completion, HZ))
> > =C2=A0			return -ETIMEDOUT;
> > =C2=A0	} else {
> > -		unsigned int rdy;
> > -
> > -		/* 1ms poll, 1s timeout covers max timing budgets (per ST Ultra Lite=
 Driver) */
> > -		ret =3D regmap_read_poll_timeout(data->regmap,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VL53L1X_REG_GPIO__TIO_HV_STA=
TUS, rdy,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (rdy & 1) !=3D data->gpio_po=
larity,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 * USEC_PER_MSEC,
> > -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1000 * USEC_PER_MSEC);
> > +		ret =3D vl53l1x_wait_data_ready(data);
> > =C2=A0		if (ret)
> > =C2=A0			return ret;
> > =C2=A0	} =20
>=20

