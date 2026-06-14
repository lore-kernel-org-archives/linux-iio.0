Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0902A28C869;
	Sun, 14 Jun 2026 17:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781459382; cv=none; b=TOfPnF20Ubd2h2HjNMc2CMIl1s7nBeWSQG9hJmP+ROJB5GjPs/jjF+Wsoro931cX6aWlBpe1aiIPfb98H1o815JpMu3qUdT1tJFsl7fqsp8ezMkCVn+hB0rPNTB2A7BrXNWOoHOoL0wV6OT4pgAHBLBZ/ksZWNxIvY1WH5M4hJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781459382; c=relaxed/simple;
	bh=dz5aTMn0X2SP76pbmzAcvNeU2pha/Q5WV4Y38bOjNmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZwlcjP6l+9UwXWdI3snXkP8OmUpLL+tqTzsXNfp9ElFoX/x0dZHvMDXoWBkA9A5PnePWERanunhb3VqXkUQoqR7OeCIHGbn+LyEpzSCpK60Rrde36ZO0ENKaEcsqYVcnxSoOwmvjwJr3GAAOIbskyFhYhRVhl3dcfgFw0sbwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUcBFTS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUcBFTS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652201F00A3A;
	Sun, 14 Jun 2026 17:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781459380;
	bh=G+F/0DogvXbjXbx/bS5cuTEdAvZCRp9DWjd+DfN91R4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BUcBFTS0SE2jYvs6t/hDulAevelTdhgDhJ4v8T00kuGa6D9d30AlOTz3eU0pEG1xx
	 AnO5oazZxKkVgu8K05P7RN6eifXVa17smTCHiVz7Zr29Lt5ZjJ/Gpjmch9OjXKaroo
	 hMqWKBj5HIM1j0pxVtnPveJfGhLolMozH/pJi6h/JrZD6V70Nz7iQOQ8U/ct7cNfVZ
	 nNnwrg7BsZWgNtZus0NMp6daZDVD2wgSCWiuzgyLoEwLqmPNH54KcElwxthF3IoeTR
	 p4uP/Wys/awNjwdjXzR7A46BepvinSr38UldDZHqwAcQe0rHeSt6Aw+SzOqUegw3bB
	 K5czONucmJFGA==
Date: Sun, 14 Jun 2026 18:49:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v2 12/12] iio: dac: ad5686: add gain control support
Message-ID: <20260614184932.1c9e0e13@jic23-huawei>
In-Reply-To: <luo2bvidr3h5gz5qb3ettl2rzzgjsdi6invgzgmm6dx7rki7gn@6faoaxv44vxr>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
	<20260609-ad5686-new-features-v2-12-70b423f5c76d@analog.com>
	<luo2bvidr3h5gz5qb3ettl2rzzgjsdi6invgzgmm6dx7rki7gn@6faoaxv44vxr>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Jun 2026 12:10:02 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 09/06/26 10:37, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential is=
