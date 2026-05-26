Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7EF3AE1A9;
	Tue, 26 May 2026 16:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811591; cv=none; b=csFl633dnDmdbVTTi80OwTx2PZPuOSl0pH5gTXoD05jK58YDFdROUa0fSzGd19bQR9wuLOlaMLxsprAp+4Sbk5vFq1vOj6JYlSiPOjPXTFVD9gleG8QHHioeYZ3g0F6i7Rg4a7OdjJj4C3MysrG93sBCHrdvd8cj6rqO0oRCBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811591; c=relaxed/simple;
	bh=7xxWarushotb8r2Lo0elQUiL7Ce7RN73Lv3DXx4Mqew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ay7Nk1E2tG2GPzEK8sECK2hBMCR3JFXgTEw02K8Uea4lY79Ld+oAvlAquRj6MkeUYfa0nktR8Vd/JUBXwqXogElLzOx/49Mo43IoqnKKuX47DnHUhegUaEDayVBDsLtLLQ8jYcQKLXwHpTftiJ1nkhM8IRibt+Spna/lDLEgFf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOF03Vbi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOF03Vbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96EB1F000E9;
	Tue, 26 May 2026 16:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811589;
	bh=m6rwhSQk+Pffsy0MoQC+572YM3iGVxWe6GsXrPNijro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mOF03VbiZekvduY6LOqq1t86bVXi5iBlUJyc+G7uGBG1uGWHL45l7k8ZYhgZeqpce
	 1cs7JcC68NrAxjSAeNDtW79TtZxFE6hGpvL6PYu76MGBFj3Mj/4USxnzRJimPjTvWj
	 u5JkLJSsycnyG1Z2uvYRap2IkUemoGqH03dmJ/KPNWdzoX9nzk4vqK/msFL8W+SX8S
	 hIQHgOAfB3RckJxrPKYcq0TdS+VB1p4SZhgRjUDDspVwf/zSBi9IW82QZfCi5Kc2Aa
	 TXTyt0Wv+30bGJc1Jwnwdo9iyIaSXspU6AEPvffI0zuUQk8WF7xiDJkGq83HrMfzZ1
	 Q/xrkFiv7iAjw==
Date: Tue, 26 May 2026 17:06:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wadim Mueller <wafgo01@gmail.com>, lars@metafoo.de,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow
 sensor driver
Message-ID: <20260526170618.14f45e2d@jic23-huawei>
In-Reply-To: <4349f634-dd7b-468a-912c-5ceb8a283954@roeck-us.net>
References: <20260524205112.26638-1-wafgo01@gmail.com>
	<20260524205112.26638-4-wafgo01@gmail.com>
	<4349f634-dd7b-468a-912c-5ceb8a283954@roeck-us.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 24 May 2026 14:40:51 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On 5/24/26 13:49, Wadim Mueller wrote:
> > From: Wadim Mueller <wadim.mueller@cmblu.de>
> >=20
> > Add an IIO driver for the Sensirion SLF3S family of digital
> > liquid-flow sensors.  The supported sub-types (SLF3S-0600F,
> > SLF3S-4000B) share the same register map and command set and are
> > distinguished only by the flow scale; the variant is detected at
> > probe time from the product-information register.
> >  =20
> Sice you are at it, it might make sense to also support SLF3S-1300F.
>=20
>=20
> > The driver exposes two IIO channels:
> >    - in_volumeflow_raw / in_volumeflow_scale (litres per second)
> >    - in_temp_raw       / in_temp_scale       (milli-degC)
> >=20
> > Continuous measurement mode is started in probe and stopped via
> > devm-action; read_raw() fetches the most recent sample on demand.
> >=20
> > Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
> > ---
> >   drivers/iio/Kconfig       |   1 +
> >   drivers/iio/Makefile      |   1 +
> >   drivers/iio/flow/Kconfig  |  22 ++++
> >   drivers/iio/flow/Makefile |   7 +
> >   drivers/iio/flow/slf3x.c  | 264 +++++++++++++++++++++++++++++++++++++=
+ =20
>=20
> What does the "X" refer to ? Why not "S" ?

Absolutely - no wild cards in file names or indeed in variables etc.
Just pick a part to name after.  Wild cards go wrong far too often!

A couple more follow ups below to some of what Guenter noted

> > +static const u8 slf3x_cmd_stop[]	=3D { 0x3f, 0xf9 };
> > +
> > +DECLARE_CRC8_TABLE(slf3x_crc_table);
> > +
> > +struct slf3x_variant {
> > +	u8 sub_type;
> > +	const char *name;
> > +	/*
> > +	 * Flow scale exposed via IIO_CHAN_INFO_SCALE in litres per second
> > +	 * per LSB, encoded as IIO_VAL_FRACTIONAL (num / den).  The encoding
> > +	 * comes from the Sensirion datasheet's "scale factor" (ticks per
> > +	 * ml/min) combined with the 1 ml/min =3D 1/60000 l/s conversion.
> > +	 */ =20
>=20
> Not my call to make, but at least the Sensirion sensors all talk about
> flow rate per minute, not per second. A Google search suggests that
> flow rate is normally measured per minute or even per hour, and that
> per-second measurements are typically only used for large-scale engineeri=
ng,
> rivers, dams, and rapid industrial chemical dosing. Taking SLF3S-0600F
> as example, it measures up to =C2=B12000 =C2=B5l/min (!). Even Sensirion'=
s gas
> sensors use per-minute flow rates.
>=20
> Any special reason to use a per-second rate ?

As I just replied to the cover letter - things in IIO that have relationship
to time (delays, integration times etc) are in seconds.=20
Would be very confusing to mix and match. In general for new channel types
we stick to SI units without multipliers.

>=20
> > +	int scale_num;
> > +	int scale_den;
> > +};

> > +			dev_err(&client->dev,
> > +				"product-info CRC mismatch at byte %d\n", i);
> > +			return -EIO;
> > +		}
> > +	}
> > +
> > +	if (buf[SLF3X_FAMILY_BYTE] !=3D SLF3X_FAMILY_ID) {
> > +		dev_err(&client->dev,
> > +			"unexpected device family 0x%02x\n",
> > +			buf[SLF3X_FAMILY_BYTE]);
> > +		return -ENODEV;

Similar to below. This can't be an error or we break fallback
compatibles in DT. There are historic drivers that do this that
we haven't fixed up yet - but no new ones please!

> > +	}
> > +
> > +	for (i =3D 0; i < ARRAY_SIZE(slf3x_variants); i++) {
> > +		if (buf[SLF3X_SUBTYPE_BYTE] =3D=3D slf3x_variants[i].sub_type) {
> > +			sf->variant =3D &slf3x_variants[i];
> > +			return 0;
> > +		}
> > +	}
> > +
> > +	dev_err(&client->dev, "unsupported SLF3x sub-type 0x%02x\n",
> > +		buf[SLF3X_SUBTYPE_BYTE]); =20
>=20
> Not my call to make, but the driver is way too noisy for my liking.
>=20
Given the need to support fallback compatibles from device tree we don't
fail at all on mismatches as that prevents use supporting a new fully
backwards compatible (other than IDs) part in older kernels.

Whether a dev_info() or dev_dbg() is appropriate for such a case is
less obvious but definitely dev_err().

> > +	return -ENODEV;
and it's not an error to read an unexpected ID.
> > +}