sue(s) to consider:
> > - [Medium] ABI Violation: Exposing a writable sysfs attribute to fix a =
static hardware configuration.
> > - [Medium] State Inconsistency: `st->double_scale` is not rolled back i=
f hardware synchronization fails.
> > - [Low] Data Race: Lockless read of `st->double_scale` can race with co=
ncurrent writes.
> > --
> >=20
> > commit 7fefd2fd08838a6ee5a81a3a819607e02af9d85d
> > Author: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > iio: dac: ad5686: add gain control support
> >=20
> > This commit adds support for a 2x gain multiplier applied to the output
> > voltage. This provides a gain control through a bit field in the control
> > register or a dedicated GAIN pin, exposing the scale property as config=
urable.
> >  =20
> > > diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> > > index d9022c6a32016..d49390af71f90 100644
> > > --- a/drivers/iio/dac/ad5686.c
> > > +++ b/drivers/iio/dac/ad5686.c =20
> >=20
> > [ ... ]
> >  =20
> > > @@ -192,9 +196,14 @@ static int ad5686_read_raw(struct iio_dev *indio=
_dev,
> > >  			GENMASK(chan->scan_type.realbits - 1, 0);
> > >  		return IIO_VAL_INT;
> > >  	case IIO_CHAN_INFO_SCALE:
> > > -		*val =3D st->vref_mv;
> > > -		*val2 =3D chan->scan_type.realbits;
> > > -		return IIO_VAL_FRACTIONAL_LOG2;
> > > +		if (st->double_scale) {
> > > +			*val =3D st->scale_avail[2];
> > > +			*val2 =3D st->scale_avail[3];
> > > +		} else {
> > > +			*val =3D st->scale_avail[0];
> > > +			*val2 =3D st->scale_avail[1];
> > > +		}
> > > +		return IIO_VAL_INT_PLUS_NANO; =20
> >=20
> > [Severity: Low]
> > Is it possible for a data race to occur here?
> >=20
> > In ad5686_read_raw(), the mutable software state st->double_scale is re=
ad
> > to determine the returned scale values without holding the st->lock mut=
ex.
> >=20
> > Because st->double_scale can be concurrently modified by ad5686_write_r=
aw()
> > (which properly acquires st->lock), this can lead to reading a prematur=
ely
> > updated state before the hardware configuration has actually completed.=
 =20
>=20
> Valid concern, will add guarded mutex lock in read_raw to the previous pa=
tch.

I don't mind the locking being added as it makes it easier to reason about
but other than risk of a write tear or other silliness, I don't think the
report is valid.  The upshot of this race is that the read might report a
value just ahead of it being valid.  Given there is no roll back on error
(maybe there should be?) in write_raw() we are dealing with same visible
result as the we will get with the lock. One or other of read_raw / write_r=
aw
gets the lock and that dictates what is read.

Chances are for the read we aren't going to use the scale immediately so
it might be stale anyway if we really have multiple threads messing around
in sysfs for a device.

Perhaps I'm missing something?
> =20
> > >  	}
> > >  	return -EINVAL;
> > >  } =20
> >=20
> > [ ... ]
> >  =20
> > > @@ -216,6 +225,63 @@ static int ad5686_write_raw(struct iio_dev *indi=
o_dev,
> > > =20
> > >  		return ad5686_write(st, AD5686_CMD_WRITE_INPUT_N_UPDATE_N,
> > >  				    chan->address, val << chan->scan_type.shift);
> > > +	case IIO_CHAN_INFO_SCALE:
> > > +		if (val =3D=3D st->scale_avail[0] && val2 =3D=3D st->scale_avail[1=
])
> > > +			st->double_scale =3D false;
> > > +		else if (val =3D=3D st->scale_avail[2] && val2 =3D=3D st->scale_av=
ail[3])
> > > +			st->double_scale =3D true;
> > > +		else
> > > +			return -EINVAL;
> > > +
> > > +		switch (st->chip_info->regmap_type) {
> > > +		case AD5310_REGMAP:
> > > +			return ad5310_control_sync(st);
> > > +		case AD5683_REGMAP:
> > > +			return ad5683_control_sync(st); =20
> >=20
> > [Severity: Medium]
> > Should st->double_scale be restored to its previous value if the hardwa=
re
> > synchronization fails?
> >=20
> > In ad5686_write_raw(), st->double_scale is updated before the driver at=
tempts
> > to push the change to the DAC via ad5310_control_sync(st) or
> > ad5683_control_sync(st).=20
> >=20
> > If the underlying SPI/I2C write fails, the function immediately returns=
 the
> > error code without rolling back st->double_scale.
> >=20
> > This could cause the driver's cached state to diverge from the actual
> > hardware configuration, causing future reads of the scale to return the
> > incorrect updated value. =20
>=20
> Will ignore that and assume that SPI write error is a platform problem.
> At another attempt the cached value can take effect.

It's fine given you don't gate on the double_scale when repeating (so that
answers the above question I had on whether to roll back).

>=20
> >  =20
> > > +		case AD5686_REGMAP:
> > > +			/*
> > > +			 * Even if the gain pin is hardwired on the board, the
> > > +			 * user is able to control the scale such that it
> > > +			 * matches the actual gain setting.
> > > +			 */
> > > +			gpiod_set_value_cansleep(st->gain_gpio,
> > > +						 st->double_scale ? 1 : 0);
> > > +			return 0; =20
> >=20
> > [Severity: Medium]
> > Does this expose a writable sysfs attribute to fix a static hardware
> > configuration?
> >=20
> > The commit introduces a writable scale sysfs attribute to allow users t=
o manually
> > match the software scale to a hardwired gain pin. Static hardware prope=
rties
> > should typically be described via firmware properties (e.g., Device Tre=
e) so
> > the driver can expose the correct, immutable scale at initialization.
> >=20
> > If the GAIN GPIO is absent, writing to the scale attribute returns succ=
ess but
> > does not change the physical hardware state, leading to a silent desync=
hronization
> > between the reported scale and the actual physical DAC output.
> >=20
> > Could this mislead generic IIO clients by presenting multiple available=
 scales
> > that they believe they can dynamically toggle? =20
>=20
> No sure if this is a big concern (assuming that the user has knowledge of=
 the hardware).
> An option is to add another dt property to indicate that the gain is doub=
led in hardware.
> Such property cannot be defined alongside the ldac-gpios property.=20

hmm. I'm not bothered by fixed values on that gpio (we solve that with bind=
ing changes
on the odd occasion that actually turns up on real hardware).  If you want =
to support
that then great - there are a few examples doing that in tree.

However, if the thing is optional (or that new property you mention is set)=
 and we don't
have it we should not be exposing an interface that tries to set the value =
of the gpio.
So no gpio means:
- scale_avail should be based on assumption that pin is in some default (do=
cument that
  ideally in dt binding).
- write_raw() should return an error if a value other than that default is =
requested.

Adjust those if the property lets us know which way the pin is wired (high =
or low).

Jonathan



> =20
> > --=20
> > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-ad5686=
-new-features-v2-0-70b423f5c76d@analog.com?part=3D12 =20
>=20

